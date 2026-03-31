import Foundation

struct IngredientParser {
    /// Parses raw OCR text into a clean ingredient array.
    /// Handles comma-separated INCI lists, various separators, parentheses,
    /// numbered lists, and common OCR artifacts.
    static func parse(_ rawText: String) -> [String] {
        var text = rawText

        // Remove common INCI prefixes (case-insensitive)
        let prefixPatterns = [
            "ingredients\\s*:", "ingredients\\s*\\(",
            "inci\\s*:", "composition\\s*:",
            "composition", "ingredients", "inci"
        ]
        for pattern in prefixPatterns {
            if let range = text.range(of: "^\\s*" + pattern, options: [.regularExpression, .caseInsensitive]) {
                text = String(text[range.upperBound...])
                break
            }
        }

        // Remove trailing parentheses content that isn't ingredients
        // e.g. "(may contain CI 77891)"
        if let range = text.range(of: "\\(\\s*(may contain|peut contenir).*\\)\\s*\\.?$",
                                   options: [.regularExpression, .caseInsensitive]) {
            text = String(text[..<range.lowerBound])
        }

        // Normalize various separator styles to comma
        let separatorReplacements: [(String, String)] = [
            (" · ", ", "), (" • ", ", "), ("•", ", "),
            (" · ", ", "), (" | ", ", "), (" / ", ", "),
            (" - ", ", "), ("\n", ", "), ("\r", ", "),
            (" ; ", ", "), (";", ", ")
        ]
        for (from, to) in separatorReplacements {
            text = text.replacingOccurrences(of: from, with: to)
        }

        // Handle numbered lists: "1. Aqua 2. Glycerin" or "1) Aqua 2) Glycerin"
        text = text.replacingOccurrences(
            of: "\\d+[.):]\\s*",
            with: ", ",
            options: .regularExpression
        )

        // Remove content inside square brackets [CI 77891]
        text = text.replacingOccurrences(
            of: "\\[[^\\]]*\\]",
            with: "",
            options: .regularExpression
        )

        // Split by comma
        let parts = text.components(separatedBy: ",")

        let cleaned = parts.compactMap { part -> String? in
            var ingredient = part.trimmingCharacters(in: .whitespacesAndNewlines)

            // Remove trailing period (end of list)
            while ingredient.hasSuffix(".") {
                ingredient = String(ingredient.dropLast())
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }

            // Remove leading/trailing parentheses if unbalanced
            let openCount = ingredient.filter { $0 == "(" }.count
            let closeCount = ingredient.filter { $0 == ")" }.count
            if openCount != closeCount {
                ingredient = ingredient.replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }

            // Remove leading asterisks or daggers (footnote markers)
            ingredient = ingredient.replacingOccurrences(
                of: "^[*†‡]+\\s*",
                with: "",
                options: .regularExpression
            )

            // Skip empty or too-short entries
            guard ingredient.count >= 2 else { return nil }

            // Skip entries that are clearly not ingredients
            let skipPatterns = [
                "may contain", "contains", "warning", "caution",
                "for external use", "keep out of reach", "avoid contact",
                "store in", "made in", "product of", "batch",
                "exp ", "lot ", "www.", "http", ".com",
                "certified", "approved", "dermatologically tested"
            ]
            if skipPatterns.contains(where: { ingredient.lowercased().contains($0) }) {
                return nil
            }

            // Skip entries that are just numbers or codes
            let stripped = ingredient.replacingOccurrences(
                of: "[^a-zA-Z]", with: "", options: .regularExpression
            )
            guard stripped.count >= 2 else { return nil }

            return ingredient
        }

        return cleaned
    }
}
