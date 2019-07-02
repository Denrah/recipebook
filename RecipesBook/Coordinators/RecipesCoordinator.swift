import UIKit

class RecipesCoordinator: Coordinator {

    let rootViewController: UINavigationController
    
    
    let dataProvider: DataProvider
    
    // MARK: VM / VC's
   /* lazy var searchInputViewModel: SearchInputViewModel! = {
        let viewModel = SearchInputViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    var locationSearchViewModel: LocationSearchViewModel {
        let placeService = PlaceApiService(apiClient: apiClient, plistClient: PlistClient())
        let viewModel = LocationSearchViewModel(service: placeService)
        viewModel.coordinatorDelegate = self
        return viewModel
    }*/
    
    lazy var recipesListViewModel: RecipesListViewModel! = {
        let viewModel = RecipesListViewModel(dataProvider: self.dataProvider)
        viewModel.coordinator = self
        return viewModel
    }()
    
    // MARK: - Coordinator
    init(dataProvider: DataProvider, rootViewController: UINavigationController) {
        self.dataProvider = dataProvider
        self.rootViewController = rootViewController
    }
    
    override func start() {
        let recipesListViewController = RecipesListViewController(nibName: "RecipesListViewController", bundle: nil)
        
        recipesListViewController.coordinator = self
        recipesListViewController.viewModel = recipesListViewModel
        
        
        rootViewController.setViewControllers([recipesListViewController], animated: false)
    }
    
    override func finish() {
        // Clean up any view controllers. Pop them of the navigation stack for example.
        //delegate?.didFinish(from: self)
    }
    
}

extension RecipesCoordinator {
    
    func goToRecipeDetails() {
        
        let recipeDetailsViewController = RecipeDetailsViewController(nibName: "RecipeDetailsViewController", bundle: nil)
        
        rootViewController.pushViewController(recipeDetailsViewController, animated: true)
    }
}
