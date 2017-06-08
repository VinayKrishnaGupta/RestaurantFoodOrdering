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
import SVProgressHUD


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
   
    var selectedShortcut :NSDictionary = [:]
    
    
    
    
    
    
    
    
    var menuitems : NSArray = []

   
    override func awakeFromNib() {
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "Merchantname" : "admin",
            "Merchantid" : "3",
            "Connection" : "close"
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
                else {
                    self.awakeFromNib()
                    
                }
                
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        print("Screen Sizes are \(screenWidth) and \(screenHeight)")
        
        
        
        SVProgressHUD.show()
      //  SVProgressHUD.show(withStatus: "Loading Payhub")
     //   SVProgressHUD.setRingRadius(40)
        let VisitReference : String = "N"
        UserDefaults.standard.set(VisitReference, forKey: "VisitReferenceNumber")
        
        let logo = UIBarButtonItem(image: UIImage (named: "payhubLogo"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        
        self.navigationItem.leftBarButtonItem = logo
       
        
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "homescreenbg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
       
        
        let Menutapguesture = UITapGestureRecognizer(target: self, action: #selector(menubuttonpressed))
        menuicon.addGestureRecognizer(Menutapguesture)
        menuicon.isUserInteractionEnabled = true
        
        let itemdetailTapGuesture1 = UITapGestureRecognizer(target: self, action: #selector(itemIconsClicked1))
        let itemdetailTapGuesture2 = UITapGestureRecognizer(target: self, action: #selector(itemIconsClicked2))
        let itemdetailTapGuesture3 = UITapGestureRecognizer(target: self, action: #selector(itemIconsClicked3))
        let itemdetailTapGuesture4 = UITapGestureRecognizer(target: self, action: #selector(itemIconsClicked4))
        let itemdetailTapGuesture5 = UITapGestureRecognizer(target: self, action: #selector(itemIconsClicked5))
        let itemdetailTapGuesture6 = UITapGestureRecognizer(target: self, action: #selector(itemIconsClicked6))
        
        image1.addGestureRecognizer(itemdetailTapGuesture1)
        image2.addGestureRecognizer(itemdetailTapGuesture2)
        image3.addGestureRecognizer(itemdetailTapGuesture3)
        image4.addGestureRecognizer(itemdetailTapGuesture4)
        image5.addGestureRecognizer(itemdetailTapGuesture5)
        image6.addGestureRecognizer(itemdetailTapGuesture6)
       
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        
        
        
        
        
        
      
    }
    
    
    
    
    func menubuttonpressed() {
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
        
    }
    
    func itemIconsClicked1(){
        selectedShortcut = menuitems[0] as! NSDictionary
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
    }
    func itemIconsClicked2(){
        selectedShortcut = menuitems[1] as! NSDictionary
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
        
    }
    func itemIconsClicked3(){
        selectedShortcut = menuitems[2] as! NSDictionary
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
    }
    func itemIconsClicked4(){
        selectedShortcut = menuitems[3] as! NSDictionary
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
    }
    func itemIconsClicked5(){
        selectedShortcut = menuitems[4] as! NSDictionary
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
    }
    func itemIconsClicked6(){
        selectedShortcut = menuitems[5] as! NSDictionary
        self.performSegue(withIdentifier: "Menugroups", sender: self)
        
    }
    
    
    
    func updatelabelsandimage() {
        
        
        
//        let imageaddress  = dict?.value(forKey: "item_image") as! String
//        let imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
//        cell.itemImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        
        var dict1 : NSDictionary = menuitems[0] as! NSDictionary
        var text1 : String = dict1.value(forKey: "menu_short_name") as! String
        var imageaddress   = dict1.value(forKey: "menu_image") as! String
        var imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image1.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label1.text = text1
        
        dict1 = menuitems[1] as! NSDictionary
        text1 = dict1.value(forKey: "menu_short_name") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image2.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label2.text = text1
        
        dict1 = menuitems[2] as! NSDictionary
        text1 = dict1.value(forKey: "menu_short_name") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image3.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label3.text = text1
        
        dict1 = menuitems[3] as! NSDictionary
        text1 = dict1.value(forKey: "menu_short_name") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image4.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label4.text = text1
        
        dict1 = menuitems[4] as! NSDictionary
        text1 = dict1.value(forKey: "menu_short_name") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image5.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label5.text = text1
        
        dict1 = menuitems[5] as! NSDictionary
        text1 = dict1.value(forKey: "menu_short_name") as! String
        imageaddress  = dict1.value(forKey: "menu_image") as! String
        imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        image6.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        label6.text = text1
        
        
        
self.viewDidLoad()
        SVProgressHUD.dismiss(withDelay: 1)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Menugroups" {
            
            if selectedShortcut.count != 0 {
                let nextVC = segue.destination as! ItemsTabBarViewController
                let destinationViewController = nextVC.viewControllers?[0] as! UINavigationController
                let MenuVC = destinationViewController.topViewController as! MenuGroupsVC
                
                
                MenuVC.SelectedShortcutfromHome = selectedShortcut
                

            }
            
            
        }

    }
    override func viewDidDisappear(_ animated: Bool) {
        self.selectedShortcut = [:]
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
