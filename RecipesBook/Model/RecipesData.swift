struct RecipesData : Codable {
    var recipes: [Recipe]
    
    init() {
        self.recipes = [Recipe]()
    }
}
