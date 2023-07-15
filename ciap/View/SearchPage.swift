//
//  SearchPage.swift
//  ciap
//
//  Created by una ivan on 15/07/23.
//

import SwiftUI


struct Search: View {
    
    @ObservedObject var dataViewModel = DataViewModel()
        @State private var searchText = ""

        var body: some View {
            NavigationView {
                VStack {
                    SearchBar(text: $searchText)

                    List(filteredPeople) { person in
                        NavigationLink(destination: PersonView(person: person)) {
                            Text(person.name)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("Search")
            }
        }
        
        var filteredPeople: [Person] {
            if searchText.isEmpty {
                return dataViewModel.people
            } else {
                return dataViewModel.people.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
}


struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}


struct PostRow: View {
    var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.ciap)
                .font(.headline)
            Text(post.date)
                .font(.subheadline)
            // Add more details or components to display as needed
        }
        .padding()
    }
}



import SwiftUI

struct PersonView: View {
    var person: Person?

    var body: some View {
        if let person = person {
            VStack {
                // Display person details here, e.g., name, photo, bio, etc.
                // You can customize this view according to your needs
                Text(person.name)
                // Add more details
            }
            .navigationTitle(person.name)
        } else {
            Text("Person not found")
                .navigationTitle("Error")
        }
    }
}
