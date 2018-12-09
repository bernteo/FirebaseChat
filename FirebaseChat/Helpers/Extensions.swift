//
//  Extensions.swift
//  FirebaseChat
//
//  Created by Bernard on 9/12/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageCache(urlString: String) {
        
        self.image = nil
        
        if let cacheImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cacheImage
            return
        }
        
        if let downloadUrl = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: downloadUrl) {
                (data, response, error) in
                if error != nil {
                    print(error!)
                }
                else {
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let downloadImage = UIImage(data: data!) {
                            imageCache.setObject(downloadImage, forKey: urlString as NSString)
                            self.image = downloadImage
                        }
                    })
                    
                }
                }.resume()
        }
    }
}
