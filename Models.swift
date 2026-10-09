import Foundation

struct Car: Hashable {
    let id: UUID
    let name: String
    let brand: String
    let category: Category
    let pricePerDay: Int
    let rating: Double
    let seats: Int
    let transmission: String
    let fuel: String
    let location: String
    let symbolName: String
    let tintHex: String

    enum Category: String, CaseIterable {
        case all = "All cars"
        case suv = "SUV"
        case sedan = "Sedan"
        case electric = "Electric"
        case luxury = "Luxury"
    }
}

struct Booking: Hashable {
    let id: UUID
    let car: Car
    let startDate: Date
    let endDate: Date
    let total: Int

    var dateText: String {
        "\(startDate.formatted(date: .abbreviated, time: .omitted)) - \(endDate.formatted(date: .abbreviated, time: .omitted))"
    }
}

extension UIColor {
    convenience init(hex: String) {
        let value = Int(hex, radix: 16) ?? 0
        self.init(red: CGFloat((value >> 16) & 0xFF) / 255,
                  green: CGFloat((value >> 8) & 0xFF) / 255,
                  blue: CGFloat(value & 0xFF) / 255,
                  alpha: 1)
    }
}
