//
//  Profile.swift
//  Rumahku
//
//  Created by una ivan on 20/06/23.
//

import SwiftUI

struct ProfileDetail: View {
    
    var body: some View {
        NavigationView{
            Form {
                Section(){
                    NavigationLink(destination:About()) {
                        HStack{
                            //Profile photo
                            Image("una")
                                .resizable()
                                .frame(width: 60.0, height: 60.0)
                                .clipShape(Circle())
                            
                            //Nama dan Status
                            VStack(alignment:.leading){
                                Text("Unaivan")
                                    .font(.custom("Manrope-Medium", size: 20))
                                Text("Prototyper")
                                    .font(.custom("Manrope-Regular", size: 14))
                            }
                            
                            
                        }
                    }
                }
                .padding(.top,5)
                .padding(.bottom,5)
                
                
                //navigation pesan berbintang
                Section(header: Text("Setting")){
                    NavigationLink(destination:About()) {
                        //Image Bintang
                        HStack(spacing:20){
                            Image(systemName: "person")
                                .frame(width:46, height:46)
//                                .background(Color.orange)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            //Text
                            Text("Personal Information")
                        }
                    }
                    
                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "checkerboard.shield")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("Login & Security")
                        }
                    }

                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "bell")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("Notification")
                        }
                    }

                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "lock")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("Privacy & Sharing")
                        }
                    }

                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "bag")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("House for Work")
                        }
                    }
                    
                }
                
                //Akun
                Section(header: Text("Support")){
                    
                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "phone")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("Contact Support")
                        }
                    }

                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "questionmark.circle")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("Get help")
                        }
                    }

                    NavigationLink(destination:About()) {
                        HStack(spacing:20){
                            Image(systemName: "pencil")
                                .frame(width:46, height:46)
                                .cornerRadius(10)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 24))
                            Text("Give us Feedback")
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Profile")
        }
    }
}

struct About : View {
    var body: some View {
        Text("Hallo")
    }
}
