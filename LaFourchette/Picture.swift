//
//  Picture.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Picture: Object, Mappable{
    dynamic var url: String?
    dynamic var label: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url <- map["612x344"]
        label <- map["label"]
    }
}
