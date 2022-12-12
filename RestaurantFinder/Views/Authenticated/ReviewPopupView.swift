//
//  ReviewPopupView.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-04.
//

import SwiftUI

struct ReviewPopupView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var name = ""
    @State var message = ""
    
    var restaurantId: String
    
    @Binding var showPopup: Bool
    
    
    func submitReview() {
        if name == "" || message == "" {
            print("No empty fields allowed!")
            return
        }
        
        let newReview = Review(id: UUID().uuidString, name: name, message: message)
        
        dbConnection.addReviewToRestaurant(restaurantId: restaurantId, review: newReview)
        
        showPopup.toggle()
    }
    
    
    var body: some View {
        
        ZStack() {
            
            Color(.systemGray5)
            
            
            VStack {
                Spacer()
                Text("Write a review").bold().font(.title)
                
                VStack(alignment: .leading) {
                    Text("Name")
                    TextField("", text: $name)
                    
                    Text("Message")
                    TextField("", text: $message)
                }.padding().textFieldStyle(.roundedBorder)
                
                Button(action: submitReview, label: {
                    Text("Submit").padding().background(.black).foregroundColor(.white).cornerRadius(9)
                })
                
                Button(action: {
                    showPopup.toggle()
                }, label: {
                    Text("Cancel").foregroundColor(.black).padding(.vertical)
                })
                
 
                
                
            }
            
            
        }.frame(width: 300, height: 360).cornerRadius(9)
        
        
    }
}

struct ReviewPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPopupView(restaurantId: "hej", showPopup: .constant(true))
    }
}
