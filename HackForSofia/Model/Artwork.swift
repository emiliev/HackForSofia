//
//  Artwork.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/17/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class Artwork: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String?
    
    
    init(coordinate: CLLocationCoordinate2D, title:String){
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
    
    init?(dict: Dictionary<String, Any>){
        guard let position = dict["position"] as? GeoPoint,
        let d_name = dict["name"] as? String
        
        else { return }
        
        coordinate = CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude)
 
        title = d_name
    }
}

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            glyphImage = UIImage(named: "user")
            
        }
    }
}
