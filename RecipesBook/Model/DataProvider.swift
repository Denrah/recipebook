import Alamofire

class DataProvider {

    var recipes : RecipesData
    
    init() {
        self.recipes = RecipesData()
    }

    func fetchData(completion: @escaping (RecipesData?) -> Void) {
        
        NetworkReachabilityManager(host: "https://www.apple.com/").map {
            if $0.isReachable {
                print(true)
            } else {
                print(false)
            }
        }
    
        
        guard NetworkReachabilityManager()!.isReachable else {
            completion(nil)
            return
        }
        
        Alamofire.request(Constants.apiUrl).responseData {response in
            
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            
            let decoder = JSONDecoder()
            
            do {
                self.recipes = try decoder.decode(RecipesData.self, from: data)
                completion(self.sortRecipes(sortingType: SortingType.name, recipesData: self.recipes))

            } catch let error {
                print(error)
                return
            }
        }
    }
    
    func getRecipes() -> RecipesData {
        return recipes
    }
    
    func getRecipeById(recipeId: String) -> Recipe? {
        var recipe = self.recipes.recipes.filter { $0.uuid == recipeId }
        guard recipe.count > 0 else {
            return nil
        }
        return recipe[0]
    }
    
    func searchRecipes(text: String, sortingType: Int) -> RecipesData {
        
        guard text != "" else {
            return sortRecipes(sortingType: sortingType, recipesData: self.recipes)
        }
        
        var data = RecipesData()
        data.recipes = self.recipes.recipes.filter { (recipe) -> Bool in
            if recipe.name.contains(text) || recipe.instructions.contains(text) || recipe.description?.contains(text) ?? false {
                return true
            }
            return false
        }
        
        return sortRecipes(sortingType: sortingType, recipesData: data)
    }
    
    func sortRecipes(sortingType: Int, recipesData: RecipesData?) -> RecipesData {
        var data = RecipesData()
        switch sortingType {
        case SortingType.name:
            data.recipes = recipesData?.recipes.sorted(by: { $0.name < $1.name }) ?? [Recipe]()
        case SortingType.updated:
            data.recipes = recipesData?.recipes.sorted(by: { $0.lastUpdated < $1.lastUpdated }) ?? [Recipe]()
        default:
            data.recipes = recipesData?.recipes.sorted(by: { $0.name < $1.name }) ?? [Recipe]()
        }
        
        return data
    }
}
