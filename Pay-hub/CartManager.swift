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
    var MyCartItems = Array<Any>()
    var productsarray : NSMutableArray = []
    var NumberofIteminCart : Int = 0
    
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
    
//    func getCartItems() -> NSArray {
//        
//        
//        
//        return MyCartItems as NSArray
//    }
    
    func addproduct(product : NSDictionary) {
        productsarray.add(product)
        print("Product Array from singalton class is \(productsarray)")
        
        
    }
    
    func getcartitemarray() -> NSArray {
        return productsarray
    }
    
    func numberofItemsinCartManager(Change:Int) -> Int {
    NumberofIteminCart = NumberofIteminCart + Change
        
        return NumberofIteminCart
    }
    
   
    
    
    
    
}


