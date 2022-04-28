//
//  DatabseModel.swift
//  Protyes
//
//  Created by Suad Warsame on 28/04/2022.
//
import Foundation
import SwiftUI
import FirebaseFirestore
import MapKit

class RecentProtestInfo: ObservableObject{
    
    
    @Published var details = ""
    @Published var image1 = ""
    @Published var heading = ""
    
 
    
    
        
    init() {
        recentPosts()
    }
    private func recentPosts() {
        
        
        FirebaseManager.shared.firestore.collection("Events").document("Event1").getDocument { snapshot, error in
            if let error = error{
                print("failed to fetch document", error)
                return
            }
            guard let data = snapshot?.data() else{
                return
            }
            
            
            let ID = data["ID"] as? String ?? ""
            let details = data["details"] as? String ?? ""
            let image = data["image"] as? String ?? ""
            let name1 = data["name"] as? String ?? ""
            let recentPostsInfo = RecentEventInfo(ID: ID, details: details, image: image, name1: name1)
            
            
            
            self.heading = recentPostsInfo.name1
            self.details = recentPostsInfo.details
            self.image1 = recentPostsInfo.image
            
            
        }
        
        
    }
}

struct City: Identifiable {
 var id: String
 var name: String
    var details : String
 var cooridinate : CLLocationCoordinate2D
}

//Information from firestore used for the live map
class ProtestViewModel: ObservableObject {
  @Published var cities = [City]()
  // SwiftUI that allows us to trigger a view redraw whenever changes occur
    private var db = FirebaseManager.shared.firestore
    @Published var errorMessage = ""

  func fetchCities() {
      db.collection("ProtestsLive").addSnapshotListener{ (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
              print("no documents")
              return
          }
          self.cities = documents.map { (queryDocumentSnapshot) -> City in
              let data = queryDocumentSnapshot.data()
              
              
              let name = data["name"] as? String ?? ""
              let details = data["details"] as? String ?? ""
              let id = data["id"] as? String ?? ""
              let latitude = data["latitude"] as? Double ?? 0
             // let g = latitude
              let longitude = data["longitude"] as? Double ?? 0
           //   let geoPoint = data["location"] as? GeoPoint ?? 0
              let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
              return City(id: id, name: name,details: details, cooridinate: location)
              
              
              
          }
      
          
      }


    
  }
}
