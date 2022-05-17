//
//  AdminContentView.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI

struct AdminContentView: View {
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
            AdminPage(liveLatitude: 0.0, liveLongitude: 0.0)
                .tabItem() {
                    Image(systemName: "a.circle.fill")
                    Text("Admin")
                }
            ProtestInfo()
                .tabItem() {
                    Image(systemName: "info.circle.fill")
                    Text("ProtestInfo")
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

struct AdminContentView_Previews: PreviewProvider {
    static var previews: some View {
        AdminContentView()
    }
}
