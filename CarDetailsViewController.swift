import UIKit

final class CarDetailsViewController: UIViewController {
    private let car: Car
    private let startPicker = UIDatePicker()
    private let endPicker = UIDatePicker()
    private let totalLabel = UILabel()

    init(car: Car) { self.car = car; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.cream
        title = car.brand
        navigationItem.largeTitleDisplayMode = .never
        buildView()
    }

    private func buildView() {
        let scroll = UIScrollView()
        let content = UIView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        scroll.addSubview(content)
        scroll.pinEdges(to: view)
        NSLayoutConstraint.activate([content.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor), content.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor), content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor), content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor), content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)])
        let imagePanel = UIView()
        imagePanel.backgroundColor = UIColor(hex: car.tintHex)
        imagePanel.layer.cornerRadius = 24
        let image = UIImageView(image: UIImage(systemName: car.symbolName))
        image.tintColor = Theme.ink
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        imagePanel.translatesAutoresizingMaskIntoConstraints = false
        imagePanel.addSubview(image)
        let name = UILabel()
        name.text = "\(car.brand) \(car.name)"
        name.font = Theme.title(28)
        name.textColor = Theme.ink
        let subtitle = UILabel()
        subtitle.text = "\(car.category.rawValue)  ·  \(car.location)"
        subtitle.textColor = Theme.muted
        subtitle.font = Theme.body()
        let specs = UIStackView(arrangedSubviews: [spec("person.2.fill", "\(car.seats) seats"), spec("gearshape.fill", car.transmission), spec("fuelpump.fill", car.fuel)])
        specs.axis = .horizontal
        specs.distribution = .fillEqually
        specs.spacing = 8
        let datesTitle = sectionTitle("Choose your dates")
        configurePicker(startPicker, date: Date())
        configurePicker(endPicker, date: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date())
        let dateStack = UIStackView(arrangedSubviews: [dateRow("PICK UP", startPicker), dateRow("RETURN", endPicker)])
        dateStack.axis = .vertical
        dateStack.spacing = 1
        let summary = UIView()
        summary.backgroundColor = .white
        summary.layer.cornerRadius = 16
        totalLabel.font = .systemFont(ofSize: 22, weight: .bold)
        totalLabel.textColor = Theme.ink
        updateTotal()
        let totalCaption = UILabel(); totalCaption.text = "Estimated total"; totalCaption.font = .systemFont(ofSize: 13); totalCaption.textColor = Theme.muted
        let priceStack = UIStackView(arrangedSubviews: [totalCaption, totalLabel]); priceStack.axis = .vertical; priceStack.spacing = 4
        let bookButton = UIButton(type: .system)
        bookButton.setTitle("Reserve this car", for: .normal)
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        bookButton.backgroundColor = Theme.green
        bookButton.layer.cornerRadius = 14
        bookButton.addTarget(self, action: #selector(reserve), for: .touchUpInside)
        [imagePanel, name, subtitle, specs, datesTitle, dateStack, summary, bookButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; content.addSubview($0) }
        summary.addSubview(priceStack); priceStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePanel.topAnchor.constraint(equalTo: content.topAnchor, constant: 16), imagePanel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20), imagePanel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20), imagePanel.heightAnchor.constraint(equalToConstant: 220), image.topAnchor.constraint(equalTo: imagePanel.topAnchor, constant: 30), image.bottomAnchor.constraint(equalTo: imagePanel.bottomAnchor, constant: -30), image.centerXAnchor.constraint(equalTo: imagePanel.centerXAnchor), image.widthAnchor.constraint(equalToConstant: 250),
            name.topAnchor.constraint(equalTo: imagePanel.bottomAnchor, constant: 20), name.leadingAnchor.constraint(equalTo: imagePanel.leadingAnchor), name.trailingAnchor.constraint(equalTo: imagePanel.trailingAnchor), subtitle.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4), subtitle.leadingAnchor.constraint(equalTo: name.leadingAnchor), specs.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 22), specs.leadingAnchor.constraint(equalTo: name.leadingAnchor), specs.trailingAnchor.constraint(equalTo: name.trailingAnchor), specs.heightAnchor.constraint(equalToConstant: 42), datesTitle.topAnchor.constraint(equalTo: specs.bottomAnchor, constant: 28), datesTitle.leadingAnchor.constraint(equalTo: name.leadingAnchor), dateStack.topAnchor.constraint(equalTo: datesTitle.bottomAnchor, constant: 12), dateStack.leadingAnchor.constraint(equalTo: name.leadingAnchor), dateStack.trailingAnchor.constraint(equalTo: name.trailingAnchor), summary.topAnchor.constraint(equalTo: dateStack.bottomAnchor, constant: 20), summary.leadingAnchor.constraint(equalTo: name.leadingAnchor), summary.trailingAnchor.constraint(equalTo: name.trailingAnchor), summary.heightAnchor.constraint(equalToConstant: 76), priceStack.leadingAnchor.constraint(equalTo: summary.leadingAnchor, constant: 18), priceStack.centerYAnchor.constraint(equalTo: summary.centerYAnchor), bookButton.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 12), bookButton.leadingAnchor.constraint(equalTo: name.leadingAnchor), bookButton.trailingAnchor.constraint(equalTo: name.trailingAnchor), bookButton.heightAnchor.constraint(equalToConstant: 54), bookButton.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -28)
        ])
        startPicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged); endPicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    private func spec(_ icon: String, _ text: String) -> UIView { let image = UIImageView(image: UIImage(systemName: icon)); image.tintColor = Theme.green; image.contentMode = .scaleAspectFit; let label = UILabel(); label.text = text; label.font = .systemFont(ofSize: 11, weight: .medium); label.textColor = Theme.muted; let stack = UIStackView(arrangedSubviews: [image, label]); stack.axis = .vertical; stack.alignment = .center; stack.spacing = 5; return stack }
    private func sectionTitle(_ text: String) -> UILabel { let label = UILabel(); label.text = text; label.font = .systemFont(ofSize: 18, weight: .bold); label.textColor = Theme.ink; return label }
    private func configurePicker(_ picker: UIDatePicker, date: Date) { picker.date = date; picker.minimumDate = Date(); picker.datePickerMode = .date; picker.preferredDatePickerStyle = .compact; picker.tintColor = Theme.green }
    private func dateRow(_ title: String, _ picker: UIDatePicker) -> UIView { let row = UIView(); row.backgroundColor = .white; let label = UILabel(); label.text = title; label.font = .systemFont(ofSize: 11, weight: .bold); label.textColor = Theme.muted; [label, picker].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; row.addSubview($0) }; NSLayoutConstraint.activate([row.heightAnchor.constraint(equalToConstant: 58), label.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: 16), label.centerYAnchor.constraint(equalTo: row.centerYAnchor), picker.trailingAnchor.constraint(equalTo: row.trailingAnchor, constant: -16), picker.centerYAnchor.constraint(equalTo: row.centerYAnchor)]); return row }
    @objc private func dateChanged() { if endPicker.date < startPicker.date { endPicker.date = Calendar.current.date(byAdding: .day, value: 1, to: startPicker.date) ?? startPicker.date }; updateTotal() }
    private func updateTotal() { let days = max(1, Calendar.current.dateComponents([.day], from: startPicker.date, to: endPicker.date).day ?? 1); totalLabel.text = "$\(days * car.pricePerDay)" }
    @objc private func reserve() { let booking = CarStore.shared.addBooking(car: car, startDate: startPicker.date, endDate: endPicker.date); let alert = UIAlertController(title: "You're all set", message: "Your \(booking.car.brand) \(booking.car.name) is reserved for \(booking.dateText).", preferredStyle: .alert); alert.addAction(UIAlertAction(title: "View bookings", style: .default) { [weak self] _ in self?.tabBarController?.selectedIndex = 1; self?.navigationController?.popToRootViewController(animated: false) }); present(alert, animated: true) }
}
