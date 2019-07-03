class RecipeDetailsViewModel {
    
    weak var coordinatorDelegate : RecipeDetailsCoordinator?
    //var viewDelegate : RecipesListViewControllerType?
    
    var recipeId = Dynamic<String>("")
    var recipe = Dynamic<Recipe>(Recipe())
    
    let dataProvider : DataProvider
    
    init(dataProvider: DataProvider, recipeId: String) {
        self.dataProvider = dataProvider
        self.recipeId = Dynamic<String>(recipeId)
        guard let data = dataProvider.getRecipeById(recipeId: recipeId) else  {
            return
        }
        self.recipe.value = data
    }
    
    func goBack() {
        coordinatorDelegate?.finish()
    }
    
}
