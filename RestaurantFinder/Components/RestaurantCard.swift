//
//  RestaurantCard.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import SwiftUI

struct RestaurantCard: View {
    
    var restaurant: Restaurant
    
    var isMini: Bool
    
    var body: some View {
            
        AsyncImage(url: URL(string: restaurant.image), content: {
                image in
            
                image.resizable().overlay(alignment: .bottomLeading, content: {
                    VStack {
                        Text(restaurant.title).bold().font(.title).foregroundColor(.white)
                    }.padding()
                })
                        
                
            }, placeholder: {
                Text("Loading...").foregroundColor(.white)
                
            }).frame(width: isMini ? 225 : 325, height: isMini ? 150 : 210).background(.black).cornerRadius(9)
    }
}

struct RestaurantCard_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCard(restaurant: Restaurant(id: "1", title: "Pizzeria Valla", openingHours: "Vardagar 10.00 - 21.00", image: "https://lh3.googleusercontent.com/p/AF1QipNL5LJEubSGhC9mVD_kIJuSpoEgTgQzW0Njm6_9=w600-k", description: "Hej vi är en god pizzeria", latitude: 18.02395798266904, longitude: 59.311150897492475, reviews: [Review(id: "1", name: "Ahmad", message: "Rekommenderas starkt!")]), isMini: false)
    }
}
