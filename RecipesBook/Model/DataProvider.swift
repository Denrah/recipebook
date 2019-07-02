import Alamofire

class DataProvider {

    var recipes : RecipesData
    
    init() {
        self.recipes = RecipesData()
    }

    func fetchData(completion: @escaping (RecipesData) -> Void) {
        Alamofire.request(Constants.apiUrl).responseData {response in
            
            guard let data = response.data else {
                return
            }
            
            
            let decoder = JSONDecoder()
            
            do {
                self.recipes = try decoder.decode(RecipesData.self, from: data)
                completion(self.recipes)

            } catch let error {
                print(error)
                return
            }
        }
    }
    
    func getRecipes() -> RecipesData {
        return recipes
    }
    
    func getRecipeById(id: String) -> Recipe? {
        var recipe = self.recipes.recipes.filter { $0.uuid == id }
        guard recipe.count > 0 else {
            return nil
        }
        return recipe[0]
    }
}
