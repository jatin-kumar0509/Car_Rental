import Foundation

final class CarStore {
    static let shared = CarStore()

    let cars: [Car] = [
        Car(id: UUID(), name: "Model Y", brand: "Tesla", category: .electric, pricePerDay: 89, rating: 4.9, seats: 5, transmission: "Automatic", fuel: "Electric", location: "Downtown", symbolName: "bolt.car.fill", tintHex: "A7D9D2"),
        Car(id: UUID(), name: "X5", brand: "BMW", category: .suv, pricePerDay: 112, rating: 4.8, seats: 5, transmission: "Automatic", fuel: "Gasoline", location: "Airport", symbolName: "car.side.fill", tintHex: "C8D4E8"),
        Car(id: UUID(), name: "A4", brand: "Audi", category: .sedan, pricePerDay: 76, rating: 4.7, seats: 5, transmission: "Automatic", fuel: "Gasoline", location: "Downtown", symbolName: "car.fill", tintHex: "E5D4BC"),
        Car(id: UUID(), name: "Cayenne", brand: "Porsche", category: .luxury, pricePerDay: 165, rating: 4.9, seats: 5, transmission: "Automatic", fuel: "Gasoline", location: "Airport", symbolName: "car.rear.fill", tintHex: "D5B7B1"),
        Car(id: UUID(), name: "XC60", brand: "Volvo", category: .suv, pricePerDay: 98, rating: 4.6, seats: 5, transmission: "Automatic", fuel: "Hybrid", location: "Downtown", symbolName: "car.side", tintHex: "D7D8C5")
    ]

    private(set) var bookings: [Booking] = []

    func addBooking(car: Car, startDate: Date, endDate: Date) -> Booking {
        let days = max(1, Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 1)
        let booking = Booking(id: UUID(), car: car, startDate: startDate, endDate: endDate, total: days * car.pricePerDay)
        bookings.insert(booking, at: 0)
        return booking
    }
}
