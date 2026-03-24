import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var suspects: [String] = []
    @State private var interactions: [InteractionResult] = []
    @State private var showAllInteractions = false

    private var highCount: Int { interactions.filter { $0.interaction.severity == .high }.count }
    private var mediumCount: Int { interactions.filter { $0.interaction.severity == .medium }.count }
    private var lowCount: Int { interactions.filter { $0.interaction.severity == .low }.count }

    private var visibleInteractions: [InteractionResult] {
        if showAllInteractions { return interactions }
        return Array(interactions.prefix(3))
    }

    var body: some View {
        ZStack {
            GradientBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.name)
                            .font(.system(.title3, design: .monospaced).bold())
                            .foregroundStyle(.black)
                        Text(product.brand)
                            .font(.system(.subheadline, design: .monospaced))
                            .foregroundStyle(.gray)
                    }

                    // Warning banner — watched ingredients
                    let flagged = product.ingredients.filter { suspects.contains($0.lowercased()) }
                    if !flagged.isEmpty {
                        HStack(spacing: 8) {
                            Text("!")
                                .font(.system(.body, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.75, green: 0.2, blue: 0.45))
                            Text("\(flagged.count) watched ingredient\(flagged.count > 1 ? "s" : "") found")
                                .font(.system(.caption, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.75, green: 0.2, blue: 0.45))
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 0.98, green: 0.92, blue: 0.95))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(Color(red: 0.75, green: 0.2, blue: 0.45).opacity(0.2), lineWidth: 1)
                        )
                    }

                    // Interaction warnings
                    if !interactions.isEmpty {
                        interactionSection
                    }

                    // Ingredients
                    VStack(alignment: .leading, spacing: 8) {
                        Text("-- ingredients (\(product.ingredients.count)) --")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.gray)

                        FlowLayout(spacing: 5) {
                            ForEach(product.ingredients, id: \.self) { ingredient in
                                IngredientBadge(
                                    name: ingredient,
                                    isSuspect: suspects.contains(ingredient.lowercased()),
                                    isHighlighted: interactions.contains { r in
                                        r.matchedA == ingredient.lowercased() || r.matchedB == ingredient.lowercased()
                                    }
                                )
                            }
                        }
                    }

                    if product.ingredients.isEmpty {
                        Text("no ingredient data available.")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            suspects = LocalStorageService.shared.getSuspects()
            let product = product
            let result = await Task.detached {
                InteractionService.shared.checkInteractions(for: product)
            }.value
            interactions = result
        }
    }

    // MARK: - Interaction Section

    private var interactionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header with severity summary
            HStack(spacing: 10) {
                Text("-- interactions --")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.gray)

                Spacer()

                if highCount > 0 {
                    severityPill(count: highCount, severity: .high)
                }
                if mediumCount > 0 {
                    severityPill(count: mediumCount, severity: .medium)
                }
                if lowCount > 0 {
                    severityPill(count: lowCount, severity: .low)
                }
            }

            ForEach(visibleInteractions) { result in
                InteractionCard(result: result)
            }

            if interactions.count > 3 {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showAllInteractions.toggle()
                    }
                } label: {
                    Text(showAllInteractions ? "show less" : "show all \(interactions.count) interactions")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
        }
    }

    private func severityPill(count: Int, severity: IngredientInteraction.Severity) -> some View {
        Text("\(count) \(severity.rawValue)")
            .font(.system(.caption2, design: .monospaced).bold())
            .foregroundStyle(severityColor(severity))
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(severityBackground(severity))
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

// MARK: - Interaction Card (shared between views)

struct InteractionCard: View {
    let result: InteractionResult

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Circle()
                    .fill(severityColor(result.interaction.severity))
                    .frame(width: 6, height: 6)

                Text("\(result.matchedA) + \(result.matchedB)")
                    .font(.system(.caption, design: .monospaced).bold())
                    .foregroundStyle(severityColor(result.interaction.severity))
            }

            if result.isSameProduct {
                Text("within \(result.productNameA)")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(.gray)
            } else {
                Text("\(result.productNameA) + \(result.productNameB)")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(.gray)
            }

            Text(result.interaction.effect)
                .font(.system(.caption2, design: .monospaced))
                .foregroundStyle(Color(red: 0.35, green: 0.3, blue: 0.45))
                .fixedSize(horizontal: false, vertical: true)

            HStack(alignment: .top, spacing: 4) {
                Text(">")
                    .font(.system(.caption2, design: .monospaced).bold())
                    .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                Text(result.interaction.advice)
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(severityBackground(result.interaction.severity))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(severityColor(result.interaction.severity).opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Severity colors (shared)

func severityColor(_ severity: IngredientInteraction.Severity) -> Color {
    switch severity {
    case .high: Color(red: 0.75, green: 0.2, blue: 0.2)
    case .medium: Color(red: 0.85, green: 0.55, blue: 0.2)
    case .low: Color(red: 0.55, green: 0.55, blue: 0.6)
    }
}

func severityBackground(_ severity: IngredientInteraction.Severity) -> Color {
    switch severity {
    case .high: Color(red: 0.98, green: 0.93, blue: 0.93)
    case .medium: Color(red: 0.99, green: 0.96, blue: 0.92)
    case .low: Color(red: 0.97, green: 0.97, blue: 0.97)
    }
}

// MARK: - FlowLayout

struct FlowLayout: Layout {
    var spacing: CGFloat = 5

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (positions: [CGPoint], size: CGSize) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var maxX: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxX = max(maxX, x)
        }

        return (positions, CGSize(width: maxX, height: y + rowHeight))
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: .example)
    }
}
