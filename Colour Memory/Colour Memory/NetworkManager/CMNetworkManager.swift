//
//  CMNetworkManager.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 25/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMNetworkManager: NSObject {

    func savePlayerPoint(_ name:String, point:Int16) -> Void {
        
        
    }
    
    func getPlayerList() -> Void {
        
        
    }
    
    func sendAPIRequest(apiData:Dictionary<String,String>?,handler:(_ response:AnyObject)->Void) -> Void {

        var req = URLRequest(url: URL(fileURLWithPath: ""))
        req.allHTTPHeaderFields = [:]
        
        do {
            
            let data = try JSONSerialization.data(withJSONObject: apiData ?? [:], options: .prettyPrinted)
            
            req.httpBody = data
            req.httpMethod = "POST"
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: req, completionHandler: {(data, response, error) in
            
                
            })
            
        } catch _ as NSError{
            
            
        }
        
    }
    
    
    
}
