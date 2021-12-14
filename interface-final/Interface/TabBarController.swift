import UIKit

class TestTabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground        
        controllerSetup()
    }

    func controllerSetup(){
        viewControllers = [
            createNavController(for: HabitsViewController(), title: "Сегодня", image: UIImage(systemName: "rectangle.grid.1x2.fill")!),
            createNavController(for: InfoViewController(), title: "Информация", image: UIImage(systemName: "info.circle.fill")!)
        ]
    }

    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
