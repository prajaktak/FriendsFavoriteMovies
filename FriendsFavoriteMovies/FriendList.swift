//
//  FriendList.swift
//  FriendsFavoriteMovies
//
//  Created by Prajakta Kulkarni on 25/09/2025.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query var friends: [Friend]
    // @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: Friend?
    
    init(nameFilter: String = "") {
        let predicate = #Predicate<Friend> { friend in
            nameFilter.isEmpty || friend.name.localizedStandardContains(nameFilter)
        }
        _friends = Query(filter: predicate, sort: \Friend.name)
    }
    
    var body: some View {
        Group {
            if !friends.isEmpty {
                List {
                    ForEach(friends) { friend in
                        NavigationLink(friend.name) {
                            FriendDetail(friend: friend)
                        }
                    }
                    .onDelete(perform: deleteFriend(indexes:))
                }
            } else {
                ContentUnavailableView("Add Friends", systemImage: "person.and.person")
            }
        }
        .navigationTitle("Friends")
        .toolbar {
            ToolbarItem {
                Button("Add friend", systemImage: "plus", action: addFriend)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newFriend) { friend in
            NavigationStack {
                FriendDetail(friend: friend, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }
    private func addFriend() {
        let newFriend = Friend(name: "")
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    private func deleteFriend(indexes: IndexSet) {
        for index in indexes {
            context.delete(friends[index])
        }
    }
}

#Preview {
    NavigationStack {
        FriendList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
#Preview("Empty List") {
    NavigationStack {
        FriendList()
            .modelContainer(for: Friend.self, inMemory: true)
    }
}
