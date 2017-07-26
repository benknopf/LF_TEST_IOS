//
//  Restaurant.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Restaurant: Object, Mappable{
    
    dynamic var id = 0
    dynamic var name: String?
    dynamic var address: String?
    dynamic var city: String?
    dynamic var zipCode: String?
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0
    dynamic var rate: Double = 0
    dynamic var rateCount = 0
    dynamic var cardPrice = 0
    dynamic var mainPictureUrl: Picture?
    var pictures = List<Picture>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        city <- map["city"]
        zipCode <- map["zipcode"]
        latitude <- map["gps_lat"]
        longitude <- map["gps_long"]
        rate <- map["avg_rate"]
        rateCount <- map["rate_count"]
        cardPrice <- map["card_price"]
        mainPictureUrl <- map["pics_main"]
        pictures <- (map["pics_diaporama"], ListTransform<Picture>())
    }
    
}
