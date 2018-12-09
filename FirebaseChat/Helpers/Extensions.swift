//
//  Extensions.swift
//  FirebaseChat
//
//  Created by Bernard on 8/12/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCache(urlString: String) {
        //do away with the image flashing
        self.image = nil
        //check imageCache first
        if let cacheImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cacheImage
            return
        }
        
        //** URL instead of NSURL
        let url = URL(string: urlString)
        //** URL shared datTask instead of NSURLSession sharedSession dataTaskWithURL
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!)
            }
            else {
                
                DispatchQueue.main.async(execute: {
                    
                    if let downloadImage = UIImage(data: data!) {
                    
                        imageCache.setObject(downloadImage, forKey: urlString as NSString)
                        //   cell.imageView?.image = UIImage(data: data!)
                        self.image = downloadImage
                    }
                })
            }
        }).resume()
    }
}
