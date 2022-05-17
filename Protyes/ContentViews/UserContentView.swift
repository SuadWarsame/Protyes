//
//  UserContentView.swift
//  Protyes
//
//  Created by Suad Warsame Nour Haagar  on 18/04/22
//

import SwiftUI

struct UserContentView: View {
    var body: some View {
        TabView{
            
            HomePageView()
                .tabItem(){
                    Image(systemName: "mappin.and.ellipse")
                        
                    Text("HomePage")
                    
                }.background(.white)
            NextEvent()
                .tabItem() {
                    Image(systemName: "note.text.badge.plus")
                        
                    Text("Next Event")
                }
            
            SubmitInfo()
                .tabItem() {
                    Image(systemName: "plus")
                    Text("Protest")
                }
            
            ProfileView()
                .tabItem() {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
        
                
                }
                .background(.white)
            
           
        }
           
    }
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView()
    }
}
