//
//  RestaurantManager.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import Foundation
import RealmSwift


class RestaurantManager {
    
    static let apiMethod = "restaurant_get_info"
    
    static let realm = try! Realm()
    
    static func find(by id: Int, completion: @escaping (Restaurant?, Error?) -> Void) {
        findRemotely(by: id) { (restaurant, error) in
            if let error = error as? ApiError{
                if error == ApiError.serverError {
                    if let restaurant = findLocaly(by: id) {
                        completion(restaurant, nil)
                    }else{
                        print("not found localy)")
                        //completion(nil, )
                    }
                }else{
                    completion(nil, error)
                }
            }else{
                completion(restaurant, nil)
            }
        }
    }
    
    static func findRemotely(by id: Int, completion: @escaping (Restaurant?, Error?) -> Void) {
        let parameters = [
            "method": apiMethod,
            "id_restaurant": id
            ] as [String: Any]
        ApiManager.shared.request(parameters: parameters) { (json, error) in
            if error != nil{
                completion(nil, error)
            }else if json != nil{
                let restaurant = Restaurant(JSON: json!)
                if restaurant != nil{
                    persist(restaurant!)
                }
                completion(restaurant, nil)
            }
        }
    }
    
    static func findLocaly(by id: Int) -> Restaurant? {
        return realm.object(ofType: Restaurant.self, forPrimaryKey: id)        
    }
    
    private static func persist(_ restaurant: Restaurant){
        try! realm.write {
            realm.add(restaurant, update: true)
        }
    }
    
}
