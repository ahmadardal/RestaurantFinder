//
//  Review.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import Foundation

struct Review: Codable, Identifiable {
    var id: String
    var name: String
    var message: String
}
