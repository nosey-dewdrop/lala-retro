import SwiftUI

struct IngredientBadge: View {
    let name: String
    var isSuspect: Bool = false
    var isHighlighted: Bool = false

    var body: some View {
        Text(name.lowercased())
            .font(.system(.caption2, design: .monospaced))
            .fontWeight(isSuspect ? .bold : .regular)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(borderColor, lineWidth: 1)
            )
    }

    private var backgroundColor: Color {
        if isSuspect { return Color(red: 0.95, green: 0.85, blue: 0.9) }
        if isHighlighted { return Color(red: 0.94, green: 0.9, blue: 0.98) }
        return Color(red: 0.96, green: 0.95, blue: 0.98)
    }

    private var foregroundColor: Color {
        if isSuspect { return Color(red: 0.75, green: 0.2, blue: 0.45) }
        if isHighlighted { return Color("AccentPurple") }
        return Color(red: 0.35, green: 0.3, blue: 0.45)
    }

    private var borderColor: Color {
        if isSuspect { return Color(red: 0.75, green: 0.2, blue: 0.45).opacity(0.3) }
        return Color(red: 0.9, green: 0.87, blue: 0.95)
    }
}

#Preview {
    HStack {
        IngredientBadge(name: "Glycerin")
        IngredientBadge(name: "Fragrance", isSuspect: true)
        IngredientBadge(name: "Niacinamide", isHighlighted: true)
    }
    .padding()
}
