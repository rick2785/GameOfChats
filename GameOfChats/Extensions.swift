//
//  Extensions.swift
//  GameOfChats
//
//  Created by Rickey Hrabowskie on 3/8/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil 
        
        // Check cache for image first 
        if let cacheImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cacheImage
            return
        }
        
        // Otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url! , completionHandler: { (data, response, error) in
            
            // Download hit an error so lets return out
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
}
