//
//  Common.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import Foundation
import FirebaseFirestore

typealias Position = (Double, Double)
typealias LocalArea = (Double,Double,Double,Double) // minX,maxX, minY,maxY
let LOCATION_OFFSET = 0.00050
//let appUser = User.sharedUser
let storage = Firestore.firestore()

enum DatabaseTables{
    case locations
}

