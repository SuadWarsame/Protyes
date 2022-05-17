//
//  FirbaseManager.swift
//  Protyes
//
//  Created by Suad Warsame on 25/04/2022.
//

import Foundation
import Firebase

//Firebase manager will be used to manage firestore firebase strogage and firebase authetication

class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
       
        super.init()
    }
}
