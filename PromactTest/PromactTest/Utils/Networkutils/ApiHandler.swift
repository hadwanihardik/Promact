//
//  ApiHandler.swift
//  PromactTest
//
//  Created by Hardik on 4/6/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import Foundation
class ApiHandler: NSObject {
    
    static func GetAPI(apiName :String,postCompleted: @escaping ( _ status : Bool,  _ msg:NSMutableArray) -> ())
    {
        let myUrl = URL(string: "\(Constants.BaseURL)\(apiName)");
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"// Compose a query string
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error!)")
                return
            }
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
                postCompleted(true, json)
            } catch {
                print(error)
            }
            
        }
        task.resume()
        
        
    }
    
    
}

