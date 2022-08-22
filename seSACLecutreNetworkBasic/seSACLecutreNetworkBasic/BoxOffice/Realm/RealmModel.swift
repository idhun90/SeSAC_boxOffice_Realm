import Foundation

import RealmSwift

class RealmBoxOffice: Object {
    @Persisted var movieTitle: String
    @Persisted var releaseDate: String
    @Persisted var totalPersonCount: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(movieTitle: String, releaseDate: String, totalPersonCount: String) {
        self.init()
        self.movieTitle = movieTitle
        self.releaseDate = releaseDate
        self.totalPersonCount = totalPersonCount
    }
}
