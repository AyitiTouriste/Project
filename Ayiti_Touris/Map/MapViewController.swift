//
//  MapViewController.swift
//  Ayiti_Touris
//
//  Created by Mac on 9/16/1397 AP.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    private var destinations: [MKPointAnnotation] = []
    private var currentRoute: MKRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureLocationServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureLocationServices(){
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomToLastestLocation(with coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }

private func addAnnotations(){
    
    let appleParkAnnotation = MKPointAnnotation()
    appleParkAnnotation.title = "Apple Park"
    appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.332072300, longitude: -122.0111138100)
    
    let ortegaParkAnnotation = MKPointAnnotation()
    ortegaParkAnnotation.title = "Ortega Park"
    ortegaParkAnnotation.coordinate =  CLLocationCoordinate2D(latitude: 37.342226, longitude: -122.025617)
    destinations.append(appleParkAnnotation)
    destinations.append(ortegaParkAnnotation)
    
    mapView.addAnnotation(appleParkAnnotation)
    mapView.addAnnotation(ortegaParkAnnotation)
    }
    
    private func constructRoute(userlocation: CLLocationCoordinate2D){
        
        let directionsRequest = MKDirectionsRequest()
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userlocation))
        
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinations[0].coordinate))
        
        directionsRequest.requestsAlternateRoutes = true
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate{[weak self](directionsResponse, error)in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let response = directionsResponse, response.routes.count > 0 {
                
                strongSelf.currentRoute = response.routes[0]
                
                strongSelf.mapView.add(response.routes[0].polyline)
                strongSelf.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
    }

}


extension MapViewController: CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let currentRoute = currentRoute else {
            return MKOverlayRenderer()
        }
        
        let polyLineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
        polyLineRenderer.strokeColor = UIColor.orange
        polyLineRenderer.lineWidth = 5
        
        return polyLineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotation{
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationVIew")
        }
        
        if let title = annotation.title, title == "Apple Park" {
            annotationView?.image = UIImage(named: "saucer")
        } else if let title = annotation.title, title == "Ortega Park" {
            annotationView?.image = UIImage(named: "car")
        }
        
        annotationView?.canShowCallout = true
        return annotationView as! MKAnnotation
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
//        print("The annotation was selected: \(String(describing: view.annotation?.title))")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        
        guard let lastestLocation = locations.first else {return}
        if currentCoordinate == nil {
            zoomToLastestLocation(with: lastestLocation.coordinate)
            addAnnotations()
            constructRoute(userlocation: lastestLocation.coordinate)
        }
        currentCoordinate = lastestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       print("The status changed")
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
