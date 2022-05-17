//
//  AdminLogin.swift
//  Protyes
//
//  Created by Suad Warsame on 13/04/2022.
//
//

import SwiftUI

struct AdminLogin: View {
    
    @State var showAdminContent = false
    @State var password = ""
    @State var email = "admin@gmail.com"
    @State var errorMessage = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                
                VStack{
                    Text("Admin")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                        
                    Spacer()
                        .frame(height: 50)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    Spacer()
                        .frame(height: 50)
                    Button {
                        loginUser()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Sign In")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system( size: 14, weight: .semibold))
                                .frame(width: 300, height: 50)
                            Spacer()
                        }.background(Color.blue)
                    }
                    .fullScreenCover(isPresented: $showAdminContent, content: {
                        
                        AdminContentView()
                    })
                    
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                    
                    
                  
                
                            
                    }
                    
            }
        }
        .navigationBarHidden(false)
    }
    
    // Directs admin to admin page if the correct password is inputted
    private func handleAction() {
        loginUser()
        
        if FirebaseManager.shared.auth.currentUser != nil {
            showAdminContent = true
            
        } else{
                showAdminContent = false
            }
    }
    
    // User information is sent to firebase Auth to get verfied
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err{
                print("Failed to login user:", err)
                self.errorMessage = "Failed to login user: \(err)"
                return
            }
            print("Successfully logged in as user : \(result?.user.uid ?? "")")
            self.errorMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
                
            if FirebaseManager.shared.auth.currentUser != nil {
                showAdminContent = true }
            
        }
       
        
    }
}

struct AdminLogin_Previews: PreviewProvider {
    static var previews: some View {
        AdminLogin()
    }
}
