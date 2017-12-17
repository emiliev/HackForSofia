//
//  ObjectContainer.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/17/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import Foundation

class ObjectContainer{
    
    var objects: [Object] = []
    
    static var sharedObject = ObjectContainer()
    
    private init(){}
}
