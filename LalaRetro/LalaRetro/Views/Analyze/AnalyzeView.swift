import SwiftUI

struct AnalyzeView: View {
    @State private var viewModel = AnalyzeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("analyze")
                                .font(.system(.title2, design: .monospaced).bold())
                                .foregroundStyle(.black)
                            Text("cross-reference reactions to find triggers")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        if viewModel.isLoading {
                            HStack(spacing: 6) {
                                ProgressView()
                                    .tint(Color(red: 0.75, green: 0.55, blue: 0.85))
                                Text("analyzing...")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                        } else if !viewModel.hasEnoughData {
                            VStack(spacing: 14) {
                                Text("not enough data yet")
                                    .font(.system(.subheadline, design: .monospaced).bold())
                                    .foregroundStyle(.black)
                                Text("log reactions to at least 2 products")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.gray)

                                // Progress
                                HStack(spacing: 8) {
                                    Text("[\(viewModel.reactionCount)/2]")
                                        .font(.system(.caption, design: .monospaced).bold())
                                        .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                                    GeometryReader { geo in
                                        ZStack(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 2)
                                                .fill(Color(red: 0.93, green: 0.9, blue: 0.97))
                                                .frame(height: 4)
                                            RoundedRectangle(cornerRadius: 2)
                                                .fill(Color(red: 0.75, green: 0.55, blue: 0.85))
                                                .frame(width: geo.size.width * CGFloat(viewModel.reactionCount) / 2.0, height: 4)
                                        }
                                    }
                                    .frame(height: 4)
                                }
                                .padding(.horizontal, 20)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(28)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        } else if viewModel.suspects.isEmpty {
                            VStack(spacing: 10) {
                                Text("[clear]")
                                    .font(.system(.subheadline, design: .monospaced).bold())
                                    .foregroundStyle(Color(red: 0.3, green: 0.7, blue: 0.4))
                                Text("no common ingredients found")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.black)
                                Text("your reaction products don't share suspects")
                                    .font(.system(.caption2, design: .monospaced))
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(28)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        } else {
                            Text("-- suspect ingredients --")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            ForEach(viewModel.suspects) { suspect in
                                SuspectCard(suspect: suspect)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            await viewModel.analyze()
        }
    }
}

struct SuspectCard: View {
    let suspect: SuspectResult

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(suspect.ingredientName)
                    .font(.system(.subheadline, design: .monospaced).bold())
                    .foregroundStyle(suspicionColor)
                Text("in \(suspect.foundInProducts.count) products")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(.gray)
            }

            Spacer()

            Text(suspect.percentageText)
                .font(.system(.subheadline, design: .monospaced).bold())
                .foregroundStyle(suspicionColor)
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(suspicionColor.opacity(0.25), lineWidth: 1)
        )
    }

    private var suspicionColor: Color {
        if suspect.suspicionScore >= 0.8 { return Color(red: 0.75, green: 0.2, blue: 0.45) }
        if suspect.suspicionScore >= 0.5 { return Color(red: 0.85, green: 0.55, blue: 0.2) }
        return Color(red: 0.75, green: 0.55, blue: 0.85)
    }
}

#Preview {
    AnalyzeView()
}
