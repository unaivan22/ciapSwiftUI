import SwiftUI
import URLImage

struct ContentList: View {
    @ObservedObject var dataViewModel = DataViewModel()
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if number >= 1000000 {
            let millionNumber = Double(number) / 1000000.0
            return "\(formatter.string(from: NSNumber(value: millionNumber)) ?? "")M"
        } else if number >= 1000 {
            let thousandNumber = Double(number) / 1000.0
            return "\(formatter.string(from: NSNumber(value: thousandNumber)) ?? "")K"
        } else {
            return "\(number)"
        }
    }
    
    
    var body: some View {
        List(dataViewModel.posts) { post in
            NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top){
                        VStack {
                            URLImage(urlString: dataViewModel.person(for: post)?.photouser ?? "")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .cornerRadius(52)
                            
                            Image("vline")
//                                .frame(maxWidth: .infinity)
//                                .frame(width: 2)
                                .frame(height: .infinity, alignment: .top)
                            
                        }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))

                        VStack(alignment: .leading){
                            HStack{
                                NavigationLink(destination: UserSpeech(person: dataViewModel.person(for: post)!) /* Add the person argument here */) {
                                    Text(dataViewModel.person(for: post)?.name ?? "")
                                        .font(.system(size: 16))
                                        .bold()
                                }
//                                Text(post.date)
//                                    .font(.headline)
                            }
                            Text(post.ciap)
                                .foregroundColor(.secondary)
                                .font(.system(size: 14))
                        }
                    }
                    HStack(spacing: 6){
                        HStack(spacing: -13){
                            URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                            
                            URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                            
                            URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())

                        }
                        HStack(spacing: 24){
                            HStack(spacing: 2){
                                Image(systemName: "heart")
                                Text(formatNumber(post.likes))
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            HStack(spacing: 2){
                                Image(systemName: "arrow.2.squarepath")
                                Text(formatNumber(post.respeech))
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            HStack(spacing: 2){
                                Image(systemName: "message")
//                                Text("\(post.responseCount)")
                                Text(formatNumber(post.responseCount))
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }.frame(maxWidth: .infinity, alignment: .leading)
//                            HStack(spacing: 2){
//                                Image(systemName: "paperplane")
//                            }
                        }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                    }
                    .padding(.bottom, 8)
                    Divider()
                }
            }
//            .padding(.top, 8)
            .listRowSeparator(.hidden)
        }.listStyle(.plain)
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
            TestList()
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
                            Image("una")
                                .resizable()
                                .frame(width: 30.0, height: 30.0)
                                .clipShape(Circle())
                        }
                        
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack{
//                            Image("speech")
//                                .frame(width: 200, height: 30, alignment: .center)
                            Text("Speech")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                                .bold()
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 2){
                            Text("Post")
                                .foregroundColor(.blue)
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
        NavigationView{
            TabView(selection: $selectedTab) {
                Search()
                    .tabItem {
                        Image(systemName: "house")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Home")
                    }.tag(0)
                
                
                ProfileDetail()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Search")
                    }.tag(1)
                
                ProfileDetail()
                    .tabItem {
                        Image(systemName: "bell")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Notification")
                    }.tag(2)
                
                ProfileDetail()
                    .tabItem {
                        Image(systemName: "gear")
                            .renderingMode(.template)
                            .environment(\.symbolVariants, .none)
                        Text("Setting")
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


struct TestView: View {
    @StateObject private var dataViewModel = DataViewModel()

        var body: some View {
            NavigationView {
                List(dataViewModel.posts) { post in
                    VStack(alignment: .leading) {
                        HStack {
                            NavigationLink(destination: UserSpeech(person: dataViewModel.person(for: post)!) /* Add the person argument here */) {
                                Text("Profile")
                            }
                            
                            
                            
                        }
                        // Additional post details
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            
                            
                            NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))) {
                                Text("Post \(post.id)")
                            }
                            Spacer()
                            
                        }
                        // Additional post details
                    }
                }
                .navigationTitle("Posts")
            }
            .onAppear {
                dataViewModel.fetchData()
            }
        }
}


struct TestList: View {
    @ObservedObject var dataViewModel = DataViewModel()
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if number >= 1000000 {
            let millionNumber = Double(number) / 1000000.0
            return "\(formatter.string(from: NSNumber(value: millionNumber)) ?? "")M"
        } else if number >= 1000 {
            let thousandNumber = Double(number) / 1000.0
            return "\(formatter.string(from: NSNumber(value: thousandNumber)) ?? "")K"
        } else {
            return "\(number)"
        }
    }
    
    
    var body: some View {
        List(dataViewModel.posts) { post in
//            VStack(alignment: .leading){
                
                NavigationLink(destination: UserSpeech(person: dataViewModel.person(for: post)!)) {
                    VStack(alignment: .leading){
                        HStack{
                            URLImage(urlString: dataViewModel.person(for: post)?.photouser ?? "")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .cornerRadius(52)
                            
                            Text(dataViewModel.person(for: post)?.name ?? "")
                                .font(.system(size: 16))
                                .bold()
                        }
                        HStack(){
                            ///untukk set width
                        }.frame(width: UIScreen.main.bounds.width - 40)
                    }.frame(width: UIScreen.main.bounds.width)
                }

                NavigationLink(destination: PostDetail(post: post, person: dataViewModel.person(for: post))) {
                    VStack(alignment: .leading){
                        HStack{
                            Text(post.ciap)
                                .foregroundColor(.secondary)
                                .font(.system(size: 16))
                        }.padding(EdgeInsets(top: -20, leading: 60, bottom: 0, trailing: 0))
                        
                        HStack(spacing: 6){
                            HStack(spacing: -13){
                                URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                
                                URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                
                                URLImage(urlString: post.thumbhs) .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                
                            }
                            HStack(spacing: 24){
                                HStack(spacing: 2){
                                    Image(systemName: "heart")
                                    Text(formatNumber(post.likes))
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing: 2){
                                    Image(systemName: "arrow.2.squarepath")
                                    Text(formatNumber(post.respeech))
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing: 2){
                                    Image(systemName: "message")
                                    Text(formatNumber(post.responseCount))
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                }.frame(maxWidth: .infinity, alignment: .leading)
                            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                        }.padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 15))
                        HStack(){
                            ///untukk set width
                        }.frame(width: UIScreen.main.bounds.width - 40)
                        .padding(.bottom, 8)
                        Divider()
                    }.frame(width: UIScreen.main.bounds.width)
                }
            
            .listRowSeparator(.hidden)
        }.listStyle(.plain)
        .navigationTitle("Posts")
        .frame(width: UIScreen.main.bounds.width)
        
    }
}
