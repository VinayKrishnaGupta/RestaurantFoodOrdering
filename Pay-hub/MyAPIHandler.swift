//
//  MyAPIHandler.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 21/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import Foundation
import Alamofire

public class GetDatafromAPI
{
    
    
public func getDataofGETcall(URLString: String?) -> NSDictionary?
    {
        var dict : NSDictionary = [:]
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        Alamofire.request(
            URL(string: URLString!)!,
            method: .get,
            parameters: nil,
            headers: HEADERS
            )
            .validate()
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value
                {
                    dict = json as! NSDictionary
                    
                }
        }
    return dict
    }
        
}
