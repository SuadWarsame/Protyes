//
//  AdminPage.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import Foundation
import SwiftUI
import Firebase







struct AdminPage: View {
    
    @State var adminView = false
    @State var details = ""
    @State var name = ""
    @State var ID = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State var errorMessage = ""
    
    
    @State var liveName = ""
    @State var liveDetails = ""
    @State var liveID = ""
    @State var startLocation = ""
    @State var startTime = ""
    @State var endTime = ""
    @State var endLocation = ""
    @State var liveLatitude : Double
    @State var liveLongitude : Double
    @State var note = "Placegolder"
    
    
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16){
                    Picker(selection: $adminView, label: Text("Picker here"))  {
                        Text("Next Event")
                            .tag(true)
                        Text("Map")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    //Update next event
                    if adminView{
                    
                        //Image Picker Button in order to choose a picture to upload.
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
                        Group{
                            TextField("ID (Event1/Event2)", text: $ID)
                                .autocapitalization(.none)
                            
                            TextField("Title", text: $name)
                                .autocapitalization(.none)
                            Text("Description of the protest/ riot below")
                                
                            TextEditor(text: $details)
                                .autocapitalization(.none)
                                .frame( height: 250)
                                .cornerRadius(10)
                                .border(Color.black)
                                
                            
                        }.padding(12)
                            .background(.white)
                        
                    }
                    //Update live map with information
                    if !adminView{
                        Group{
                            
                            TextField("Tittle", text: $liveName)
                                .autocapitalization(.none)
                            TextField("ID (Choose 1-10)", text: $liveID)
                                .autocapitalization(.none)
                            TextField("Start location", text: $startLocation)
                                .autocapitalization(.none)
                            
                            TextField("Start time", text: $startTime)
                                .autocapitalization(.none)
                            TextField("End Location", text: $endLocation)
                                .autocapitalization(.none)
                            TextField("End Time", text: $endTime)
                                .autocapitalization(.none)
                            Text("Description of the protest/ riot below")
                            TextEditor(text: $liveDetails)
                                .autocapitalization(.none)
                                .frame( height: 250)
                                .cornerRadius(10)
                                .border(Color.black)
                           }.padding(12)
                            .background(.white)
                        
                        Group{
                            Text("Latitude")
                            TextField("latitude", value: $liveLatitude, format: .number)
                            Text("Longitude")
                            TextField("longitude", value: $liveLongitude, format: .number )
                                
                            
                            
                        }.padding(12)
                            .background(.white)
                            
                        
                           
                            
                       
                            
                    }
                    
                    
                    
                    
                    Button {
                        updateEvent()
                            
                    } label: {
                        HStack {
                            Spacer()
                            Text(adminView ? "Update Next Event" : "Update Map")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system( size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    
                    }
                    
                    
                   
                    
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                }.padding()
                    
                    
            
           
            }
            .navigationTitle(adminView ? "Next Event" : "Map Update")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
    
    
    
    
    
    //Toggle between update map and update next event
    private func updateEvent() {
        if adminView{
            self.EditNextEvent()
        }else {
           updateMap()
            
        }
        
    }
    //Store image that will be uploaded to firebase storage
    private func storeProtestInformation(imageProfileUrl: URL) {
        
        let adminData = ["ID": self.ID, "details": self.details, "image": imageProfileUrl.absoluteString, "name" : self.name]
        FirebaseManager.shared.firestore.collection("Events")
            .document(self.ID).setData(adminData) { err in
                if let err = err {
                    print(err)
                    self.errorMessage = "\(err)"
                    return
                }

                print("Success")
            }
    }
    
    // Store all the information into firestore including image URL
    private func EditNextEvent() {
    //    let filename = UUID().uuidString
        //Current user UID
       
        let ref = FirebaseManager.shared.storage.reference(withPath: self.name)
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
                self.storeProtestInformation(imageProfileUrl: url)
            }
        }
        
    }
    
    // Update Map information in firestore
    private func updateMap() {
        
     
    
       FirebaseManager.shared.firestore.collection("ProtestsLive")
            .document(self.liveID).setData(["id": self.liveID,"details" : self.liveDetails, "name": self.liveName, "latitude": self.liveLatitude, "longitude" : self.liveLongitude, "startLocation": self.startLocation, "startTime": self.startTime, "endLocation": self.endLocation, "endTime": self.endTime] ) { err in
                if let err = err {
                  print(err)
                   self.errorMessage = "\(err)"
                   return
               }

                self.errorMessage = "Successfully updated map"
                
                self.liveDetails = ""
                self.liveName = ""
                self.liveLatitude = 0
                self.liveLongitude = 0
                self.liveID = ""
          }
        
       
   }
    
}






struct AdminPage_Previews: PreviewProvider {
    static var previews: some View {
        AdminPage(liveLatitude: 0.0, liveLongitude: 0)
    }
}
