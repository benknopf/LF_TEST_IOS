//
//  File.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 26/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import UIKit

struct Util {
    
    static func startActivity(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    static func stopActivity(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
