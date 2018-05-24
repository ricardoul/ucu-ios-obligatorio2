//
//  ViewController.swift
//  Obligatorio2
//
//  Created by Ricardo Umpierrez on 5/17/18.
//  Copyright © 2018 Ricardo Umpierrez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import MapKit
import UIKit





class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    var atms = [Atm]();
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initControls()
        self.loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initControls() {
        self.mapView.isRotateEnabled = true
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        let center = CLLocationCoordinate2DMake(-34.9032800, -56.1881600)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.25, 0.25))
        self.mapView.setRegion(region, animated: true)
        mapView.isHidden = true;
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height * 0.5) // put in the middle
        activityIndicator.startAnimating() // Start animating
        self.activityIndicator = activityIndicator;
    }
    
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        if let annotation = annotation as? AtmAnnotationView {
            annotationView?.pinTintColor = annotation.colour;
            annotationView?.canShowCallout = true
            let button = UIButton(type: .custom);
            ImageLoad.setImageButton(url: URL(string: ImageLoad.decideNetworkImage(network: self.atms[annotation.atmId!].network!))!, button: button)
            button.tag = annotation.atmId!;
            button.frame = CGRect(x: 104, y: 68, width: 100, height: 40);
            button.addTarget(self, action: #selector(pressed(sender:)), for: UIControlEvents.touchDown)
            annotationView?.rightCalloutAccessoryView = button;
        }
        return annotationView
    }
    
    @objc func pressed(sender: UIButton!) {
       performSegue(withIdentifier: "detailSegue", sender: sender);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let atmDetail = segue.destination as! AtmDetailViewController //Cast with your DestinationController
        //Now simply set the title property of vc
        let button = sender as! UIButton
        atmDetail.atm = atms[button.tag]
    }
    

    func resolveColorByStatus(status:String) -> UIColor{
        switch status {
        case "normal":
            return UIColor.green;
        case "normal (with tint)":
            return UIColor.blue;
        default:
            return UIColor.red;
        }
    }
    
    func loadItems(){
            let URL = "https://ucu-atm.herokuapp.com/api/atm"
        Alamofire.request(URL).responseArray { (response: DataResponse<[Atm]>) in
            if (response.result.isFailure){
                
                // create the alert
                let alert = UIAlertController(title: "Hubo un error", message: "Reintentaremos cargar los datos nuevamente.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                self.loadItems();
                return
            }
            self.atms = response.result.value!;
            
            for atm in self.atms{
                let annotation = AtmAnnotationView()
                annotation.atmId = atm.id! - 1;
                annotation.title = atm.address! + "- " + atm.network!;
                annotation.subtitle = (atm.hasMoney! == true) ? "Has money" : "No has Money";
                annotation.colour = self.resolveColorByStatus(status: atm.status!)
                
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: (atm.location?.lat)!, longitude: (atm.location?.lon)!)
                self.mapView.addAnnotation(annotation)
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.removeFromSuperview()
                self.mapView.isHidden = false;
            }
        }
    }



}

