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
import SDWebImage

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var menuicon: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var label7: UILabel!
    
    
    
    
    
    
    
    
    var menuitems : NSArray = []

   
    override func awakeFromNib() {
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
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
                    self.menuitems = dict.value(forKeyPath: "Response.data.menu") as! NSArray
                    print("Menu item list is \(String(describing: self.menuitems))")
                    print("Response Time of Home Page is \(response.timeline)")
                    self.updatelabelsandimage()
                    
                }
                
        }

    }
    
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
        
        
        
        
      
    }
    
    
    
    
    func menubuttonpressed() {
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
        
    }
    
    
    func updatelabelsandimage() {
        
        
        
//        let imageaddress  = dict?.value(forKey: "item_image") as! String
//        let imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
//        cell.itemImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        
        var dict1 : NSDictionary = menuitems[0] as! NSDictionary
        var text1 : String = dict1.value(forKey: "menu_title") as! String
        var imageaddress   = dict1.value(forKey: "menu_image") as! String
        var imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image1.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label1.text = text1
        
        dict1 = menuitems[1] as! NSDictionary
        text1 = dict1.value(forKey: "menu_title") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image2.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label2.text = text1
        
        dict1 = menuitems[2] as! NSDictionary
        text1 = dict1.value(forKey: "menu_title") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image3.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label3.text = text1
        
        dict1 = menuitems[3] as! NSDictionary
        text1 = dict1.value(forKey: "menu_title") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image4.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label4.text = text1
        
        dict1 = menuitems[4] as! NSDictionary
        text1 = dict1.value(forKey: "menu_title") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image5.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label5.text = text1
        
        dict1 = menuitems[5] as! NSDictionary
        text1 = dict1.value(forKey: "menu_title") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image6.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label6.text = text1
        
        dict1 = menuitems[6] as! NSDictionary
        text1 = dict1.value(forKey: "menu_title") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image7.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label7.text = text1
        
self.viewDidLoad() 
        
        
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
