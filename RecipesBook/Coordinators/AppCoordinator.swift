import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    let dataProvider: DataProvider
    
    init(window: UIWindow?, dataProvider: DataProvider) {
        self.window = window
        self.dataProvider = dataProvider
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        let recipesCoordinator = RecipesCoordinator(dataProvider: dataProvider, rootViewController: rootViewController)
        
        self.addChildCoordinator(recipesCoordinator)
        
        recipesCoordinator.start()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()	
    }
    
    override func finish() {
        
    }

}
