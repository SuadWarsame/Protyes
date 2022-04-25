//
//  IntroView.swift
//  Protyes
//
//  Created by Suad Warsame on 13/04/2022.
//

import SwiftUI

// used to store variables of different type of data
struct IntroView: View {
    
  
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                
                VStack{
                    Text("Protyes")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.blue)
                        
                    Spacer()
                        .frame(height: 50)
                    
                    
                    
                   // controls a navigation presentation
                    NavigationLink(destination: LoginView()) {
                        Text("GET STARTED")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(30)
                    
                   
                    
                }
                    
                    Spacer()
                        .frame( height: 150)
                   
                    HStack{
                        Spacer()
                            .frame(width: 200)
                        NavigationLink(destination: AdminLogin()) {
                            Text("Admin")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 25)
                                .background(Color.red)
                                .cornerRadius(30)
                        
                       
                        
                    }
                    
                    
                }
                
                            
                    }
                    
            }
        }
        .navigationBarHidden(true)
        
        
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
