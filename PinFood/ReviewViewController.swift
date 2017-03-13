//
//  ReviewViewController.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var restaurant : RestaurantMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        animationPopUp()
    }
    
    func updateUI() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        if let restaurant = restaurant{
            imageView.image = UIImage(data: restaurant.image as! Data)
        }
        
    }
    
    func animationPopUp()  {
        //view Translation - concatenation transform
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        
        //Button translation
        let translateButtonTransform = CGAffineTransform.init(translationX: 100, y: 0)
        closeButton.transform = translateButtonTransform
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Animation View
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.containerView.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
        //Animation Button
        UIView.animate(withDuration: 1.3, animations: {
            self.closeButton.transform = CGAffineTransform.identity
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
