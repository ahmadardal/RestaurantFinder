//
//  RegisterView.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var email = ""
    @State var password = ""
    var body: some View {
        
        VStack(spacing: 30) {
            Image("restaurantLogo")
            
            Text("Register an account").bold().font(.title)
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $email).textFieldStyle(.roundedBorder)
                
                Text("Password")
                SecureField("", text: $password).textFieldStyle(.roundedBorder)
            }.padding().padding()
            
            Button("Register") {
                dbConnection.RegisterUser(email: email, password: password)
            }.buttonStyle(.borderedProminent)
            
            
        }.padding()
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
