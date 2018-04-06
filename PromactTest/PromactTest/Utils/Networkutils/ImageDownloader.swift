//
//  ImageDownloader.swift
//  PromactTest
//
//  Created by Hardik on 4/6/18.
//  Copyright © 2018 Hardik. All rights reserved.
//
typealias ImageDownloaded = ((UIImage) -> ())

import Foundation
import UIKit
class ImageDownloader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func downloadImageForPath(imgPath: String, completionHandler: @escaping ImageDownloaded) {
        if let image = self.cache.object(forKey: imgPath as NSString) {
            DispatchQueue.main.async {
                //If cached image available than return that image.
                completionHandler(image)
            }
        } else {
            let url: URL! = URL(string: imgPath)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imgPath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        // You need placeholder image in your assets so that if image download fail this will be displayed
                        let placeholder = #imageLiteral(resourceName: "placeholderThumb")
                        completionHandler(placeholder)
                    }
                }
            })
            task.resume()
        }
    }
}
