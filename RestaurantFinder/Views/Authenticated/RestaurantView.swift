//
//  RestaurantView.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-04.
//

import SwiftUI

struct RestaurantView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    var restaurant: Restaurant
    
    @State var showPopup = false
    
    var body: some View {
        
        ZStack() {
            
            GeometryReader { geometry in
                
                Color(.systemGray6).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: restaurant.image), content: {
                            image in
                            
                            image.resizable().overlay(alignment: .bottomLeading, content: {
                                VStack {
                                    Text(restaurant.title).bold().font(.title).foregroundColor(.white)
                                    
                                    
                                }.padding()
                            })
                            
                        }, placeholder: {
                            Text("Loading...").foregroundColor(.white)
                            
                        }).frame(height: 360)
                        
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text(restaurant.openingHours).font(.system(.subheadline, design: .monospaced, weight: .thin))
                            
                            Text(restaurant.title).bold().font(.title)
                            
                            Text(restaurant.description)
                            
                            HStack {
                                Text("Reviews").bold().font(.title)
                                Spacer()
                                Button(action: {
                                    showPopup.toggle()
                                }, label: {
                                    Text("Add review").padding().background(.black).foregroundColor(.white).cornerRadius(9)
                                })
                            }
                                
                                ForEach(restaurant.reviews) { review in
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(review.name).bold()
                                        Text(review.message).font(.caption).fontDesign(.monospaced)
                                    }.padding(.vertical)
                                }
                            
                            
                            
                        }.padding()
                        
                    }
                }.ignoresSafeArea().blur(radius: showPopup ? 2 : 0)
            }
            

            if showPopup {
                ReviewPopupView(restaurantId: restaurant.id, showPopup: $showPopup)
            }
            
        
        }

    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView(restaurant: Restaurant(id: "1", title: "Pizzeria Valla", openingHours: "Vardagar 10.00 - 21.00", image: "https://lh3.googleusercontent.com/p/AF1QipNL5LJEubSGhC9mVD_kIJuSpoEgTgQzW0Njm6_9=w600-k", description: "Hej vi är en god pizzeria", latitude: 18.02395798266904, longitude: 59.311150897492475, reviews: [Review(id: "1", name: "Ahmad", message: "Rekommenderas starkt!")]))
    }
}
