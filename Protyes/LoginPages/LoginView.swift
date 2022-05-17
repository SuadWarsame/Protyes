//
//  LoginView.swift
//  Protyes
//
//  Created by Suad Warsame on 13/04/2022.
//


import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


struct LoginView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var shouldShowImagePicker = false
    @State var showHomeScreen: Bool = false
    @State var showAdminScreen: Bool = false
    
    //behavioral design pattern that allows an object to change the behavior when its internal state changes, so when the value changes, SwiftUI updates the parts of the view
   
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here"))  {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    if !isLoginMode{
                        Button {
                            shouldShowImagePicker.toggle()
                            
                        } label: {
                            VStack{
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128
                                             , height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size :64))
                                        .padding()
                                        .foregroundColor(Color(.label))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3))
                            
                            
                        }
                    }
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            
                        SecureField("Password", text: $password)
                            
                        
                    }.padding(12)
                        .background(.white)
                    
                    
                    
                    Button {
                        handleAction()
                            
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system( size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    
                    }
                    .fullScreenCover(isPresented: $showHomeScreen, content: {
                                UserContentView()
                          })
                    .fullScreenCover(isPresented: $showAdminScreen, content: {
                                AdminContentView()
                          })
                   
                    
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                }.padding()
                    
                    
            
           
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
    
    @State var image: UIImage?
    
    // Changes depending on if user is in login mode or sign up mode
    private func handleAction() {
        
        if isLoginMode{
            loginUser()
            //Check login deets
            
            //let user = FirebaseManager.shared.auth.currentUser?.email?.contains("Admin")
         //  let Admin = "Admin"
          
                //Check if Email is given back
         
        }else {
            createNewAccount()
            
        }
    }
    
    @State var errorMessage = ""
        // Function used to create the account by using firebase Auth
        private func createNewAccount() {
            FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
                if let err = err{
                    print("Failed to create user:", err)
                    self.errorMessage = "Failed to create user: \(err)"
                    return
                }
                print("Successfully created user : \(result?.user.uid ?? "")")
                self.errorMessage = "Successfuly created user: \(result?.user.uid ?? "")"
                
                self.persistImageToStorage()
                
                
        }
    }
    // Function used to store user image URL and information to firestore
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.errorMessage = "\(err)"
                    return
                }

                print("Success")
            }
    }
    
    //Save image to Fire Storage
    
    private func persistImageToStorage() {
    //    let filename = UUID().uuidString
        //Current user UID
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else{
            return
        }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.errorMessage = "Failed to push image to Storage: \(err)"
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    self.errorMessage = "Failed to retrieve download URL: \(err)"
                    return
                }
                self.errorMessage = "Successfully stored image with url \(url?.absoluteString ?? "")"
                
                guard let url = url else {return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
        
    }
    
    // Auth user by sending the inputed information to firebase auth
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
                   showHomeScreen = true
                   
               }
                
                
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
