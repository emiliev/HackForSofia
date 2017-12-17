//
//  Object.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import Foundation
import Firebase

enum ObjectType{
    case building
    case church
    case museum
    case theatre
    case gallery
    case monument
    case fortress
    
    
    static func typeFor(text: String) -> ObjectType{
        switch text{
            case "church":      return .church
            case "museum":      return .museum
            case "theatre" :    return .theatre
            case "gallery":     return .gallery
            case "monument" :   return .monument
            case "fortress" :   return .fortress
            case "building":    return .building
            default:
                return .fortress
        }
    }
}

class Object{
    var position: GeoPoint = GeoPoint(latitude: 0, longitude: 0)
    var altitude: Double = 0
    var assetName: String = "No name"
    var desc: String = "No description"
    var name: String = "No name"
    var type: ObjectType = .building
    var link: String = "youtube.com"
    
    init?(dict: Dictionary<String, Any>){
        guard let d_name = dict["name"] as? String,
            let d_assetName = dict["assetName"] as? String,
            let d_description = dict["description"] as? String,
            let d_type = dict["type"] as? String,
            let d_youtube = dict["youtube"] as? String,
            let d_altitude = dict["altitude"] as? Double,
            let d_position = dict["position"] as? GeoPoint
        else { return }
    
        self.name = d_name
        self.assetName = d_assetName
        self.desc = d_description
        self.link = d_youtube
        self.altitude = d_altitude
        self.position = d_position
        self.type = ObjectType.typeFor(text: d_type)
    }
}
