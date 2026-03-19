import SwiftUI

struct ScannerTabView: View {
    @State private var viewModel = ScannerViewModel()
    @State private var showOCR = false
    @State private var showManualAdd = false
    @State private var ocrText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                VStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("scan")
                            .font(.system(.title2, design: .monospaced).bold())
                            .foregroundStyle(.black)
                        Text("add products to the database")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.gray)
                    }
                    .padding(.top)

                    if viewModel.isSearching {
                        HStack(spacing: 6) {
                            ProgressView()
                                .tint(Color(red: 0.75, green: 0.55, blue: 0.85))
                            Text("looking up barcode...")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }
                        .padding(.top, 40)
                    } else if let product = viewModel.foundProduct {
                        VStack(spacing: 12) {
                            Text("[found]")
                                .font(.system(.subheadline, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.3, green: 0.7, blue: 0.4))
                            NavigationLink(value: product) {
                                ProductCard(product: product)
                            }
                            .buttonStyle(.plain)

                            Button("scan another") {
                                viewModel.reset()
                            }
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        }
                        .padding()
                    } else if viewModel.showNotFound {
                        VStack(spacing: 16) {
                            Text("[not found]")
                                .font(.system(.subheadline, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.85, green: 0.55, blue: 0.2))
                            if let barcode = viewModel.scannedBarcode {
                                Text("barcode: \(barcode)")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.gray)
                            }
                            Text("add it for the community!")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            HStack(spacing: 10) {
                                Button { showOCR = true } label: {
                                    Text("[ ocr scan ]")
                                        .font(.system(.caption, design: .monospaced).bold())
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 0.94, green: 0.9, blue: 0.98))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }

                                Button { showManualAdd = true } label: {
                                    Text("[ manual ]")
                                        .font(.system(.caption, design: .monospaced).bold())
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color(red: 0.96, green: 0.92, blue: 0.96))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                            }
                        }
                        .padding()
                    } else {
                        // Scanner placeholder
                        VStack(spacing: 20) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .frame(height: 260)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1)
                                )
                                .overlay {
                                    VStack(spacing: 10) {
                                        Text("[ ]")
                                            .font(.system(size: 40, design: .monospaced))
                                            .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                                        Text("point camera at barcode")
                                            .font(.system(.caption, design: .monospaced))
                                            .foregroundStyle(.gray)
                                        Text("(requires real device)")
                                            .font(.system(.caption2, design: .monospaced))
                                            .foregroundStyle(.gray.opacity(0.6))
                                    }
                                }

                            HStack(spacing: 10) {
                                Button { showOCR = true } label: {
                                    Text("[ ocr scan ]")
                                        .font(.system(.caption, design: .monospaced).bold())
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 0.94, green: 0.9, blue: 0.98))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }

                                Button { showManualAdd = true } label: {
                                    Text("[ manual ]")
                                        .font(.system(.caption, design: .monospaced).bold())
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 0.96, green: 0.92, blue: 0.96))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                            }
                        }
                        .padding()
                    }

                    Spacer()
                }
                .navigationDestination(for: Product.self) { product in
                    ProductDetailView(product: product)
                }
            }
            .sheet(isPresented: $showOCR) {
                OCRScannerView { ingredients in
                    ocrText = ingredients
                    showOCR = false
                    showManualAdd = true
                }
            }
            .sheet(isPresented: $showManualAdd) {
                AddProductView(
                    initialBarcode: viewModel.scannedBarcode,
                    initialIngredients: ocrText.isEmpty ? nil : ocrText
                )
            }
        }
    }
}

#Preview {
    ScannerTabView()
}
