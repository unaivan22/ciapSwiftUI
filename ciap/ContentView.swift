//
//  ContentView.swift
//  ciap
//
//  Created by una ivan on 06/07/23.
//

import SwiftUI

struct Person: Codable, Identifiable {
    let id: Int
    let name: String
    let photouser: String
    let posts: [Post]
}

struct Post: Codable, Identifiable {
    let id: Int
    let background: String
    let fontbackground: String
    let date: String
    let fav: Int
    let ciap: String
    let loved: Bool
}

class DataViewModel: ObservableObject {
    @Published var people: [Person] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/unaivan22/openJson/main/ciap.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let jsonData = try JSONDecoder().decode([Person].self, from: data)
                DispatchQueue.main.async {
                    self.people = jsonData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct DataListView: View {
    @ObservedObject var dataViewModel = DataViewModel()
    
    var body: some View {
        NavigationView {
            List(dataViewModel.people) { person in
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.headline)
                    AsyncImage(urlString: person.photouser)
                        .frame(height: 200)
                        .aspectRatio(contentMode: .fit)
                    
                    ForEach(person.posts) { post in
                        VStack(alignment: .leading) {
                            Text("Post \(post.id)")
                                .font(.subheadline)
                            AsyncImage(urlString: person.photouser)
                                .frame(height: 100)
                                .aspectRatio(contentMode: .fit)
                            Text("Date: \(post.date)")
                            Text(post.ciap)
                                .foregroundColor(.secondary)
                            Text("Favorites: \(post.fav)")
                                .foregroundColor(.secondary)
                            Text(post.loved ? "Loved" : "Not Loved")
                                .foregroundColor(.secondary)
                        }
                        .padding(.leading)
                    }
                }
                .padding()
            }
            .navigationTitle("Data List")
        }
    }
}

struct AsyncImage: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(urlString: String) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "photo")
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let loadedImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }.resume()
    }
}

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                DataListView()
                    .tabItem {
                        Image("homeIcon")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("home")
                    }.tag(0)
                ProfileDetail()
                    .tabItem {
                        Image("homeIcon")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("home")
                    }.tag(1)
            }
            .accentColor(.black)
        }.background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
