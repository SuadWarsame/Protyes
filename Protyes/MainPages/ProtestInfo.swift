//
//  ProtestInfo.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProtestInfo: View {
    @ObservedObject private var postInfor = RecentProtestInfo()
    
    
    @ObservedObject private var viewModel = ProtestSubmittedViewModel()
    
    var body: some View {
        
    
        
        NavigationView{
            
            List(viewModel.info) { info in
                VStack(alignment: .leading) {
                    Text(info.location)
                        .font(.headline)
                    Text("\(info.dateTime)")
                        .font(.subheadline)
                    Text("\(info.description)")
                       .font(.subheadline)
                  
                    
                   
                    
                    
                }
                
            }
            .navigationTitle("Submitted protest")
            .onAppear(){
                self.viewModel.fetchInfo()
            }
            
        }
    }
}

struct ProtestInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProtestInfo()
    }
}
