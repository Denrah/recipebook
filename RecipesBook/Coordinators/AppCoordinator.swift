import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    lazy var dataProvider = DataProvider()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        let recipesCoordinator = RecipesListCoordinator(dataProvider: dataProvider, rootViewController: rootViewController)
        
        self.addChildCoordinator(recipesCoordinator)
        
        recipesCoordinator.start()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()	
    }
    
    override func finish() {
        
    }

}
