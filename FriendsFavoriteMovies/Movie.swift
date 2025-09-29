//
//  Movie.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 24/09/2025.
//

import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    var favoritedBy: [Friend] = []
    var releaseDateDescription: String
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
        self.releaseDateDescription = releaseDate.description
    }
    static let sampleData = [
        Movie(title: "Amusing Space Traveler 3",
              releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        Movie(title: "Difficult Cat",
                    releaseDate: Date(timeIntervalSinceReferenceDate: -20_000_000)),
              Movie(title: "Electrifying Trek",
                    releaseDate: Date(timeIntervalSinceReferenceDate: 300_000_000)),
              Movie(title: "Reckless Train Ride 2",
                    releaseDate: Date(timeIntervalSinceReferenceDate: 120_000_000)),
              Movie(title: "The Last Venture",
                    releaseDate: Date(timeIntervalSinceReferenceDate: 550_000_000)),
              Movie(title: "Glamorous Neighbor",
                    releaseDate: Date(timeIntervalSinceReferenceDate: -1_700_000_000))
    ]
    func getSortedFriends() -> [Friend] {
        if self.favoritedBy.count > 1 {
            self.favoritedBy.sorted { first, second in
                first.name < second.name
            }
        } else {
            self.favoritedBy
        }
    }
    func printSelf() {
        print(self.title)
        print(self.releaseDate)
        print(self.releaseDate.description)
        print(self.releaseDateDescription)
        print("_______________________________")
    }

}
