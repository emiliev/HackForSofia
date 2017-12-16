//
//  Object.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import Foundation

enum ObjectType{
    case building
    
}

class Object{
    var position: Position = (0,0)
    var altitude: Double = 0
    var assetName: String = "No name"
    var desc: String = "No description"
    var name: String = "No name"
    var type: ObjectType = .building
    var link: String = "youtube.com"
}
