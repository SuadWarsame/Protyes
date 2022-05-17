//
//  ProfileView.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI
import FirebaseFirestore
import MapKit
import SDWebImageSwiftUI



   

struct Live: Identifiable {
 var id: String
 var name: String
 var liveLatitude : Double
 var liveLongitude : Double
}
    







struct ProfileView: View {
    
    @State var showLogin = false
    @State var errorMessage = ""
    
   @ObservedObject private var vm = UserInfoModel()
    @ObservedObject private var postInfor = RecentProtestInfo()
    
    
    @ObservedObject private var viewModel = ProtestViewModel()
    
    var body: some View {
        
    
        
        NavigationView{
            ZStack{
                
                //image
             
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                
                VStack{
                    

                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                    Spacer()
                        .frame(height: 50)
                    WebImage(url: URL(string: vm.profileImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(44)
                    Text(vm.email)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                        
                    
                    
                    Spacer()
                        .frame(height: 50)
                    Button {
                        signOut()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system( size: 14, weight: .semibold))
                                .frame(width: 300, height: 50)
                                
                            Spacer()
                        }.background(Color.blue)
                    }
                    .fullScreenCover(isPresented: $showLogin, content: {
                        
                        IntroView()
                    })
                    
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                    
                    
                  
                
                            
                    }
                    
            }
        }
        .navigationBarHidden(false)
    }
    //Sign out function
    private func signOut() {
        
       try? FirebaseManager.shared.auth.signOut()
        if FirebaseManager.shared.auth.currentUser == nil {
            showLogin = true
        }
        
    }
    
    
        
        
        
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
