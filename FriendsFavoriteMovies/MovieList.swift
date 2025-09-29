//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 25/09/2025.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie]
    // @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    init(titleFilter: String = "", isFileredByTitle: Bool) {
        if isFileredByTitle {
            let predicate = #Predicate<Movie> { movie in
                titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
            }
            _movies = Query(filter: predicate, sort: \Movie.title)
        } else {
            print("Inside else")
            let predicate = #Predicate<Movie> { movie in
                titleFilter.isEmpty || movie.releaseDateDescription.localizedStandardContains(titleFilter)
            }
            _movies = Query(filter: predicate, sort: \Movie.releaseDateDescription)
        }
    }
    
    var body: some View {
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(movie.title) {
                            MovieDetail(movie: movie)
                        }
                    }
                    .onDelete(perform: deleteMovies(indexes:))
                    .onAppear(perform: {
                        printMovies(indexes: true)
                    })
                    
                }
            } else {
                ContentUnavailableView("Add Movies", systemImage: "film.stack")
            }
        }
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem {
                Button("Add Movie", systemImage: "plus", action: addMovie)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            
        }
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
        }
        .interactiveDismissDisabled()
    }
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    private func deleteMovies(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
    private func printMovies(indexes: Bool) {
        for movie in movies {
            movie.printSelf()
        }
    }
}

#Preview {
    NavigationStack {
        MovieList(isFileredByTitle: true)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
#Preview("Filtered") {
    NavigationStack {
        MovieList(titleFilter: "tr", isFileredByTitle: true)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
#Preview("Empty List") {
    NavigationStack {
        MovieList(isFileredByTitle: true)
            .modelContainer(for: Movie.self, inMemory: true)
    }
}
