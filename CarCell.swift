import UIKit

final class CarCell: UITableViewCell {
    static let reuseID = "CarCell"
    private let carImage = UIImageView()
    private let brandLabel = UILabel()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let priceLabel = UILabel()
    private let ratingLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let imageBackground = UIView()
        imageBackground.backgroundColor = Theme.mint
        imageBackground.layer.cornerRadius = 16
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageBackground)
        carImage.contentMode = .scaleAspectFit
        carImage.tintColor = Theme.ink
        carImage.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.addSubview(carImage)
        brandLabel.font = .systemFont(ofSize: 12, weight: .medium)
        brandLabel.textColor = Theme.muted
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = Theme.ink
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textColor = Theme.muted
        priceLabel.font = .systemFont(ofSize: 17, weight: .bold)
        priceLabel.textColor = Theme.green
        ratingLabel.font = .systemFont(ofSize: 13, weight: .medium)
        ratingLabel.textColor = Theme.ink
        [brandLabel, nameLabel, infoLabel, priceLabel, ratingLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            imageBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), imageBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), imageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), imageBackground.widthAnchor.constraint(equalToConstant: 126), imageBackground.heightAnchor.constraint(equalToConstant: 118),
            carImage.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor), carImage.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor), carImage.widthAnchor.constraint(equalToConstant: 104), carImage.heightAnchor.constraint(equalToConstant: 74),
            brandLabel.leadingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: 16), brandLabel.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 7), brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            nameLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor), nameLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 3), nameLabel.trailingAnchor.constraint(equalTo: brandLabel.trailingAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor), infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8), infoLabel.trailingAnchor.constraint(equalTo: brandLabel.trailingAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor), priceLabel.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor, constant: -7),
            ratingLabel.trailingAnchor.constraint(equalTo: brandLabel.trailingAnchor), ratingLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with car: Car) {
        carImage.image = UIImage(systemName: car.symbolName)
        carImage.tintColor = UIColor(hex: car.tintHex).darker
        brandLabel.text = car.brand.uppercased()
        nameLabel.text = car.name
        infoLabel.text = "\(car.seats) seats  ·  \(car.transmission)"
        priceLabel.text = "$\(car.pricePerDay) / day"
        ratingLabel.text = "★ \(car.rating)"
    }
}

private extension UIColor {
    var darker: UIColor { self.withAlphaComponent(0.95) }
}
