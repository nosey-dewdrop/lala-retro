import SwiftUI

struct AnalyzeView: View {
    @State private var viewModel = AnalyzeViewModel()
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                VStack(spacing: 0) {
                    // Segment picker
                    HStack(spacing: 0) {
                        segmentButton(title: "suspects", index: 0)
                        segmentButton(title: "routine check", index: 1)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            if selectedTab == 0 {
                                suspectsSection
                            } else {
                                routineCheckSection
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.analyze()
            viewModel.loadProducts()
        }
    }

    private func segmentButton(title: String, index: Int) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                selectedTab = index
            }
        } label: {
            Text(title)
                .font(.system(.caption, design: .monospaced).bold())
                .foregroundStyle(selectedTab == index ? .white : Color(red: 0.75, green: 0.55, blue: 0.85))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(selectedTab == index ? Color(red: 0.75, green: 0.55, blue: 0.85) : Color(red: 0.94, green: 0.9, blue: 0.98))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }

    // MARK: - Suspects Section

    private var suspectsSection: some View {
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
    }

    // MARK: - Routine Check Section

    private var routineCheckSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text("routine check")
                    .font(.system(.title2, design: .monospaced).bold())
                    .foregroundStyle(.black)
                Text("select products you use together")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.gray)
            }

            if viewModel.allProducts.isEmpty {
                VStack(spacing: 10) {
                    Text("no products yet")
                        .font(.system(.subheadline, design: .monospaced).bold())
                        .foregroundStyle(.black)
                    Text("add products first via search or scan")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(28)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
            } else {
                // Product picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("-- your products (\(viewModel.selectedRoutineIds.count) selected) --")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.gray)

                    ForEach(viewModel.allProducts, id: \.id) { product in
                        routineProductRow(product)
                    }
                }

                // Check button
                if viewModel.selectedRoutineIds.count >= 2 {
                    Button {
                        Task { await viewModel.checkRoutine() }
                    } label: {
                        HStack(spacing: 6) {
                            if viewModel.isCheckingRoutine {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(0.8)
                            }
                            Text(viewModel.isCheckingRoutine ? "checking..." : "check interactions")
                                .font(.system(.subheadline, design: .monospaced).bold())
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(red: 0.75, green: 0.55, blue: 0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .disabled(viewModel.isCheckingRoutine)
                } else if viewModel.selectedRoutineIds.count == 1 {
                    Text("select at least 2 products to check")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                }

                // Results
                if viewModel.hasCheckedRoutine {
                    if viewModel.routineInteractions.isEmpty {
                        VStack(spacing: 10) {
                            Text("[safe]")
                                .font(.system(.subheadline, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.3, green: 0.7, blue: 0.4))
                            Text("no interactions found")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.black)
                            Text("these products are safe to use together")
                                .font(.system(.caption2, design: .monospaced))
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(28)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.3, green: 0.7, blue: 0.4).opacity(0.3), lineWidth: 1))
                    } else {
                        routineResultsSection
                    }
                }
            }
        }
    }

    private func routineProductRow(_ product: Product) -> some View {
        let isSelected = viewModel.selectedRoutineIds.contains(product.id ?? "")

        return Button {
            viewModel.toggleRoutineProduct(product)
        } label: {
            HStack(spacing: 10) {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .font(.system(.body))
                    .foregroundStyle(isSelected ? Color(red: 0.75, green: 0.55, blue: 0.85) : Color(red: 0.8, green: 0.77, blue: 0.85))

                VStack(alignment: .leading, spacing: 2) {
                    Text(product.name)
                        .font(.system(.caption, design: .monospaced).bold())
                        .foregroundStyle(.black)
                    Text(product.brand)
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundStyle(.gray)
                }

                Spacer()

                Text("\(product.ingredients.count)")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(.gray)
            }
            .padding(10)
            .background(isSelected ? Color(red: 0.96, green: 0.94, blue: 0.99) : .white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(isSelected ? Color(red: 0.75, green: 0.55, blue: 0.85).opacity(0.3) : Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1)
            )
        }
    }

    private var routineResultsSection: some View {
        let high = viewModel.routineInteractions.filter { $0.interaction.severity == .high }
        let medium = viewModel.routineInteractions.filter { $0.interaction.severity == .medium }
        let low = viewModel.routineInteractions.filter { $0.interaction.severity == .low }

        return VStack(alignment: .leading, spacing: 12) {
            // Summary bar
            HStack(spacing: 10) {
                Text("-- results --")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.gray)

                Spacer()

                if !high.isEmpty {
                    Text("\(high.count) high")
                        .font(.system(.caption2, design: .monospaced).bold())
                        .foregroundStyle(severityColor(.high))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(severityBackground(.high))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                if !medium.isEmpty {
                    Text("\(medium.count) medium")
                        .font(.system(.caption2, design: .monospaced).bold())
                        .foregroundStyle(severityColor(.medium))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(severityBackground(.medium))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                if !low.isEmpty {
                    Text("\(low.count) low")
                        .font(.system(.caption2, design: .monospaced).bold())
                        .foregroundStyle(severityColor(.low))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(severityBackground(.low))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
            }

            ForEach(viewModel.routineInteractions) { result in
                InteractionCard(result: result)
            }
        }
    }
}

// MARK: - Suspect Card

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
