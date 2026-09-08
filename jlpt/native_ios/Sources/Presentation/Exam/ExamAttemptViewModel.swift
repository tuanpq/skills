import Foundation
import AVFoundation

@MainActor
final class ExamAttemptViewModel: ObservableObject {
    let attemptId: Int64

    @Published private(set) var attempt: Attempt?
    @Published var currentIndex = 0
    @Published private(set) var selectedAnswers: [Int64: Int64] = [:]
    @Published private(set) var remainingSeconds: Int?
    @Published private(set) var isLoading = true
    @Published private(set) var isSubmitting = false
    @Published var error: String?
    @Published private(set) var playingAudioId: Int64?
    @Published private(set) var isAudioPlaying = false
    @Published private(set) var isAudioLoading = false

    private let getAttemptUseCase: GetAttemptUseCase
    private let getExamDetailUseCase: GetExamDetailUseCase
    private let submitAnswerUseCase: SubmitAnswerUseCase
    private let submitAttemptUseCase: SubmitAttemptUseCase
    private let getListeningAudioUseCase: GetListeningAudioUseCase

    private var timerTask: Task<Void, Never>?
    private let player = AVPlayer()
    private var loadedAudioId: Int64?
    private var playerObserver: NSKeyValueObservation?

    init(container: AppContainer, attemptId: Int64) {
        self.attemptId = attemptId
        getAttemptUseCase = container.getAttempt
        getExamDetailUseCase = container.getExamDetail
        submitAnswerUseCase = container.submitAnswer
        submitAttemptUseCase = container.submitAttempt
        getListeningAudioUseCase = container.getListeningAudio

        playerObserver = player.observe(\.timeControlStatus, options: [.new]) { [weak self] player, _ in
            Task { @MainActor in
                self?.isAudioPlaying = player.timeControlStatus == .playing
            }
        }
        Task { await load() }
    }

    func load() async {
        isLoading = true
        error = nil
        let result = await getAttemptUseCase(id: attemptId)
        isLoading = false
        switch result {
        case .success(let loaded):
            attempt = loaded
            startTimer(for: loaded)
        case .failure(let message, _):
            error = message
        }
    }

    private func startTimer(for attempt: Attempt) {
        guard timerTask == nil else { return }
        timerTask = Task {
            let examResult = await getExamDetailUseCase(id: attempt.examId)
            guard case .success(let detail) = examResult else { return }
            let deadline = attempt.startedAt.addingTimeInterval(TimeInterval(detail.timeLimitMinutes * 60))

            while !Task.isCancelled {
                let remaining = Int(deadline.timeIntervalSinceNow)
                if remaining <= 0 {
                    remainingSeconds = 0
                    await submit { _ in }
                    break
                }
                remainingSeconds = remaining
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }

    func goTo(_ index: Int) {
        let count = attempt?.questions.count ?? 0
        currentIndex = max(0, min(index, count - 1))
    }

    func next() { goTo(currentIndex + 1) }
    func previous() { goTo(currentIndex - 1) }

    func selectAnswer(questionId: Int64, choiceId: Int64) {
        selectedAnswers[questionId] = choiceId
        Task { _ = await submitAnswerUseCase(attemptId: attemptId, questionId: questionId, selectedChoiceId: choiceId) }
    }

    func submit(onSubmitted: @escaping (Int64) -> Void) async {
        isSubmitting = true
        error = nil
        let result = await submitAttemptUseCase(attemptId: attemptId)
        isSubmitting = false
        switch result {
        case .success(let attemptResult):
            timerTask?.cancel()
            onSubmitted(attemptResult.attemptId)
        case .failure(let message, _):
            error = message
        }
    }

    /// Toggles play/pause for one listening-question's audio, fetching its presigned URL on first play.
    func toggleAudio(_ audioId: Int64) {
        if loadedAudioId == audioId {
            if player.timeControlStatus == .playing {
                player.pause()
            } else {
                player.play()
            }
            playingAudioId = audioId
            return
        }
        Task {
            isAudioLoading = true
            playingAudioId = audioId
            error = nil
            let result = await getListeningAudioUseCase(id: audioId)
            isAudioLoading = false
            switch result {
            case .success(let audio):
                guard let url = URL(string: audio.audioUrl) else { return }
                loadedAudioId = audioId
                let item = AVPlayerItem(url: url)
                player.replaceCurrentItem(with: item)
                player.play()
            case .failure(let message, _):
                playingAudioId = nil
                error = message
            }
        }
    }

    func stopAudio() {
        player.pause()
    }

    deinit {
        timerTask?.cancel()
    }
}
