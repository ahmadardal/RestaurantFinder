//
//  LoginView.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack(spacing: 30) {
            Image("restaurantLogo")
            
            Text("Enter your credentials").bold().font(.title)
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $email).textFieldStyle(.roundedBorder)
                
                Text("Password")
                SecureField("", text: $password).textFieldStyle(.roundedBorder)
            }.padding().padding()
            
            Button("Login") {
                dbConnection.LoginUser(email: email, password: password)
            }.buttonStyle(.borderedProminent)
            
            NavigationLink(destination: RegisterView(), label: {
                Text("Register an account").foregroundColor(.black).bold()
            })
            
        }.padding().background(.red)
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
