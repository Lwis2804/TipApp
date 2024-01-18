
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = self.createNavController(for: TipCalculatorViewController(), title: "Tip Calculator", image: UIImage(systemName: "person.fill") ?? UIImage())
        let view2 = self.createNavController(for: CalculatorViewController(), title: "Calculator", image: UIImage(systemName: "person.3.fill") ?? UIImage())
        let view3 = self.createNavController(for: SettingsViewController(), title: "Settings", image: UIImage(systemName: "person.3.fill") ?? UIImage())
        self.viewControllers = [view1, view2, view3]
        
    }
    
    func createNavController(for mainViewController : UIViewController, title: String, image: UIImage ) -> UIViewController{
        let navController = UINavigationController(rootViewController: mainViewController)
        navController.tabBarItem.title = "\(title)"
        mainViewController.navigationItem.title = "\(title)"
        navController.tabBarItem.image = image
        mainViewController.navigationItem.backButtonTitle = "Atras"
        return navController
    }
}
