struct Recipe: Codable {
    var uuid: String
    var name: String
    var images: [String]
    var lastUpdated: Int
    var description: String?
    var instructions: String
    var difficulty: Int
    
    init() {
        self.uuid = ""
        self.name = ""
        self.images = [String]()
        self.lastUpdated = 0
        self.description = ""
        self.instructions = ""
        self.difficulty = 0
    }
}
