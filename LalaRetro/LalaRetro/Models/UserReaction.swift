import Foundation

struct UserReaction: Identifiable, Codable {
    var id: String?
    var productIds: [String]
    var reactionTypes: [ReactionType]
    var date: Date
    var notes: String?
}

enum ReactionType: String, Codable, CaseIterable, Identifiable {
    case redness = "redness"
    case itching = "itching"
    case breakout = "breakout"
    case burning = "burning"
    case swelling = "swelling"
    case dryness = "dryness"
    case hives = "hives"
    case peeling = "peeling"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .redness: return "Redness"
        case .itching: return "Itching"
        case .breakout: return "Breakout"
        case .burning: return "Burning"
        case .swelling: return "Swelling"
        case .dryness: return "Dryness"
        case .hives: return "Hives"
        case .peeling: return "Peeling"
        }
    }

    var emoji: String {
        switch self {
        case .redness: return "🔴"
        case .itching: return "🤏"
        case .breakout: return "😖"
        case .burning: return "🔥"
        case .swelling: return "🫧"
        case .dryness: return "🏜️"
        case .hives: return "🟣"
        case .peeling: return "🩹"
        }
    }
}
