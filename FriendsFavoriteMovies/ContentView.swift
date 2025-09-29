//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 24/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            Tab("Friends", systemImage: "person.and.person") {
                FilteredFriend()
            }
            Tab("Movies", systemImage: "film.stack") {
               FilteredMovieList()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
