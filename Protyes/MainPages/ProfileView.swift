//
//  ProfileView.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI
import FirebaseFirestore
import MapKit

struct MainUser {
    let uid, email, profileImageUrl: String
}


class UserInfoModel: ObservableObject{
    
    
    @Published var email = ""
    @Published var errorMessage = ""
    
    init() {
        fetchCurrentUser()
    }
    private func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{
            self.errorMessage = "No UID found"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error{
                print("failed to fetch current user", error)
                return
            }
            guard let data = snapshot?.data() else{
                return
            }
            
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            let chatUser = MainUser(uid: uid, email: email, profileImageUrl: profileImageUrl)
            
            
            self.email = chatUser.email
        }
        
        
    }
}

   

struct Live: Identifiable {
 var id: String
 var name: String
 var liveLatitude : Double
 var liveLongitude : Double
}
    
//struct Cities: Codable, Identifiable {
//  var id: String?
 // var cities: [City]
//}







struct ProfileView: View {
    
    @State var showLogin = false
    @State var errorMessage = ""
    
   @ObservedObject private var vm = UserInfoModel()
    @ObservedObject private var postInfor = RecentProtestInfo()
    
    
    @ObservedObject private var viewModel = ProtestViewModel()
    
    var body: some View {
        
    
        
        NavigationView{
            ZStack{
                
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
