//
//  Api Services.swift
//  ciap
//
//  Created by una ivan on 07/07/23.
//

import Foundation

class DataViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var people: [Person] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/unaivan22/openJson/main/ciap.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode([String: [Person]].self, from: data)
                self.people = jsonData.values.flatMap { $0 }
                self.posts = self.people.flatMap { $0.posts }
                
                DispatchQueue.main.async {
                    self.posts.sort()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func person(for post: Post) -> Person? {
        return people.first { $0.posts.contains(post) }
    }
}

