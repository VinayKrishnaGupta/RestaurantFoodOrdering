//
//  PageViewMenuGroupsImagesVC.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 17/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class PageViewMenuGroupsImagesVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{

    var pages = [UIViewController]()
    var timerofOffers : Timer?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
       
        let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "Page1")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "Page2")
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "Page3")
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        

        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        timerofOffers = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPageTwoSecond), userInfo: nil, repeats: true)
    }
    
    func moveToNextPageTwoSecond() 
    {
        NSLog("2 second timer")
        let currenindex = pages.index(of: (viewControllers?[0])!)
        let nextIndex = abs((currenindex! + 1) % pages.count)
        let page = pages[nextIndex]
        
        setViewControllers([page], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool)
    {
        timerofOffers?.invalidate()
        timerofOffers = nil
        
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
