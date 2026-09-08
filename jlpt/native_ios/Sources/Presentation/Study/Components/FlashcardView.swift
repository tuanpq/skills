import SwiftUI

/// A tappable card that flips between `front` (word/kanji/pattern) and `back` (meaning/details).
struct FlashcardView<Front: View, Back: View>: View {
    let isFlipped: Bool
    let onTap: () -> Void
    @ViewBuilder let front: () -> Front
    @ViewBuilder let back: () -> Back

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.secondary.opacity(0.12))
                .shadow(radius: 3)

            Group {
                if isFlipped {
                    back().rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                } else {
                    front()
                }
            }
            .padding(24)
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.35), value: isFlipped)
        .onTapGesture(perform: onTap)
    }
}
