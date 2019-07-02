class RecipesListViewModel {
    
    weak var coordinator : RecipesCoordinator?
    weak var view : RecipesListViewController?
    
    fileprivate let dataProvider : DataProvider
    fileprivate var recipes : RecipesData!
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func start() {
        getRecipes()
    }
    
    func getRecipes() {
        self.recipes = dataProvider.getRecipes()
        print(self.recipes)
    }
    
}
