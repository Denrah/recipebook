struct Recipe : Codable {
    var uuid : String
    var name : String
    var images : [String]
    var lastUpdated : Int
    var description : String?
    var instructions : String
    var difficulty : Int
}
