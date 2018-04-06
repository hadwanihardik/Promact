//
//  InstaModel.swift
//  PromactTest
//
//  Created by Hardik on 4/6/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import Foundation
import UIKit
public class InstaModel : NSObject{
    
    //Instafeed variables
    var format : String = ""
    var width : Int = 0
    var height : Int = 0
    var filename : String = ""
    var imageId : Int = 0
    var author : String = ""
    var authorUrl : String = ""
    var postUrl : String = ""

    init(dict: NSDictionary)
    {
        self.format = dict.value(forKey: "format") as! String
        self.width = dict.value(forKey: "width") as! Int
        self.height = dict.value(forKey: "height") as! Int
        self.filename = dict.value(forKey: "filename") as! String
        self.imageId = dict.value(forKey: "id") as! Int
        self.author = dict.value(forKey: "author") as! String
        self.authorUrl = dict.value(forKey: "author_url") as! String
        self.postUrl = dict.value(forKey: "post_url") as! String

    }
}

