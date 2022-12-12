//
//  Restaurant.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import Foundation

struct Restaurant: Codable, Identifiable {
    
    var id: String
    var title: String
    var openingHours: String
    var image: String
    var description: String
    var latitude: Double
    var longitude: Double
    var reviews: [Review]
    
}
