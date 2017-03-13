//
//  WalkthroughContentViewController.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var forwardButton: UIButton!
    
    var index = 0
    var heading = ""
    var content = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardButton.setTitle("NEXT", for: UIControlState.normal)
        case 2: forwardButton.setTitle("DONE", for: UIControlState.normal)
        default: break
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(sender: UIButton){
        switch index {
        case 0...1:
            if let pageViewController = parent as? WalkthroughPageViewController {
                pageViewController.forward(at: index)
            }
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}
