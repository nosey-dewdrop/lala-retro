import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("profile")
                                .font(.system(.title2, design: .monospaced).bold())
                                .foregroundStyle(.black)
                            Text("your watchlist & reaction history")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)
                        }

                        // Watchlist
                        VStack(alignment: .leading, spacing: 8) {
                            Text("-- ingredient watchlist --")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            if viewModel.suspects.isEmpty {
                                VStack(spacing: 6) {
                                    Text("empty watchlist")
                                        .font(.system(.subheadline, design: .monospaced))
                                        .foregroundStyle(.black)
                                    Text("use analyze to find triggers")
                                        .font(.system(.caption, design: .monospaced))
                                        .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(24)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                            } else {
                                FlowLayout(spacing: 6) {
                                    ForEach(viewModel.suspects, id: \.self) { suspect in
                                        HStack(spacing: 4) {
                                            IngredientBadge(name: suspect, isSuspect: true)
                                            Button {
                                                viewModel.removeSuspect(suspect)
                                            } label: {
                                                Text("x")
                                                    .font(.system(.caption2, design: .monospaced))
                                                    .foregroundStyle(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        // Divider
                        Rectangle()
                            .fill(Color(red: 0.9, green: 0.87, blue: 0.95))
                            .frame(height: 1)

                        // Reaction history
                        VStack(alignment: .leading, spacing: 8) {
                            Text("-- reaction history --")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.gray)

                            if viewModel.reactions.isEmpty {
                                VStack(spacing: 6) {
                                    Text("no reactions logged")
                                        .font(.system(.subheadline, design: .monospaced))
                                        .foregroundStyle(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(24)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                            } else {
                                ForEach(viewModel.reactions) { reaction in
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            // Product names
                                            let productNames = reaction.productIds.compactMap { id in
                                                viewModel.getProductName(id: id)
                                            }
                                            if !productNames.isEmpty {
                                                Text(productNames.joined(separator: ", "))
                                                    .font(.system(.caption, design: .monospaced).bold())
                                                    .foregroundStyle(.black)
                                                    .lineLimit(2)
                                            }

                                            HStack(spacing: 4) {
                                                ForEach(reaction.reactionTypes) { type in
                                                    Text("\(type.emoji) \(type.label.lowercased())")
                                                        .font(.system(.caption2, design: .monospaced))
                                                        .padding(.horizontal, 6)
                                                        .padding(.vertical, 3)
                                                        .background(Color(red: 0.97, green: 0.91, blue: 0.94))
                                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                                }
                                            }
                                            if let notes = reaction.notes {
                                                Text("\"\(notes)\"")
                                                    .font(.system(.caption, design: .monospaced))
                                                    .foregroundStyle(.gray)
                                                    .italic()
                                            }
                                            Text(reaction.date.formatted(.dateTime.month(.abbreviated).day()))
                                                .font(.system(.caption2, design: .monospaced))
                                                .foregroundStyle(.gray)
                                        }

                                        Spacer()

                                        Button {
                                            if let id = reaction.id {
                                                viewModel.deleteReaction(id: id)
                                            }
                                        } label: {
                                            Text("[del]")
                                                .font(.system(.caption2, design: .monospaced))
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                    .padding(12)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(red: 0.9, green: 0.87, blue: 0.95), lineWidth: 1))
                                }
                            }
                        }
                        // Disclaimer
                        Rectangle()
                            .fill(Color(red: 0.9, green: 0.87, blue: 0.95))
                            .frame(height: 1)

                        HStack(alignment: .top, spacing: 8) {
                            Text("i")
                                .font(.system(.caption2, design: .monospaced).bold())
                                .foregroundStyle(Color(red: 0.75, green: 0.55, blue: 0.85))
                            Text("lalaretro is not medical advice. always consult a dermatologist for skin concerns.")
                                .font(.system(.caption2, design: .monospaced))
                                .foregroundStyle(.gray)
                        }
                        .padding(12)
                        .background(Color(red: 0.96, green: 0.94, blue: 0.99))
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                        Text("v1.0.0")
                            .font(.system(.caption2, design: .monospaced))
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
}

#Preview {
    ProfileView()
}
