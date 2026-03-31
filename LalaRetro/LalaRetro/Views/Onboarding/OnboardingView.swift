import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0

    private let pages: [(icon: String, title: String, description: String)] = [
        ("magnifyingglass", "add your products", "search by name, scan a barcode, or photograph the ingredient list with your camera."),
        ("exclamationmark.triangle", "log reactions", "when your skin reacts, tell us which products you used and what happened."),
        ("flask", "find the trigger", "we cross-reference your reactions to find which ingredient keeps showing up.")
    ]

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 0) {
                Spacer()

                // Icon
                Image(systemName: pages[currentPage].icon)
                    .font(.system(size: 56))
                    .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                    .frame(height: 80)
                    .padding(.bottom, 32)

                // Title
                Text(pages[currentPage].title)
                    .font(.system(.title2, design: .monospaced).bold())
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                // Description
                Text(pages[currentPage].description)
                    .font(.system(.subheadline, design: .monospaced))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 32)

                Spacer()

                // Page indicators
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage
                                  ? Color(red: 0.75, green: 0.55, blue: 0.85)
                                  : Color(red: 0.9, green: 0.87, blue: 0.95))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 32)

                // Button
                Button {
                    if currentPage < pages.count - 1 {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            currentPage += 1
                        }
                    } else {
                        hasCompletedOnboarding = true
                    }
                } label: {
                    Text(currentPage < pages.count - 1 ? "next" : "get started")
                        .font(.system(.subheadline, design: .monospaced).bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(.horizontal, 24)

                // Skip
                if currentPage < pages.count - 1 {
                    Button {
                        hasCompletedOnboarding = true
                    } label: {
                        Text("skip")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.gray)
                    }
                    .padding(.top, 12)
                }

                Spacer().frame(height: 48)
            }
        }
    }
}
