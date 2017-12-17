//
//  Artwork.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/17/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import MapKit
import Contacts

import Firebase

class Artwork: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String?
    
    var object: Object?
    
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

    func imageName() -> String{
        guard let unwarpObject = object else { return "pin"}
        
        switch unwarpObject.type{
            case .building: return "arheologiq"
            case .church : return "carkva-1"
            case .museum: return "muzei"
            case .theatre: return "teatar"
            case .gallery: return "teatar"
            case .monument: return "arheologiq"
            case .fortress : return "kolona"
        }
    }
    
    
    func mapItem() -> MKMapItem {
        let addressDict = [ CNPostalAddressStreetKey
        : "asdf"]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}


class ArtworkView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            //      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let imageName = artwork.imageName()
            image = UIImage(named: imageName)
            
        }
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
            
//            print(artwork.imageName())
//            glyphImage = UIImage(named: "park")
            image = UIImage(named: "park")
            
        }
    }
}
