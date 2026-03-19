import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var brand = ""
    @State private var ingredientsText = ""
    @State private var barcode: String?
    @State private var isSaving = false
    var initialBarcode: String?
    var initialIngredients: String?

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("add product")
                                .font(.system(.title2, design: .monospaced).bold())
                                .foregroundStyle(.black)
                            Text("add to your local database")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        // Name
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

                        // Brand
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

                        // Ingredients
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

                        if let bc = barcode ?? initialBarcode {
                            Text("barcode: \(bc)")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        // Save
                        Button(action: { save() }) {
                            HStack {
                                if isSaving {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("[ save product ]")
                                        .font(.system(.subheadline, design: .monospaced).bold())
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(name.isEmpty || ingredientsText.isEmpty ? Color.gray : Color.black)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .disabled(name.isEmpty || ingredientsText.isEmpty || isSaving)
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
        .onAppear {
            if let bc = initialBarcode { barcode = bc }
            if let ing = initialIngredients { ingredientsText = ing }
        }
    }

    private func save() {
        isSaving = true
        let ingredients = IngredientParser.parse(ingredientsText)
        let product = Product(
            name: name,
            brand: brand,
            barcode: barcode ?? initialBarcode,
            ingredients: ingredients,
            photoURL: nil,
            addedBy: "local",
            createdAt: Date()
        )
        _ = LocalStorageService.shared.saveProduct(product)
        dismiss()
    }
}

#Preview {
    AddProductView()
}
