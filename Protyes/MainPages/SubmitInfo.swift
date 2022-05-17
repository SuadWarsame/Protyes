//
//  SubmitInfo.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI

struct SubmitInfo: View {
    @State var location = ""
    @State var dateTime = ""
    @State var description = ""
    @State var errorMessage = ""
    
    
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    Group{
                        TextField("Location including postcode and street name", text: $location)
                            .autocapitalization(.none)
                            
                        TextField("Date and time", text: $dateTime)
                            .autocapitalization(.none)
                        Text("Description")
                            
                        TextEditor(text: $description)
                            .autocapitalization(.none)
                            .frame( height: 250)
                            .cornerRadius(10)
                            .border(Color.black)
                        
                        Button(action: {
                            submit()
                            
                        }, label: {
                            Text("Save".uppercased())
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                        
                        Text(self.errorMessage)
                            .foregroundColor(.red)
                            
                            
                            
                    }.padding(12)
                        .background(.white)
                }
                .navigationTitle("Tell us about a protest")
                .font(.headline)
            }
        }
        
        
    }
    
    
    private func submit() {
        
        let userData = ["location": self.location, "dateTime": self.dateTime, "description": self.description]
    
       FirebaseManager.shared.firestore.collection("ProtestSubmission")
            .document(self.location).setData(userData) { err in
                if let err = err {
                  print(err)
                   self.errorMessage = "\(err)"
                   return
               }

             print("Success")
          }
        
       
   }
}

struct SubmitInfo_Previews: PreviewProvider {
    static var previews: some View {
        SubmitInfo()
    }
}
