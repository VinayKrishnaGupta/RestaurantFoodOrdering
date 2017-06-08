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



class MenuGroupsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var CollectionViewMenuGroups: UICollectionView!
    @IBOutlet weak var bannerImageView: UIImageView!
    var menugroups : NSArray = []
    var bannerImageURls : NSArray = []
    var SelectedMenuGroup : NSDictionary = [:]
    var SelectedShortcutfromHome : NSDictionary = [:]
     var imagesListArray = [UIImage]()
    var bannerImageArray = [Any]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        SVProgressHUD.setRingRadius(25)
        CollectionViewMenuGroups.dataSource = self
        CollectionViewMenuGroups.delegate = self
      //  self.ContainerView.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
       
        let backButton1 = UIBarButtonItem.init(image: UIImage.init(named: "BackButton"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(backAction(_:)))
        
      
        
        self.navigationItem.leftBarButtonItem = backButton1
        

       // self.addBackButton()
        
      
    
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
        
//        var imagesListArray = [UIImage]()
//        
//        
//        
//        
//         imagesListArray.append(UIImage(named: "page0.png")!)
//         imagesListArray.append(UIImage(named: "page1.png")!)
//         imagesListArray.append(UIImage(named: "page2.png")!)
//         imagesListArray.append(UIImage(named: "Page3.png")!)
//        self.bannerImageView.animationImages = imagesListArray
//        self.bannerImageView.animationDuration = 4.0
//        self.bannerImageView.startAnimating()
        
        
        if SelectedShortcutfromHome.count != 0 {
         //   ContainerView.isHidden = true
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
                "Merchantname" : "admin",
                "Merchantid" : "3",
                "Connection" : "close"
            ]
            var UserID = "N"
            if (UserDefaults.standard.dictionary(forKey: "LoggedInUser")) != nil {
                let userDict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
                UserID = userDict.value(forKey: "enduser_id") as! String
            }
            else {
                UserID = "N"
                
            }
            
            let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
            let parameters2 = ["visit_ref" : VisitReference, "user_id":UserID] as [String : Any]
        Alamofire.request(
            URL(string: "https://pay-hub.in/payhub%20api/v1/menu_group.php")!,
            method: .post,
            parameters: parameters2,
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
                    
                    
                    
                   
                    
                    let VisitReferencefromServer : String = dict.value(forKeyPath: "Response.data.visit_ref") as! String
                    UserDefaults.standard.set(VisitReferencefromServer, forKey: "VisitReferenceNumber")
                    UserDefaults.standard.synchronize()

                    
                    print("Menu group list is \(String(describing: self.menugroups))")
                    print("Response Time of Menu Group is \(response.timeline)")
                    
                    
                  //  self.reLoadPageView()
                   self.CollectionViewMenuGroups.reloadData()
                    
                    
                    SVProgressHUD.dismiss(withDelay: 1)
                 //   self.ContainerView.isHidden = false
                    
        }
                
                else {
                    self.viewWillAppear(false)
                    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenheight = screenSize.height
            let Cwidth : CGFloat  = screenWidth - 20
            let Cheight : CGFloat = screenheight / 4
            
            return CGSize(width: Cwidth, height: Cheight)
        }
        else {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let Cwidth : CGFloat  = (screenWidth-40)/2
            
            return CGSize(width: Cwidth, height: Cwidth)
            
        }
        
        
    }

    
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return menugroups.count
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell1 = CollectionViewMenuGroups.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuBannerCollectionViewCell
       
            
            
            
            
            
        
            
            
            
            
//            imagesListArray.append(UIImage(named: "page0.png")!)
//            imagesListArray.append(UIImage(named: "page1.png")!)
//            imagesListArray.append(UIImage(named: "page2.png")!)
//            imagesListArray.append(UIImage(named: "Page3.png")!)
            
//            
//            DispatchQueue.global(qos: .userInitiated).async {
//                cell1.isHidden = true
//                for item in self.bannerImageURls {
//                    let imageaddress : String  = item as! String
//                    let Imageaddressurl = "https://pay-hub.in/tpl/web_admin_3/img/" +  (imageaddress)
//                    let imageurl : URL = URL(string: Imageaddressurl)!
//                    let data = try? Data(contentsOf: imageurl)
//                    let image : UIImage = UIImage.sd_image(with: data)
//                    self.imagesListArray.append(image)
//                    cell1.bannerImageView.animationImages = self.imagesListArray
//                    cell1.bannerImageView.animationDuration = 4.0
//                    cell1.bannerImageView.startAnimating()
//                    
//                    
//                }
            
            for item in self.bannerImageURls {
                let imageaddress : String  = item as! String
                let Imageaddressurl = "https://pay-hub.in/tpl/web_admin_3/img/" +  (imageaddress)
                let imageurl : URL = URL(string: Imageaddressurl)!
                self.bannerImageArray.append(imageurl)
                
                
            }

            
            
            cell1.bannerImageView.sd_setAnimationImages(withURLs: bannerImageArray)
            cell1.bannerImageView.animationDuration = 5
            cell1.bannerImageView.startAnimating()
            
            
//                DispatchQueue.main.async {
                    
                    
            
//                }
//                
//            }
            
            
            
            
            
            
            return cell1
            
            
            
            
        }
        
        
        
        
        else {
            
            let cell = CollectionViewMenuGroups.dequeueReusableCell(withReuseIdentifier: "MenuGroupsCollectionViewCell", for: indexPath) as! MenuGroupsCollectionViewCell
            let dict : NSDictionary = menugroups[indexPath.row] as! NSDictionary
            // cell.cellImageView.image = UIImage.init(named: "MenuGroupssample")
            cell.titleLabel.text = dict.value(forKey: "menu_title") as? String
            let imageaddress  = dict.value(forKey: "menu_image") as! String
            let imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
            cell.cellImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "MenuGroupssample"))
            
            
            return cell

            
        }
        
        
        
        
    
    
    
    
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        
        if indexPath.section == 1 {
            SVProgressHUD.show()
            SVProgressHUD.setRingRadius(25)
            SelectedMenuGroup = menugroups[indexPath.row] as! NSDictionary
            self.performSegue(withIdentifier: "itemDetails", sender: self)
        }
        
        
      
        
        
        
        
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
        self.SelectedShortcutfromHome = [:]
       self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackButton.png"), for: .normal)
       
        // Image can be downloaded from here below link
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
