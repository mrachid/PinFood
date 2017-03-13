//
//  WalkthroughPageViewController.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    
    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1","foodpin-intro-2","foodpin-intro-3"]
    var pageContents = [
        "Pin your favorite restaurants and create your own food guide",
        "Search and locate your favourite restaurant on Maps",
        "Find restaurants pinned by your friends and other foodies around the world"
    ]
    
    var userDefault:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count{
            return nil
        }
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContents[index]
            pageContentViewController.index = index
            
            
            return pageContentViewController
        }
        return nil
    }
    
    //MARK - INDCATORS PAGE CONTENT VIEW CONTROLLER
    
    /*
     func presentationCount(for pageViewController: UIPageViewController) -> Int {
     return pageHeadings.count
     }
     
     func presentationIndex(for pageViewController: UIPageViewController) -> Int {
     if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController{
     return pageContentViewController.index
     }
     return 0
     }
     */
    
    func forward(at index:Int) {
        if let nextViewController = contentViewController(at: index + 1){
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    
    
}
