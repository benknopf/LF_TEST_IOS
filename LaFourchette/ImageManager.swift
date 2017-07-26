//
//  ImageManager.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageManager{
    
    static var imageCache = AutoPurgingImageCache()
    
    class func load(url:String, completion: @escaping (UIImage?) -> Void) -> DataRequest?{
        if let image = self.cachedImage(for: url){
            completion(image)
        }else{
            //.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            if let url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
                return Alamofire.request(url).responseImage { response in
                    if let image = response.result.value {
                        self.cache(image, for: url)
                        completion(image)
                    }else if response.error != nil{
                        completion(nil)
                    }
                }
            }else{
                completion(nil)
            }
        }
        return nil
    }
    
    class func cache(_ image: UIImage, for url: String) {
        self.imageCache.add(image, withIdentifier: url)
    }
    
    class func cachedImage(for url: String) -> UIImage? {
        return self.imageCache.image(withIdentifier: url)
    }
    
}
