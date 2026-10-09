import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let explore = UINavigationController(rootViewController: ExploreViewController())
        explore.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "safari"), tag: 0)
        let bookings = UINavigationController(rootViewController: BookingsViewController())
        bookings.tabBarItem = UITabBarItem(title: "Bookings", image: UIImage(systemName: "calendar"), tag: 1)
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        viewControllers = [explore, bookings, profile]
        tabBar.tintColor = Theme.green
        tabBar.unselectedItemTintColor = Theme.muted
        tabBar.backgroundColor = .systemBackground
    }
}
