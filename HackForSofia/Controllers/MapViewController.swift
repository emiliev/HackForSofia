//
//  MapViewController.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager = CLLocationManager()
    private let SPAN_DELTA = 0.0075
    private var locations: [Object] = []
    private var annotations: [Artwork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func loadAnnotations(){
        mapView.addAnnotations(annotations)
    }
}


//MARK:- CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let pos = (location.coordinate.latitude, location.coordinate.longitude)
        getObjects(position: pos)
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: SPAN_DELTA, longitudeDelta: SPAN_DELTA))
        
        self.mapView.setRegion(region, animated: true)
        manager.stopUpdatingLocation()
    }
    
    private func getObjects(position: Position){
        
        storage.collection("\(DatabaseTables.locations)")
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let sSelf = self,
                    let unwarpQuery = querySnapshot,
                    error == nil
                    else { return }
                
                sSelf.locations = []
                
               
                unwarpQuery.documents.forEach({ (document) in
                    let dict = document.data()
                    
                    if let object = Object(dict: dict){
                        sSelf.locations.append(object)
                        
                    }
                    
                    if let artworkObject = Artwork(dict: dict){
                        sSelf.annotations.append(artworkObject)
                    }
                })
                
                sSelf.loadAnnotations()
        
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
        else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

//MARK:- MKMapViewDelegate
extension MapViewController: MKMapViewDelegate{
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? Artwork else { return nil }
//        // 3
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        // 4
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
}




