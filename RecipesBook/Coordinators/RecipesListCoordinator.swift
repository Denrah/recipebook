import UIKit

class RecipesListCoordinator: Coordinator {

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
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    // MARK: - Coordinator
    init(dataProvider: DataProvider, rootViewController: UINavigationController) {
        self.dataProvider = dataProvider
        self.rootViewController = rootViewController
    }
    
    override func start() {
        let recipesListViewController = RecipesListViewController(nibName: "RecipesListViewController", bundle: nil)
        
        recipesListViewController.viewModel = recipesListViewModel
        
        
        rootViewController.setViewControllers([recipesListViewController], animated: false)
    }
    
    override func finish() {
        // Clean up any view controllers. Pop them of the navigation stack for example.
        //delegate?.didFinish(from: self)
    }
    
}

extension RecipesListCoordinator {
    
    func goToRecipeDetails(id: String) {
        
        let recipeDetailsCoordinator = RecipeDetailsCoordinator(dataProvider: self.dataProvider, rootViewController: self.rootViewController, id: id)
        
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
