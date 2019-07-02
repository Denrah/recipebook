class RecipesListViewModel {
    
    weak var coordinatorDelegate : RecipesListCoordinator?
    
    let dataProvider : DataProvider
    var recipes = Dynamic<RecipesData>(RecipesData())
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func start() {
        getRecipes()
    }
    
    func getRecipes() {
        dataProvider.fetchData { (recipesData) in
            self.recipes.value = recipesData
        }
    }
    
    func goToRecipeDetails(id: String) {
        coordinatorDelegate?.goToRecipeDetails(id: id)
    }
    
}
