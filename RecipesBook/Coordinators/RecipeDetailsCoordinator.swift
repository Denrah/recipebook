import UIKit

class RecipeDetailsCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    
    
    let dataProvider: DataProvider
    
    weak var delegate: RecipesListCoordinatorDelegate?
    
    let recipeId: String
    
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
    
    lazy var recipeDetailsViewModel: RecipeDetailsViewModel! = {
        let viewModel = RecipeDetailsViewModel(dataProvider: self.dataProvider, recipeId: self.recipeId)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    // MARK: - Coordinator
    init(dataProvider: DataProvider, rootViewController: UINavigationController, recipeId: String) {
        self.dataProvider = dataProvider
        self.rootViewController = rootViewController
        self.recipeId = recipeId
    }
    
    override func start() {
        let recipeDetailsViewController = RecipeDetailsViewController(nibName: "RecipeDetailsViewController", bundle: nil)
        
        recipeDetailsViewController.viewModel = recipeDetailsViewModel
        
        
        rootViewController.pushViewController(recipeDetailsViewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}
