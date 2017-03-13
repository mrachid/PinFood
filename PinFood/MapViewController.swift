//
//  MapViewController.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var restaurant:RestaurantMO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
    }
    
    func updateUI(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!) { (placemarks, error) in
            if error != nil{
                print(error)
                return
            }
            if let placemarks = placemarks{
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: restaurant.image as! Data)
        annotationView?.leftCalloutAccessoryView = leftIconView
        //        annotationView?.pinTintColor = UIColor.green
        
        return annotationView
    }
    
}
