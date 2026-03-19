import SwiftUI

struct ProductCard: View {
    let product: Product

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(product.name)
                    .font(.system(.subheadline, design: .monospaced).weight(.medium))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                HStack(spacing: 8) {
                    Text(product.brand)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.gray)
                    Text("[\(product.ingredients.count) ing.]")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                }
            }
            Spacer()
            Text(">")
                .font(.system(.subheadline, design: .monospaced))
                .foregroundStyle(.gray)
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1)
        )
    }
}

#Preview {
    ProductCard(product: .example)
        .padding()
}
