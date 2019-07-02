class RecipeDetailsViewModel {
    
    weak var coordinatorDelegate : RecipeDetailsCoordinator?
    //var viewDelegate : RecipesListViewControllerType?
    
    var recipeId = Dynamic<String>("")
    var recipe = Dynamic<Recipe>(Recipe())
    
    let dataProvider : DataProvider
    
    init(dataProvider: DataProvider, id: String) {
        self.dataProvider = dataProvider
        self.recipeId = Dynamic<String>(id)
        guard let data = dataProvider.getRecipeById(id: id) else  {
            return
        }
        self.recipe.value = data
    }
    
    func goBack() {
        coordinatorDelegate?.finish()
    }
    
}
