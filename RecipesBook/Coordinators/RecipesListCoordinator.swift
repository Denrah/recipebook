import UIKit

class RecipesListCoordinator: Coordinator {

    let rootViewController: UINavigationController
    
    private let dataProvider: DataProvider
    
    lazy var recipesListViewModel: RecipesListViewModel! = {
        let viewModel = RecipesListViewModel(dataProvider: self.dataProvider)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(dataProvider: DataProvider, rootViewController: UINavigationController) {
        self.dataProvider = dataProvider
        self.rootViewController = rootViewController
    }
    
    override func start() {
        let recipesListViewController = RecipesListViewController(nibName: Constants.RecipesListScreenName,
                                                                  bundle: nil)
        recipesListViewController.viewModel = recipesListViewModel
        rootViewController.setViewControllers([recipesListViewController], animated: false)
    }
}

extension RecipesListCoordinator {
    func goToRecipeDetails(recipeId: String) {
        let recipeDetailsCoordinator = RecipeDetailsCoordinator(dataProvider: self.dataProvider,
                                                                rootViewController: self.rootViewController, recipeId: recipeId)
        recipeDetailsCoordinator.delegate = self
        addChildCoordinator(recipeDetailsCoordinator)
        recipeDetailsCoordinator.start()
    }
}

extension RecipesListCoordinator : RecipesListCoordinatorDelegate {
    func didFinish(from coordinator: RecipeDetailsCoordinator) {
        removeChildCoordinator(coordinator)
    }
}
