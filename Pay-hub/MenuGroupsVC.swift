//
//  MenuGroupsVC.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD



class MenuGroupsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var CollectionViewMenuGroups: UICollectionView!
    var menugroups : NSArray = []
    var bannerImageURls : NSArray = []
    var SelectedMenuGroup : NSDictionary = [:]
    var SelectedShortcutfromHome : NSDictionary = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        SVProgressHUD.setRingRadius(25)
        CollectionViewMenuGroups.dataSource = self
        CollectionViewMenuGroups.delegate = self
        self.ContainerView.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        
      
    
//        let controller = storyboard?.instantiateViewController(withIdentifier: "BannerImages") as! PageViewMenuGroupsImagesVC
//        
//        addChildViewController(controller)
//        ContainerView.addSubview(controller.view)
//        didMove(toParentViewController: controller)
//        controller.oneURL = "Hello World"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if SelectedShortcutfromHome.count != 0 {
            ContainerView.isHidden = true
            CollectionViewMenuGroups.isHidden = true
            print("Selected shortcut is \(self.SelectedShortcutfromHome)")
            SelectedMenuGroup = SelectedShortcutfromHome
            self.performSegue(withIdentifier: "itemDetails", sender: self)
            SelectedShortcutfromHome = [:]
        }
        else {
        
        CollectionViewMenuGroups.isHidden = false
        
       // self.navigationController?.setNavigationBarHidden(true, animated: true)
        let SharedInstance1 = CartManager.sharedInstance
        let numberOfItem = SharedInstance1.numberofItemsinCartManager(Change: 0)
        
        tabBarController?.tabBar.items![1].badgeValue =  "\(numberOfItem)"
         tabBarController?.tabBar.items![1].badgeColor = UIColor.black
//        let script = GetDatafromAPI()
       
        
        
//        let dict1 = script.getDataofGETcall(URLString: "https://pay-hub.in/payhub%20api/v1/menu_group.php")
//        print("Dictionary is \(String(describing: dict1))")
//        self.menugroups = (dict1?.value(forKeyPath: "Response.data.menu") as? NSArray)!
//        self.CollectionViewMenuGroups.reloadData()
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        Alamofire.request(
            URL(string: "https://pay-hub.in/payhub%20api/v1/menu_group.php")!,
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
                    self.menugroups = dict.value(forKeyPath: "Response.data.menu") as! NSArray
                    self.bannerImageURls = dict.value(forKeyPath: "Response.data.menu_banner.menu_banner") as! NSArray
                    
                    print("Menu group list is \(String(describing: self.menugroups))")
                    print("Response Time of Menu Group is \(response.timeline)")
                    
                    
                  //  self.reLoadPageView()
                   self.CollectionViewMenuGroups.reloadData()
                    SVProgressHUD.dismiss(withDelay: 1)
                    self.ContainerView.isHidden = false
                    
        }

        
    }
        }
    }
    func reLoadPageView()
    {
                    let controller = storyboard?.instantiateViewController(withIdentifier: "BannerImages") as! PageViewMenuGroupsImagesVC
            
                    addChildViewController(controller)
                    ContainerView.addSubview(controller.view)
                    didMove(toParentViewController: controller)
                    controller.URLAraay = self.bannerImageURls as! [String]
            
        }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menugroups.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewMenuGroups.dequeueReusableCell(withReuseIdentifier: "MenuGroupsCollectionViewCell", for: indexPath) as! MenuGroupsCollectionViewCell
        let dict : NSDictionary = menugroups[indexPath.row] as! NSDictionary
       // cell.cellImageView.image = UIImage.init(named: "MenuGroupssample")
        cell.titleLabel.text = dict.value(forKey: "menu_title") as? String
        let imageaddress  = dict.value(forKey: "menu_image") as! String
        let imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        cell.cellImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "MenuGroupssample"))
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        
        SVProgressHUD.show()
        SVProgressHUD.setRingRadius(25)
        SelectedMenuGroup = menugroups[indexPath.row] as! NSDictionary
        self.performSegue(withIdentifier: "itemDetails", sender: self)
      
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetails" {
            if let nextViewController = segue.destination as? MenuItemListViewController{
              //  let destinationViewController = nextViewController.viewControllers?[0] as! MenuItemListViewController
                nextViewController.selectedGroup = SelectedMenuGroup
            }
            
        }
        else if segue.identifier == "BannerImages" {
            if let nextViewController = segue.destination as? PageViewMenuGroupsImagesVC{
                nextViewController.URLAraay = bannerImageURls as! [String] 
                
                
        }
        }
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        SVProgressHUD.dismiss()
       self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackButton"), for: .normal) // Image can be downloaded from here below link
        backButton.setTitle("Back", for: .normal)
      //  backButton.setTitleColor(backButton., for: .normal) // You can change the TitleColor
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
       self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
      //  self.navigationController?.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: backButton)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    

}
