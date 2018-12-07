//
//  ViewController.swift
//  Balet
//
//  Created by Guillermo Romo Jiménez on 29/11/18.
//  Copyright © 2018 memoromoj. All rights reserved.
//
import UIKit
//import Firebase
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var addrlocation: UILabel!
    
    @IBAction func sideMenu(_ sender: Any) {
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! SideMenuViewController//MenuVC
        self.addChild(menuVC)
        menuVC.view.frame = self.view.frame
        self.view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
    }
    /** end view func*/
    var manager = CLLocationManager()
    var pointAnnotation:MKPinAnnotationView!
    var pinAnnotationView:MKPinAnnotationView!
    var globalCLLocation:CLLocation!
    var globalRegion:MKCoordinateRegion!
    var locAct = true
    var zooooomMap = 0.019
    var names:[String]!
    var coordinates:[Any]!
    var currentAlamIndex: Int = 0
    var loadingLocations = true
    /*** non view func*/
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.showsTraffic = false
        mapView.showsPointsOfInterest = false
        mapView.showsBuildings = false
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callback), userInfo: nil, repeats: false)//loc on
        Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(callback), userInfo: nil, repeats: true)//loc on/off cada 40 seg
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(callbackLocations), userInfo: nil, repeats: loadingLocations)//ubicaciones
        
        let latDelta:CLLocationDegrees = zooooomMap
        let lonDelta:CLLocationDegrees = zooooomMap
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(21.8780455, -102.3129373)
        globalRegion = MKCoordinateRegion(center: location, span: span)
        callback()
        names = ["San Marcos", "Villa Charrra"]
        coordinates = [
            [21.8780455, -102.3018993],
            [21.8695888, -102.3079263]
        ]
        currentAlamIndex = 0
        callback()
    }
    @objc func callback() {
        if(locAct){manager.startUpdatingLocation()
        }else{manager.stopUpdatingLocation()}
        locAct = !locAct
        mapView.setRegion(globalRegion, animated: true)
    }
    @objc func callbackLocations() {
        if currentAlamIndex > names.count - 1{
            currentAlamIndex = 0
        }
        let coordinate = coordinates[currentAlamIndex] as! [Double]
        let latitude: Double   = coordinate[0]
        let longitude: Double  = coordinate[1]
        let locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        
        var point = Annotation(coordinate: locationCoordinates)
        point.title = names[currentAlamIndex]
        //point.image = images[currentAlamIndex]
        // Calculate Transit ETA Request
        let request = MKDirections.Request()
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate, addressDictionary: nil))
        request.source = sourceItem
        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: locationCoordinates, addressDictionary: nil))
        request.destination = destinationItem
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculateETA { (etaResponse, error) -> Void in
            if let error = error {
                point.eta = error.localizedDescription
            }else{
                point.eta = "\(Int((etaResponse?.expectedTravelTime)!/60)) min"
            }
            var isExist = false
            for annotation in self.mapView.annotations{
                if annotation.coordinate.longitude == point.coordinate.longitude && annotation.coordinate.latitude == point.coordinate.latitude{
                    isExist = true
                    point = annotation as! Annotation
                }
            }
            if !isExist{self.mapView.addAnnotation(point)}
            self.currentAlamIndex += 1
        }
    }
}
// MARK: MKMapViewDelegate
extension ViewController :  MKMapViewDelegate,  CLLocationManagerDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        _ = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: zooooomMap, longitudeDelta: zooooomMap))
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        globalCLLocation = locations[0]
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = zooooomMap
        let lonDelta:CLLocationDegrees = zooooomMap
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        globalRegion = region
        addrlocation.text = "(Lat,Long) (\(latitude),\(longitude))"
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is Annotation){
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        let restaurantAnnotation = annotation as! Annotation
        annotationView?.detailCalloutAccessoryView = UIImageView(image: restaurantAnnotation.image)
        // Left Accessory
        let leftAccessory = UILabel(frame: CGRect(x: 0,y: 0,width: 50,height: 30))
        leftAccessory.text = restaurantAnnotation.eta
        leftAccessory.font = UIFont(name: "Verdana", size: 9)
        annotationView?.leftCalloutAccessoryView = leftAccessory
        // Right accessory view
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))//, self.currentAlamIndex)
        //button.id = self.currentAlamIndex
        //        button.id = self.currentAlamIndex
        button.backgroundColor = .green
        button.setTitle("Servicio", for: .normal)
//        button.addTarget(self, action: #selector(JustPCAction), for: .touchUpInside)
        annotationView?.rightCalloutAccessoryView = button
        return annotationView
    }
}
