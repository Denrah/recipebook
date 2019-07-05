import UIKit

class RecipesListViewModel {
    
    weak var coordinatorDelegate: RecipesListCoordinator?
    
    private let dataProvider: DataProvider
    var recipes = Dynamic<RecipesData?>(RecipesData())
    var isLoading = Dynamic<Bool>(true)
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func start() {
        getRecipes()
    }
    
    private func getRecipes() {
        isLoading.value = true
        dataProvider.fetchData { (recipesData) in
            self.recipes.value = recipesData
            self.isLoading.value = false
        }
    }
    
    func updateRecipes(completion: @escaping () -> Void) {
        dataProvider.fetchData { (recipesData) in
            self.recipes.value = recipesData
            completion()
        }
    }
    
    func goToRecipeDetails(index: Int) {
        coordinatorDelegate?.goToRecipeDetails(recipeId: self.recipes.value??.recipes[index].uuid ?? "")
    }
    
    func searchRecipes(text: String, sortingType: SortingType) {
        self.recipes.value = dataProvider.searchRecipes(text: text, sortingType: sortingType)
    }
    
    func sortRecipes(sortingType: SortingType) {
        self.recipes.value = dataProvider.sortRecipes(sortingType: sortingType,
                                                      recipesData: self.recipes.value ?? RecipesData())
    }
}
