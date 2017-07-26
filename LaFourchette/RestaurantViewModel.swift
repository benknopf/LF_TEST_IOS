//
//  RestaurantViewModel.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import Foundation
import UIKit

class RestaurantViewModel {
    
    var restaurant: Restaurant
    
    init(restaurant: Restaurant){
        self.restaurant = restaurant
    }
    
    var name: String {
        if let name = restaurant.name{
            return name
        }
        return ""
    }
    
    var completeAddress: String {
        if let address = restaurant.address, let city = restaurant.city, let zipCode = restaurant.zipCode{
            return "\(address) \(zipCode) \(city)"
        }
        return ""
    }

    var rate: String {
        return NumberFormatter.localizedString(from: NSNumber(floatLiteral: restaurant.rate), number: .decimal)
    }
    
    var rateCount: String {
        return "\(restaurant.rateCount) avis LaFourchette"
    }
    
    
    var cardPrice: String {
        return "\(restaurant.cardPrice)€"
    }
    
    
    var latitude: Double {
        return restaurant.latitude
    }
    
    var longitude: Double {
        return restaurant.longitude
    }
    
    var mainPictureUrl: String? {
        /*if let mainPictureUrl = restaurant.mainPictureUrl?.url{
            return mainPictureUrl
        }
        return nil*/
        return restaurant.pictures.first?.url
    }
    
    var pictureCount: Int {
        return restaurant.pictures.count
    }
}
