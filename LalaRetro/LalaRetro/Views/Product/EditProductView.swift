import SwiftUI

struct EditProductView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var brand: String
    @State private var ingredientsText: String
    let product: Product
    var onSave: (Product) -> Void

    init(product: Product, onSave: @escaping (Product) -> Void) {
        self.product = product
        self.onSave = onSave
        _name = State(initialValue: product.name)
        _brand = State(initialValue: product.brand)
        _ingredientsText = State(initialValue: product.ingredients.joined(separator: ", "))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("edit product")
                                .font(.system(.title2, design: .monospaced).bold())
                                .foregroundStyle(.black)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("product name")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                            TextField("e.g. moisturizing cream", text: $name)
                                .font(.system(.subheadline, design: .monospaced))
                                .padding(10)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("brand")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                            TextField("e.g. cerave", text: $brand)
                                .font(.system(.subheadline, design: .monospaced))
                                .padding(10)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("ingredients (comma-separated)")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                            TextEditor(text: $ingredientsText)
                                .font(.system(.caption, design: .monospaced))
                                .frame(minHeight: 120)
                                .padding(8)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        }

                        if let barcode = product.barcode {
                            Text("barcode: \(barcode)")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        Button {
                            var updated = product
                            updated.name = name
                            updated.brand = brand
                            updated.ingredients = IngredientParser.parse(ingredientsText)
                            onSave(updated)
                            dismiss()
                        } label: {
                            Text("[ save changes ]")
                                .font(.system(.subheadline, design: .monospaced).bold())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(name.isEmpty || ingredientsText.isEmpty ? Color.gray : Color.black)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .disabled(name.isEmpty || ingredientsText.isEmpty)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") { dismiss() }
                        .font(.system(.subheadline, design: .monospaced))
                        .foregroundStyle(.black)
                }
            }
        }
    }
}
