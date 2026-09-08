import Foundation

/// Backend sends ISO-8601 instant strings (optionally with fractional seconds); falls back to
/// epoch if somehow unparsable.
enum ISO8601 {
    private static let withFractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private static let plain: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    static func parse(_ string: String?) -> Date? {
        guard let string else { return nil }
        return withFractional.date(from: string) ?? plain.date(from: string)
    }

    static func parseOrEpoch(_ string: String) -> Date {
        parse(string) ?? Date(timeIntervalSince1970: 0)
    }
}
