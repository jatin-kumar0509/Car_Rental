import UIKit

final class ExploreViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let searchField = UISearchTextField()
    private var selectedCategory: Car.Category = .all
    private var query = ""
    private var filteredCars: [Car] { CarStore.shared.cars.filter { car in
        (selectedCategory == .all || car.category == selectedCategory) &&
        (query.isEmpty || "\(car.brand) \(car.name)".localizedCaseInsensitiveContains(query))
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.cream
        navigationController?.navigationBar.prefersLargeTitles = false
        configureHeader()
        configureTable()
    }

    private func configureHeader() {
        let title = UILabel()
        title.text = "Find your\nnext drive."
        title.numberOfLines = 2
        title.font = Theme.title(32)
        title.textColor = Theme.ink
        let location = UILabel()
        location.text = "CURRENT LOCATION"
        location.font = .systemFont(ofSize: 10, weight: .bold)
        location.textColor = Theme.muted
        let place = UILabel()
        place.text = "Downtown, Seattle ⌄"
        place.font = .systemFont(ofSize: 14, weight: .semibold)
        place.textColor = Theme.ink
        let locationStack = UIStackView(arrangedSubviews: [location, place])
        locationStack.axis = .vertical
        locationStack.spacing = 3
        let header = UIStackView(arrangedSubviews: [title, UIView(), locationStack])
        header.alignment = .bottom
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        searchField.placeholder = "Search by make or model"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 13
        searchField.clipsToBounds = true
        searchField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchField.leftViewMode = .always
        searchField.leftView?.tintColor = Theme.muted
        searchField.font = .systemFont(ofSize: 15)
        searchField.addTarget(self, action: #selector(searchChanged), for: .editingChanged)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchField)
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22), header.heightAnchor.constraint(equalToConstant: 76),
            searchField.leadingAnchor.constraint(equalTo: header.leadingAnchor), searchField.trailingAnchor.constraint(equalTo: header.trailingAnchor), searchField.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20), searchField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func configureTable() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 138, left: 0, bottom: 12, right: 0)
        tableView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(tableView, at: 0)
        tableView.pinEdges(to: view)
    }

    @objc private func searchChanged() {
        query = searchField.text ?? ""
        tableView.reloadData()
    }

    private func categoryControl() -> UISegmentedControl {
        let control = UISegmentedControl(items: Car.Category.allCases.map(\.rawValue))
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(categoryChanged), for: .valueChanged)
        control.selectedSegmentTintColor = Theme.green
        control.setTitleTextAttributes([.foregroundColor: Theme.muted], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        return control
    }

    @objc private func categoryChanged(_ sender: UISegmentedControl) {
        selectedCategory = Car.Category.allCases[sender.selectedSegmentIndex]
        tableView.reloadData()
    }
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { filteredCars.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.reuseID, for: indexPath) as! CarCell
        cell.configure(with: filteredCars[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 134 }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        container.backgroundColor = Theme.cream
        let label = UILabel()
        label.text = "Available near you"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = Theme.ink
        let control = categoryControl()
        label.translatesAutoresizingMaskIntoConstraints = false
        control.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        container.addSubview(control)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20), label.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            control.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20), control.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20), control.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12), control.heightAnchor.constraint(equalToConstant: 34)
        ])
        return container
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 96 }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CarDetailsViewController(car: filteredCars[indexPath.row]), animated: true)
    }
}
