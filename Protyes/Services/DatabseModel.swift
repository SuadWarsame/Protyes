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

// Model for the user profile information

struct MainUser {
    let uid, email, profileImageUrl: String
}


class UserInfoModel: ObservableObject{
    
    
    @Published var email = ""
    @Published var errorMessage = ""
    @Published var profileImage = ""
    
    init() {
        fetchCurrentUser()
    }
    private func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{
            self.errorMessage = "No UID found"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error{
                print("failed to fetch current user", error)
                return
            }
            guard let data = snapshot?.data() else{
                return
            }
            
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            let chatUser = MainUser(uid: uid, email: email, profileImageUrl: profileImageUrl)
            
            
            self.email = chatUser.email
            self.profileImage = chatUser.profileImageUrl
        }
        
        
    }
}


// Database model for live protest infromation that will be plotted on the map
struct ProtestView: Identifiable {
 var id: String
 var name: String
 var details : String
    var startLocation: String
    var startTime : String
    var endLocation : String
    var endTime : String
 var cooridinate : CLLocationCoordinate2D
 var finalCoordinate: CLLocationCoordinate2D
}

//Information from firestore used for the live map
class ProtestViewModel: ObservableObject {
  @Published var cities = [ProtestView]()
    
    private var db = FirebaseManager.shared.firestore
    @Published var errorMessage = ""

  func fetchCities() {
      db.collection("ProtestsLive").addSnapshotListener{ (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
              print("no documents")
              return
          }
          self.cities = documents.map { (queryDocumentSnapshot) -> ProtestView in
              let data = queryDocumentSnapshot.data()
              
              
              let name = data["name"] as? String ?? ""
              let details = data["details"] as? String ?? ""
              let startLocation = data["startLocation"] as? String ?? ""
              let startTime = data["startTime"] as? String ?? ""
              let endLocation = data["endLocation"] as? String ?? ""
              let endTime = data["endTime"] as? String ?? ""
              let id = data["id"] as? String ?? ""
              let latitude = data["latitude"] as? Double ?? 0
             // let g = latitude
              let longitude = data["longitude"] as? Double ?? 0
              let finalLatitude = data["Finallatitude"] as? Double ?? 0
              let finalLongitude = data["Finallongitude"] as? Double ?? 0
              
              let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
              let finalLocation = CLLocationCoordinate2D(latitude: finalLatitude, longitude: finalLongitude)
            
              return ProtestView(id: id, name: name,details: details, startLocation: startLocation,startTime: startTime, endLocation: endLocation, endTime: endTime, cooridinate: location,finalCoordinate: finalLocation)
              
              
              
              
          }
      
          
      }


    
  }
}

//Submited info data

struct ProtestSubmittedView: Identifiable {
 var id: String
    
 var location: String
 var dateTime: String
 var description : String
}


class ProtestSubmittedViewModel: ObservableObject {
  @Published var info = [ProtestSubmittedView]()
    
    private var db = FirebaseManager.shared.firestore
    @Published var errorMessage = ""

  func fetchInfo() {
      db.collection("ProtestSubmission").addSnapshotListener{ (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
              print("no documents")
              return
          }
          self.info = documents.map { (queryDocumentSnapshot) -> ProtestSubmittedView in
              let data = queryDocumentSnapshot.data()
              
              
              let location = data["location"] as? String ?? ""
              let dateTime = data["dateTime"] as? String ?? ""
              let description = data["description"] as? String ?? ""
              
             
            
              return ProtestSubmittedView(id: location, location: location, dateTime: dateTime, description: description)
              
              
              
              
              
          }
      
          
      }


    
  }
}



//Next event data from firebase

struct NextEventInfo: Identifiable {
 var id: String
    
 var details: String
 var image: String
 var name : String
}

class NextEventViewModel: ObservableObject {
  @Published var info = [NextEventInfo]()
    
    private var db = FirebaseManager.shared.firestore
    @Published var errorMessage = ""

  func fetchInfo() {
      db.collection("Events").addSnapshotListener{ (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
              print("no documents")
              return
          }
          self.info = documents.map { (queryDocumentSnapshot) -> NextEventInfo in
              let data = queryDocumentSnapshot.data()
              
              
              let ID = data["ID"] as? String ?? ""
              let details = data["details"] as? String ?? ""
              let image = data["image"] as? String ?? ""
              let name = data["name"] as? String ?? ""
              
             
            
              return NextEventInfo(id: ID, details: details, image: image, name: name)
              
              
              
          }
      
          
      }


    
  }
}

//Next event data from firebase


struct RecentEventInfo {
    let ID, details, image, name1: String
}

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

class RecentProtestInfo23: ObservableObject{
    
    
    @Published var details = ""
    @Published var image1 = ""
    @Published var heading = ""
    
 
    
    
        
    init() {
        recentPosts()
    }
    private func recentPosts() {
        
        FirebaseManager.shared.firestore.collection("Events").document("Event1").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                let data = document.data()
                let ID = data?["ID"] as? String ?? ""
                let details = data?["details"] as? String ?? ""
                let image = data?["image"] as? String ?? ""
                let name1 = data?["name"] as? String ?? ""
                let recentPostsInfo = RecentEventInfo(ID: ID, details: details, image: image, name1: name1)
                
                
                self.heading = recentPostsInfo.name1
                self.details = recentPostsInfo.details
                self.image1 = recentPostsInfo.image
                
            } else {
                print("Document does not exist")
            }
        }
       


        
        
    }
}





class RecentProtestInfo2: ObservableObject{
    
    
    @Published var details = ""
    @Published var image1 = ""
    @Published var heading = ""
    
 
    
    
        
    init() {
        recentPosts()
    }
    private func recentPosts() {
        
        
        FirebaseManager.shared.firestore.collection("Events").document("Event2").getDocument { snapshot, error in
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
