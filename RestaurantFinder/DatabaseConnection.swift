//
//  DatabaseConnection.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class DatabaseConnection: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var restaurantList = [Restaurant]()
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    
    private var restaurantListener: ListenerRegistration?
    
    private var restaurantCollection = "Restaurants"
    
    init() {
        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                
                self.userLoggedIn = true
                self.currentUser = user
                self.startListeningToRestaurants()
                // Om user inte är nil, så betyder det att vi nu har loggat in.
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.stopListeningToRestaurants()
                // Om user är nil, så betyder det att vi nu har loggat ut.
            }
        }
    }
    
    func addReviewToRestaurant(restaurantId: String, review: Review) {
        
        do {
            try db.collection(restaurantCollection).document(restaurantId).updateData(["reviews": FieldValue.arrayUnion([Firestore.Encoder().encode(review)])])
        } catch {
            print("Error adding review!")
        }
        
    }
    
    func stopListeningToRestaurants() {
        if let restaurantListener = restaurantListener {
            restaurantListener.remove()
        }
        
        restaurantListener = nil
    }
    
    
    func startListeningToRestaurants() {
        
        restaurantListener = db.collection(restaurantCollection).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print("Error fetching restaurants, \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error fetching restaurants. Unknown error!")
                return
            }
            
            self.restaurantList = []
            
            for document in snapshot.documents {
                
                let result = Result {
                    try document.data(as: Restaurant.self)
                }
                
                switch result {
                case .success(let restaurant):
                    self.restaurantList.append(restaurant)
                    break
                case .failure(let error):
                    print("Error fetching restaurant: \(error.localizedDescription)")
                    break
                }
                
            }
            
        }
        
    }
    
    
    func SignOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out!")
        }
    }
    
    func LoginUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print("Something went wrong, \(error.localizedDescription)")
                return
            }
            
        }
        
        
    }
    
    func RegisterUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print("Something went wrong, \(error)")
                return
            }
            
        }
        
        
    }
    
    
}
