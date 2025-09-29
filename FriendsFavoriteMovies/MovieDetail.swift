//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 26/09/2025.
//

import SwiftUI

struct MovieDetail: View {
    @Bindable var movie: Movie
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(movie: Movie, isNew: Bool = false) {
        self.movie = movie
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $movie.title)
                .autocorrectionDisabled()
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
            if !movie.favoritedBy.isEmpty {
                Section("Favorited by") {
                    let friends = movie.getSortedFriends()
                    ForEach(friends) { friend in
                        Text(friend.name)
                    }
                    .onDelete(perform: deleteFriend(indexes:))
                }
            }
        }
        .navigationTitle(isNew ? "New Movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {if isNew {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    movie.releaseDateDescription = movie.releaseDate.description
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    context.delete(movie)
                    dismiss()
                }
            }
        }
            ToolbarItem {
                EditButton()
            }
        }
    }
    private func deleteFriend(indexes: IndexSet) {
        for index in indexes {
            movie.favoritedBy[index].removeFavoritedMovie()
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
    }
}
#Preview("New Movie") {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie, isNew: true)
    }
}
