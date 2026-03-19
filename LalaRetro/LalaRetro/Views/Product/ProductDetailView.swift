import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var suspects: [String] = []

    var body: some View {
        ZStack {
            GradientBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.name)
                            .font(.system(.title3, design: .monospaced).bold())
                            .foregroundStyle(.black)
                        Text(product.brand)
                            .font(.system(.subheadline, design: .monospaced))
                            .foregroundStyle(.gray)
                    }

                    // Warning banner
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

                    // Ingredients
                    VStack(alignment: .leading, spacing: 8) {
                        Text("-- ingredients (\(product.ingredients.count)) --")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.gray)

                        FlowLayout(spacing: 5) {
                            ForEach(product.ingredients, id: \.self) { ingredient in
                                IngredientBadge(
                                    name: ingredient,
                                    isSuspect: suspects.contains(ingredient.lowercased())
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
        .onAppear {
            suspects = LocalStorageService.shared.getSuspects()
        }
    }
}

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
