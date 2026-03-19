import Foundation

struct IngredientParser {
    /// Parses raw OCR text into a clean ingredient array.
    /// Handles comma-separated INCI lists, parentheses, and common OCR artifacts.
    static func parse(_ rawText: String) -> [String] {
        var text = rawText

        // Remove common INCI prefixes
        let prefixes = ["ingredients:", "ingredients", "inci:", "inci", "composition:", "composition"]
        for prefix in prefixes {
            if text.lowercased().hasPrefix(prefix) {
                text = String(text.dropFirst(prefix.count))
                break
            }
        }

        // Replace common separators with comma
        text = text.replacingOccurrences(of: " · ", with: ", ")
        text = text.replacingOccurrences(of: " • ", with: ", ")
        text = text.replacingOccurrences(of: " | ", with: ", ")
        text = text.replacingOccurrences(of: "\n", with: ", ")

        // Split by comma
        let parts = text.components(separatedBy: ",")

        let cleaned = parts.compactMap { part -> String? in
            var ingredient = part.trimmingCharacters(in: .whitespacesAndNewlines)

            // Remove trailing period (end of list)
            if ingredient.hasSuffix(".") {
                ingredient = String(ingredient.dropLast())
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }

            // Skip empty or too-short entries
            guard ingredient.count >= 2 else { return nil }

            // Skip entries that look like non-ingredient text
            let skipPatterns = ["may contain", "contains", "warning", "caution", "for external use"]
            if skipPatterns.contains(where: { ingredient.lowercased().contains($0) }) {
                return nil
            }

            return ingredient
        }

        return cleaned
    }
}
