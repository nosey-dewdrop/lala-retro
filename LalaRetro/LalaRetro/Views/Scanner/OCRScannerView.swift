import SwiftUI
import PhotosUI

struct OCRScannerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var recognizedText = ""
    @State private var isProcessing = false
    @State private var showError = false
    var onComplete: (String) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                VStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("ocr scan")
                            .font(.system(.title2, design: .monospaced).bold())
                            .foregroundStyle(.black)
                        Text("photograph the ingredient list")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.gray)
                    }
                    .padding(.top)

                    if isProcessing {
                        HStack(spacing: 6) {
                            ProgressView()
                                .tint(Color(red: 0.75, green: 0.55, blue: 0.85))
                            Text("reading ingredients...")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }
                        .padding(.top, 40)
                    } else if !recognizedText.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("-- recognized text --")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                            TextEditor(text: $recognizedText)
                                .font(.system(.caption, design: .monospaced))
                                .frame(minHeight: 200)
                                .padding(8)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))

                            Text("review and edit, then tap use")
                                .font(.system(.caption2, design: .monospaced))
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal)

                        Button("[ use these ingredients ]") {
                            onComplete(recognizedText)
                        }
                        .font(.system(.subheadline, design: .monospaced).bold())
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding(.horizontal)
                    } else {
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            VStack(spacing: 10) {
                                Text("[+]")
                                    .font(.system(size: 36, design: .monospaced))
                                    .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                                Text("select photo of ingredient list")
                                    .font(.system(.subheadline, design: .monospaced).bold())
                                    .foregroundStyle(.black)
                                Text("we'll extract text using ocr")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(36)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                        }
                        .padding()
                    }

                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") { dismiss() }
                        .font(.system(.subheadline, design: .monospaced))
                        .foregroundStyle(.black)
                }
            }
            .onChange(of: selectedPhoto) { _, newValue in
                guard let item = newValue else { return }
                Task { await processPhoto(item) }
            }
            .alert("ocr error", isPresented: $showError) {
                Button("ok") {}
            } message: {
                Text("could not read text from the image. try a clearer photo.")
            }
        }
    }

    private func processPhoto(_ item: PhotosPickerItem) async {
        isProcessing = true
        do {
            guard let data = try await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else {
                showError = true
                isProcessing = false
                return
            }
            recognizedText = try await OCRService.shared.recognizeText(from: image)
            if recognizedText.isEmpty { showError = true }
        } catch {
            showError = true
        }
        isProcessing = false
    }
}

#Preview {
    OCRScannerView { _ in }
}
