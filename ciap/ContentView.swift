import SwiftUI

struct ContentList: View {
    @ObservedObject var dataViewModel = DataViewModel()
    
    
    var body: some View {
        List(dataViewModel.posts) { post in
            NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))) {
                VStack(alignment: .leading) {
                    HStack {
                        HStack {
                            URLImage(urlString: dataViewModel.person(for: post)?.photouser ?? "")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .cornerRadius(52)

                            Text(dataViewModel.person(for: post)?.name ?? "")
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
            .padding(.bottom, 8)
            .padding(.top, 8)
            .listRowSeparator(.hidden)
        }.listStyle(.inset)
        .navigationTitle("Posts")
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct Home : View {
    @State private var readyToNavigate : Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingPageSearchDetail = false
    
    var body : some View {
        
        NavigationView{
            ContentList()
                .navigationBarTitleDisplayMode(.inline)
            
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
//                        NavigationLink(destination: SearchDetail()) {
//                            Image(systemName: "magnifyingglass.circle.fill").foregroundColor(.gray)
//                                    .font(.system(size: 24))
//                        }.navigationBarTitle("Home", displayMode: .inline)
//                            .navigationBarBackButtonHidden(true)
                        
                        Button(action: {
                            isShowingPageSearchDetail = true
                        }) {
                            Image(systemName: "magnifyingglass.circle.fill").foregroundColor(.gray)
                                    .font(.system(size: 24))
                        }
                        
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack{
                            Image("Ciapciap")
                                .frame(width: 200, height: 30, alignment: .center)
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 2){
                            Image("sort")
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                        }
                    }
            }.sheet(isPresented: $isShowingPageSearchDetail) {
//                SearchDetail()
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                Home()
                    .tabItem {
                        Image("homeIcon")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Home")
                    }.tag(0)
                
                Home()
                    .tabItem {
                        Image("homeIcon")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("History")
                    }.tag(1)
                
                Home()
                    .tabItem {
                        Image("homeIcon")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Saved")
                    }.tag(2)
                
                ProfileDetail()
                    .tabItem {
                        Image("profile")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Profile")
                    }.tag(3)
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
