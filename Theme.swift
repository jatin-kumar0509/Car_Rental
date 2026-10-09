import UIKit

enum Theme {
    static let ink = UIColor(hex: "14231F")
    static let muted = UIColor(hex: "71807B")
    static let green = UIColor(hex: "1B5E50")
    static let mint = UIColor(hex: "DDEDE7")
    static let cream = UIColor(hex: "F7F8F4")
    static let line = UIColor(hex: "E2E8E4")

    static func title(_ size: CGFloat = 30) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func body(_ size: CGFloat = 15) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }
}

extension UIView {
    func pinEdges(to view: UIView, inset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset)
        ])
    }
}
