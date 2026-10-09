import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() { super.viewDidLoad(); title = "Profile"; view.backgroundColor = Theme.cream; navigationController?.navigationBar.prefersLargeTitles = true
        let avatar = UILabel(); avatar.text = "JD"; avatar.textAlignment = .center; avatar.textColor = Theme.green; avatar.backgroundColor = Theme.mint; avatar.font = .systemFont(ofSize: 24, weight: .bold); avatar.layer.cornerRadius = 32; avatar.clipsToBounds = true
        let name = UILabel(); name.text = "Jordan Davis"; name.font = Theme.title(24); name.textColor = Theme.ink
        let email = UILabel(); email.text = "jordan.davis@example.com"; email.font = Theme.body(); email.textColor = Theme.muted
        let card = UIStackView(arrangedSubviews: [avatar, name, email]); card.axis = .vertical; card.alignment = .center; card.spacing = 7
        let options = [("creditcard.fill", "Payment methods"), ("bell.fill", "Notifications"), ("questionmark.circle.fill", "Help center")]
        let list = UIStackView(); list.axis = .vertical; list.spacing = 1; list.backgroundColor = Theme.line
        for option in options { let row = UIButton(type: .system); row.contentHorizontalAlignment = .left; row.setImage(UIImage(systemName: option.0), for: .normal); row.setTitle("  \(option.1)", for: .normal); row.setTitleColor(Theme.ink, for: .normal); row.tintColor = Theme.green; row.backgroundColor = .white; row.heightAnchor.constraint(equalToConstant: 58).isActive = true; list.addArrangedSubview(row) }
        [card, list].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0) }; NSLayoutConstraint.activate([card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36), card.centerXAnchor.constraint(equalTo: view.centerXAnchor), avatar.widthAnchor.constraint(equalToConstant: 64), avatar.heightAnchor.constraint(equalToConstant: 64), list.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), list.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), list.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 40)]) }
}
