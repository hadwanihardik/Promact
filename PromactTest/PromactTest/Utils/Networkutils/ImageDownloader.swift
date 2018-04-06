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
    var imagesBeingDownloaded: [String] = [String]()
    var noImages: [String] = [String]()

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
                print("Image loaded from cache for path : \(imgPath)")
                completionHandler(image)
            }
        }
        else
        {
            if(!imagesBeingDownloaded.contains(imgPath) && !noImages.contains(imgPath))
            {
                let url: URL! = URL(string: imgPath)
                print("Start Image downloading for path : \(imgPath)");
                imagesBeingDownloaded.append(imgPath)
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                    if let data = try? Data(contentsOf: url) {
                        print("Image downloaded for path : \(imgPath)");
                        self.imagesBeingDownloaded.remove(at: self.imagesBeingDownloaded.index(of: imgPath)!)

                        let img: UIImage! = UIImage(data: data)
                        self.cache.setObject(img, forKey: imgPath as NSString)
                        DispatchQueue.main.async {
                            completionHandler(img)
                        }
                    }
                    else{
                        self.imagesBeingDownloaded.remove(at: self.imagesBeingDownloaded.index(of: imgPath)!)
                        self.noImages.append(imgPath)
                        DispatchQueue.main.async {
                            // You need placeholder image in your assets so that if image download fail this will be displayed
                            let placeholder = #imageLiteral(resourceName: "placeholderThumb")
                            completionHandler(placeholder)
                        }
                    }
                })
                task.resume()
            }
            else
            {
                let placeholder = #imageLiteral(resourceName: "placeholderThumb")
                completionHandler(placeholder)
            }
        }
    }
}
