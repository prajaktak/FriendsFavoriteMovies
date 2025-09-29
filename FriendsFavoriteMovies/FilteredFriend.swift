//
//  FilteredFriend.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 29/09/2025.
//

import SwiftUI

struct FilteredFriend: View {
    @State private var searchText = ""
    var body: some View {
        NavigationSplitView {
            FriendList(nameFilter: searchText)
                .searchable(text: $searchText)
            
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    FilteredFriend()
        .modelContainer(SampleData.shared.modelContainer)
}
