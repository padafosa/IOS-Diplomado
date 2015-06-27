//
//  ManageDataBase.swift
//  IOSProject00
//
//  Created by internet on 5/21/15.
//  Copyright (c) 2015 internet. All rights reserved.
//

import UIKit
import CoreData

@objc(ManageDataBase)

class ManageDataBase: NSManagedObject {
    @NSManaged var nombre: String
    @NSManaged var direccion: String
    @NSManaged var pedido: String
    @NSManaged var fecha: String
    
}
