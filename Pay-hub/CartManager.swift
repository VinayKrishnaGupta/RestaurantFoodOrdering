//
//  CartManager.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 27/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class CartManager: NSObject {

    var strSample = NSString()
    var MyCartItems = NSArray()
    
    
    static let sharedInstance:CartManager = {
        let instance = CartManager ()
        return instance
    } ()
    
    // MARK: Init
    override init() {
        print("My Class Initialized")
        // initialized with variable or property
        strSample = "My String"
        MyCartItems = []
    }
    
    
    
    
}


