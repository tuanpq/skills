import Foundation

/// Manual composition root (Swift has no Hilt/Dagger): builds the networking stack once, wires the
/// `data` implementations behind the `domain` repository protocols, and exposes ready-to-use case
/// structs for ViewModels to receive via initializer injection.
final class AppContainer {
    let observeSession: ObserveSessionUseCase
    let login: LoginUseCase
    let register: RegisterUseCase
    let logout: LogoutUseCase

    let getVocabulary: GetVocabularyUseCase
    let getKanji: GetKanjiUseCase
    let getGrammar: GetGrammarUseCase
    let getPassage: GetPassageUseCase
    let getListeningAudio: GetListeningAudioUseCase

    let getVocabularyStudy: GetVocabularyStudyUseCase
    let getKanjiStudy: GetKanjiStudyUseCase
    let getGrammarStudy: GetGrammarStudyUseCase
    let updateStudyProgress: UpdateStudyProgressUseCase
    let submitReview: SubmitReviewUseCase
    let getProgressSummary: GetProgressSummaryUseCase

    let listExams: ListExamsUseCase
    let getExamDetail: GetExamDetailUseCase
    let startAttempt: StartAttemptUseCase
    let getAttempt: GetAttemptUseCase
    let submitAnswer: SubmitAnswerUseCase
    let submitAttempt: SubmitAttemptUseCase
    let getAttemptResult: GetAttemptResultUseCase
    let getAttemptHistory: GetAttemptHistoryUseCase

    init() {
        let tokenStore = TokenStore()
        let apiClient = APIClient(tokenStore: tokenStore)

        let authRepository: AuthRepository = AuthRepositoryImpl(api: AuthAPI(client: apiClient), tokenStore: tokenStore)
        let contentRepository: ContentRepository = ContentRepositoryImpl(api: ContentAPI(client: apiClient))
        let studyRepository: StudyRepository = StudyRepositoryImpl(api: StudyAPI(client: apiClient))
        let examRepository: ExamRepository = ExamRepositoryImpl(api: ExamAPI(client: apiClient))

        observeSession = ObserveSessionUseCase(repository: authRepository)
        login = LoginUseCase(repository: authRepository)
        register = RegisterUseCase(repository: authRepository)
        logout = LogoutUseCase(repository: authRepository)

        getVocabulary = GetVocabularyUseCase(repository: contentRepository)
        getKanji = GetKanjiUseCase(repository: contentRepository)
        getGrammar = GetGrammarUseCase(repository: contentRepository)
        getPassage = GetPassageUseCase(repository: contentRepository)
        getListeningAudio = GetListeningAudioUseCase(repository: contentRepository)

        getVocabularyStudy = GetVocabularyStudyUseCase(repository: studyRepository)
        getKanjiStudy = GetKanjiStudyUseCase(repository: studyRepository)
        getGrammarStudy = GetGrammarStudyUseCase(repository: studyRepository)
        updateStudyProgress = UpdateStudyProgressUseCase(repository: studyRepository)
        submitReview = SubmitReviewUseCase(repository: studyRepository)
        getProgressSummary = GetProgressSummaryUseCase(repository: studyRepository)

        listExams = ListExamsUseCase(repository: examRepository)
        getExamDetail = GetExamDetailUseCase(repository: examRepository)
        startAttempt = StartAttemptUseCase(repository: examRepository)
        getAttempt = GetAttemptUseCase(repository: examRepository)
        submitAnswer = SubmitAnswerUseCase(repository: examRepository)
        submitAttempt = SubmitAttemptUseCase(repository: examRepository)
        getAttemptResult = GetAttemptResultUseCase(repository: examRepository)
        getAttemptHistory = GetAttemptHistoryUseCase(repository: examRepository)
    }
}
