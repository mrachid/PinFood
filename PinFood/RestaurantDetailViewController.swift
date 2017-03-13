//
//  RestaurantDetailViewController.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant:RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapConfig()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        //Map view button back
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Infos", style: .plain, target: nil, action: nil)
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Add pin to mapKit
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!) { (placemarks, error) in
            if error != nil{
                print(error)
                return
            }
            if let placemarks = placemarks{
                let placemark = placemarks[0]
                
                //Add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location{
                    //display annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    //set Zoom level
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                }
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI() {
        title = restaurant.name
        restaurantImageView.image = UIImage(data: restaurant.image as! Data)
        //tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func mapConfig() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func showMap() {
        performSegue(withIdentifier: "showMap", sender: self)
        
    }
    
    //MARK - TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment: "Name Field")//"Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Type", comment: "Type Field")
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = NSLocalizedString("Location", comment: "Location Field") //"Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = NSLocalizedString("Phone", comment: "Phone Field") //"Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = NSLocalizedString("Been here", comment: "Have you been here Field") //"Been here"
            if let rating = restaurant.rating{
                cell.valueLabel.text = (restaurant.isVisited) ? NSLocalizedString("Yes, I've been here before.", comment: "Yes, I've been here before") + rating : NSLocalizedString("No", comment: "No, I haven't been here")
                //"Yes, I've been here before. \(rating)" : "No"
            }else{
                cell.valueLabel.text = (restaurant.isVisited) ? NSLocalizedString("Yes, I've been here before.", comment: "Yes, I've been here before") : NSLocalizedString("No", comment: "No, I haven't been here")
                //cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before" : "No"
            }
            
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        //cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    
    
    @IBAction func close(segue:UIStoryboardSegue){}
    
    @IBAction func ratingButtonTapped(segue:UIStoryboardSegue){
        if let rating = segue.identifier{
            restaurant.isVisited = true
            switch rating {
            case "great": restaurant.rating = "Absolutely love it! Must try again."
            case "good": restaurant.rating = "Pretty good."
            case "dislike": restaurant.rating = "I don't like it."
            default: break
            }
        }
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            appDelegate.saveContext()
        }
        tableView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview"{
            let rvc = segue.destination as! ReviewViewController
            rvc.restaurant = restaurant
        }
        else if segue.identifier == "showMap"{
            let mvc = segue.destination as! MapViewController
            mvc.restaurant = restaurant
        }
        
        
    }
    
    
}

