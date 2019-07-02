import Alamofire

class DataProvider {

    var recipes : RecipesData
    
    init() {
        self.recipes = RecipesData()
    }

    func fetchData() {
        Alamofire.request(Constants.apiUrl).responseData {response in
            
            guard let data = response.data else {
                return
            }
            
            
            let decoder = JSONDecoder()
            
            do {
                self.recipes = try decoder.decode(RecipesData.self, from: data)

            } catch let error {
                print(error)
                return
            }
        }
    }
    
    func getRecipes() -> RecipesData {
        return recipes
    }
}
