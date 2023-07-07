import SwiftUI

struct aaaa: View {
    @ObservedObject var dataViewModel = DataViewModel()

    var body: some View {
        NavigationView {
            List(dataViewModel.posts) { post in
                if let person = dataViewModel.person(for: post) {
                    VStack(alignment: .leading) {
                        HStack {
                            HStack {
                                URLImage(urlString: person.photouser)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(52)

                                Text(person.name)
                                    .font(.headline)
                            }
                            Text(post.date)
                                .font(.headline)
                        }

                        Text(post.ciap)
                            .foregroundColor(.secondary)
                    }
//                    .padding()
                }
            }.listStyle(.plain)
            .navigationTitle("Posts")
        }
    }
}


struct ContentView: View {
    @ObservedObject var dataViewModel = DataViewModel()
    
    
    var body: some View {
        NavigationView {
            List(dataViewModel.posts) { post in
                NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))) {
                    VStack(alignment: .leading) {
                        HStack {
                            HStack {
                                URLImage(urlString: dataViewModel.person(for: post)?.photouser ?? "")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)

                                Text(dataViewModel.person(for: post)?.name ?? "")
                                    .font(.headline)
                            }
                            Text(post.date)
                                .font(.headline)
                        }
                        
                        Text("Background: \(post.background)")
                            .foregroundColor(.secondary)
                        Text("Date: \(post.date)")
                            .foregroundColor(.secondary)
                        Text("CIAP: \(post.ciap)")
                            .foregroundColor(.secondary)
                    }
//                    .padding()
                }
            }.listStyle(.plain)
            .navigationTitle("Posts")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
