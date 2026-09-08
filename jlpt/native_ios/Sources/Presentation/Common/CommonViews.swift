import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorStateView: View {
    let message: String
    var onRetry: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
            if let onRetry {
                Button("Retry", action: onRetry)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EmptyStateView: View {
    let message: String

    var body: some View {
        Text(message)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LevelPicker: View {
    @Binding var selected: JlptLevel

    var body: some View {
        Menu {
            ForEach(JlptLevel.allCases) { level in
                Button(level.rawValue) { selected = level }
            }
        } label: {
            HStack {
                Text(selected.rawValue)
                Image(systemName: "chevron.down")
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
            )
        }
    }
}
