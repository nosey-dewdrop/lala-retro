import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("lalaretro")
                                .font(.system(.title2, design: .monospaced).bold())
                                .foregroundStyle(.black)
                            Text("find which ingredient is messing with your skin")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        // Search
                        HStack(spacing: 8) {
                            Text(">")
                                .font(.system(.body, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                            TextField("search products...", text: $viewModel.searchQuery)
                                .font(.system(.subheadline, design: .monospaced))
                                .textInputAutocapitalization(.never)
                                .onSubmit {
                                    viewModel.search()
                                }
                        }
                        .padding(12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(Color(red: 0.88, green: 0.85, blue: 0.93), lineWidth: 1)
                        )

                        // Results
                        if viewModel.isLoading {
                            HStack(spacing: 6) {
                                ProgressView()
                                    .tint(Color(red: 0.75, green: 0.55, blue: 0.85))
                                Text("searching...")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                        } else if viewModel.hasSearched && viewModel.products.isEmpty {
                            VStack(spacing: 6) {
                                Text("no results found")
                                    .font(.system(.subheadline, design: .monospaced))
                                    .foregroundStyle(.black)
                                Text("try a different name or brand")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                        } else if !viewModel.products.isEmpty {
                            Text("\(viewModel.products.count) results")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            ForEach(viewModel.products) { product in
                                NavigationLink(value: product) {
                                    ProductCard(product: product)
                                }
                                .buttonStyle(.plain)
                            }
                        } else {
                            // Empty state — onboarding
                            VStack(alignment: .leading, spacing: 16) {
                                StepRow(number: "01", title: "scan or search products", desc: "find cosmetics by name or barcode")
                                StepRow(number: "02", title: "log your reactions", desc: "tell us which products bothered your skin")
                                StepRow(number: "03", title: "find the trigger", desc: "we cross-reference to find suspect ingredients")
                            }
                            .padding(.top, 16)
                        }
                    }
                    .padding()
                }
                .navigationDestination(for: Product.self) { product in
                    ProductDetailView(product: product)
                }
            }
        }
    }
}

struct StepRow: View {
    let number: String
    let title: String
    let desc: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.system(.caption, design: .monospaced).bold())
                .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                .frame(width: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(.subheadline, design: .monospaced))
                    .foregroundStyle(.black)
                Text(desc)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    HomeView()
}
