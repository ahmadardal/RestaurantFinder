//
//  ContentView.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var body: some View {

        if dbConnection.userLoggedIn {
            NavigationStack {
                RestaurantsListView()
            }
        } else {
            NavigationStack {
                LoginView()
            }
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DatabaseConnection())
    }
}
