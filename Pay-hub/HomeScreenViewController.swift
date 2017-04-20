//
//  HomeScreenViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 13/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SideMenuController
import Alamofire

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var menuicon: UIImageView!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "homescreenbg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        self.navigationItem.title = "PayHub"
        
        let Menutapguesture = UITapGestureRecognizer(target: self, action: #selector(menubuttonpressed))
        menuicon.addGestureRecognizer(Menutapguesture)
        menuicon.isUserInteractionEnabled = true;
        
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
   //     Alamofire.request("https://pay-hub.in/payhub%20api/v1/home_api.php",method(for: <#T##Selector!#>) headers: headers)
        Alamofire.request(
            URL(string: "https://pay-hub.in/payhub%20api/v1/home_api.php")!,
            method: .get,
            parameters: nil,
            headers: HEADERS
            )
            .validate()
            
            .responseJSON { response in
                debugPrint(response)
                
    
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print("Converted Dictionary is \(dict)")
                    let backgroundimage = dict.value(forKeyPath: "Response.data.bg_image")
                    print("Background Image URL is \(String(describing: backgroundimage))")
                    
                }

        // Do any additional setup after loading the view.
    
        }
    }
    
    func menubuttonpressed() {
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
        
    }
    

  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
