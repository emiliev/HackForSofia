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
    
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
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
                
               
                for doc in unwarpQuery.documents{
                    let dict = doc.data()
                    
                    guard let object = Object(dict: dict),
                        let artwork = Artwork(dict: dict)
                    else { continue }
                    
                    ObjectContainer.sharedObject.objects.append(object)
                    sSelf.locations.append(object)
                    artwork.object = object
                    sSelf.annotations.append(artwork)
                }
                
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}




