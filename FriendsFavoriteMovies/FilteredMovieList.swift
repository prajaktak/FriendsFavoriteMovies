//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 29/09/2025.
//

import SwiftUI

struct FilteredMovieList: View {
    @State private var searchText = ""
    @State private var isFileredByTitle: Bool = false

    var body: some View {
        NavigationSplitView {
            ZStack {
                MovieList(titleFilter: searchText, isFileredByTitle: isFileredByTitle)
                    .searchable(text: $searchText)
            }
            .toolbar {
                ToolbarItem {
                    Toggle("Filter By Title", isOn: $isFileredByTitle)
                }
            }
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem {
                Toggle("Filter By Title", isOn: $isFileredByTitle)
            }
        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
