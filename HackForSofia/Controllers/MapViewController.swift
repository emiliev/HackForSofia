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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func loadAnnotations(){
        print("soon")   
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
        
        storage.collection("locations")
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let sSelf = self,
                    let unwarpQuery = querySnapshot,
                    error == nil
                    else { return }
                
                sSelf.locations = []
                
                for doc in unwarpQuery.documents{
                    print(doc.data())
                }
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
