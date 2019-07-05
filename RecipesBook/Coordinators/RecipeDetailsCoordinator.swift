import UIKit

class RecipeDetailsCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    
    private let dataProvider: DataProvider
    
    weak var delegate: RecipesListCoordinatorDelegate?
    
    let recipeId: String
    
    lazy var recipeDetailsViewModel: RecipeDetailsViewModel! = {
        let viewModel = RecipeDetailsViewModel(dataProvider: self.dataProvider,
                                               recipeId: self.recipeId)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()

    init(dataProvider: DataProvider, rootViewController: UINavigationController,
         recipeId: String) {
        self.dataProvider = dataProvider
        self.rootViewController = rootViewController
        self.recipeId = recipeId
    }
    
    override func start() {
        let recipeDetailsViewController = RecipeDetailsViewController(nibName: Constants.RecipeDetailsScreenName,
                                                                      bundle: nil)
        recipeDetailsViewController.viewModel = recipeDetailsViewModel
        rootViewController.pushViewController(recipeDetailsViewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}
