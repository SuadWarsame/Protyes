//
//  NextEvent.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI
import SDWebImageSwiftUI





struct NextEvent: View {
    @ObservedObject private var postInfor = RecentProtestInfo23()
    
    @ObservedObject private var postInfor2 = RecentProtestInfo2()
    
    
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                        Text("Upcoming protests")
                            .font(.title.bold())
                        Spacer()
                    }
                    LazyVStack{
                        VStack(alignment: .leading) {
                        
                            WebImage(url: URL(string: postInfor.image1 ))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .frame(maxWidth: UIScreen.main.bounds.width - 80)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            VStack(spacing: 6) {
                                HStack {
                                    Text(postInfor.heading)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(Font.title2.bold())
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                HStack {
                                    Text(postInfor.details)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(10)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }
                            .frame(height: 110)
                        }
                        .padding(15)
                        .background(Color.white)
                        .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: postInfor2.image1 ))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .frame(maxWidth: UIScreen.main.bounds.width - 80)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            VStack(spacing: 6) {
                                HStack {
                                    Text(postInfor2.heading)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(Font.title2.bold())
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                HStack {
                                    Text(postInfor2.details)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(10)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }
                            .frame(height: 110)
                        }
                        .padding(15)
                        .background(Color.white)
                        .frame(maxWidth: UIScreen.main.bounds.width - 50, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 30)
            }
            .navigationBarTitle("Protests")
            .onAppear(){
                
            }
            
        }
    }
    
}

struct ViewA_Previews: PreviewProvider {
    static var previews: some View {
        NextEvent()
    }
}
