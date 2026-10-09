import UIKit

final class BookingsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    override func viewDidLoad() { super.viewDidLoad(); title = "My bookings"; view.backgroundColor = Theme.cream; navigationController?.navigationBar.prefersLargeTitles = true; tableView.backgroundColor = .clear; tableView.separatorStyle = .none; tableView.dataSource = self; tableView.delegate = self; tableView.register(BookingCell.self, forCellReuseIdentifier: "BookingCell"); tableView.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(tableView); tableView.pinEdges(to: view) }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); tableView.reloadData() }
}

extension BookingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { CarStore.shared.bookings.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell; cell.configure(with: CarStore.shared.bookings[indexPath.row]); return cell }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 126 }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { let label = UILabel(); label.text = CarStore.shared.bookings.isEmpty ? "No reservations yet" : "Upcoming drives"; label.font = .systemFont(ofSize: 19, weight: .bold); label.textColor = Theme.ink; label.frame = CGRect(x: 20, y: 10, width: 300, height: 30); return label }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 52 }
}

final class BookingCell: UITableViewCell {
    private let icon = UIImageView(); private let name = UILabel(); private let dates = UILabel(); private let total = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let panel = UIView()
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 16
        panel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(panel)
        icon.tintColor = Theme.green
        icon.contentMode = .scaleAspectFit
        [icon, name, dates, total].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; panel.addSubview($0) }
        name.font = .systemFont(ofSize: 17, weight: .bold)
        name.textColor = Theme.ink
        dates.font = .systemFont(ofSize: 13)
        dates.textColor = Theme.muted
        total.font = .systemFont(ofSize: 16, weight: .bold)
        total.textColor = Theme.green
        NSLayoutConstraint.activate([
            panel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), panel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), panel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7), panel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7), icon.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 16), icon.centerYAnchor.constraint(equalTo: panel.centerYAnchor), icon.widthAnchor.constraint(equalToConstant: 42), icon.heightAnchor.constraint(equalToConstant: 42), name.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 14), name.topAnchor.constraint(equalTo: panel.topAnchor, constant: 20), dates.leadingAnchor.constraint(equalTo: name.leadingAnchor), dates.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5), total.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -16), total.centerYAnchor.constraint(equalTo: panel.centerYAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    func configure(with booking: Booking) { icon.image = UIImage(systemName: booking.car.symbolName); name.text = "\(booking.car.brand) \(booking.car.name)"; dates.text = booking.dateText; total.text = "$\(booking.total)" }
}
