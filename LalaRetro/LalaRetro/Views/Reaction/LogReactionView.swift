import SwiftUI

struct LogReactionView: View {
    @State private var viewModel = ReactionViewModel()
    @State private var showSuccess = false

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("log reaction")
                                .font(.system(.title2, design: .monospaced).bold())
                                .foregroundStyle(.black)
                            Text("which products caused a reaction?")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        // Product selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("-- select products --")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            if viewModel.userProducts.isEmpty {
                                VStack(spacing: 6) {
                                    Text("no products yet")
                                        .font(.system(.subheadline, design: .monospaced))
                                        .foregroundStyle(.black)
                                    Text("scan or search products first")
                                        .font(.system(.caption, design: .monospaced))
                                        .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(24)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                            } else {
                                ForEach(viewModel.userProducts) { product in
                                    let isSelected = viewModel.selectedProductIds.contains(product.id ?? "")
                                    Button {
                                        viewModel.toggleProduct(product.id ?? "")
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(product.name)
                                                    .font(.system(.subheadline, design: .monospaced))
                                                    .foregroundStyle(.black)
                                                Text(product.brand)
                                                    .font(.system(.caption, design: .monospaced))
                                                    .foregroundStyle(.gray)
                                            }
                                            Spacer()
                                            Text(isSelected ? "[x]" : "[ ]")
                                                .font(.system(.subheadline, design: .monospaced).bold())
                                                .foregroundStyle(isSelected ? Color(red: 0.75, green: 0.55, blue: 0.85) : .gray)
                                        }
                                        .padding(12)
                                        .background(isSelected ? Color(red: 0.96, green: 0.93, blue: 1.0) : .white)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(isSelected ? Color(red: 0.75, green: 0.55, blue: 0.85).opacity(0.3) : Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }

                        // Reaction types
                        VStack(alignment: .leading, spacing: 8) {
                            Text("-- what happened? --")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            LazyVGrid(columns: [.init(.adaptive(minimum: 100))], spacing: 8) {
                                ForEach(ReactionType.allCases) { type in
                                    let isSelected = viewModel.selectedReactions.contains(type)
                                    Button {
                                        viewModel.toggleReaction(type)
                                    } label: {
                                        VStack(spacing: 3) {
                                            Text(type.emoji)
                                                .font(.title3)
                                            Text(type.label.lowercased())
                                                .font(.system(.caption2, design: .monospaced))
                                                .foregroundStyle(.black)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(isSelected ? Color(red: 0.97, green: 0.91, blue: 0.94) : .white)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .strokeBorder(isSelected ? Color(red: 0.75, green: 0.2, blue: 0.45).opacity(0.3) : Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }

                        // Notes
                        VStack(alignment: .leading, spacing: 6) {
                            Text("notes (optional)")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                            TextField("any details...", text: $viewModel.notes, axis: .vertical)
                                .font(.system(.caption, design: .monospaced))
                                .lineLimit(2...4)
                                .padding(10)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        }

                        // Save
                        Button {
                            if viewModel.save() {
                                showSuccess = true
                                viewModel.reset()
                            }
                        } label: {
                            HStack {
                                if viewModel.isSaving {
                                    ProgressView().tint(.white)
                                } else {
                                    Text("[ save reaction ]")
                                        .font(.system(.subheadline, design: .monospaced).bold())
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.canSave ? Color.black : Color.gray)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .disabled(!viewModel.canSave || viewModel.isSaving)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.loadUserProducts()
        }
        .alert("saved!", isPresented: $showSuccess) {
            Button("ok") {}
        } message: {
            Text("your reaction has been logged. go to analyze to find suspects.")
        }
    }
}

#Preview {
    LogReactionView()
}
