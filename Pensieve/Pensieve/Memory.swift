//
//  Memory.swift
//  Pensieve
//
//  Created by Caroline Darch on 11/4/15.
//  Copyright © 2015 University of Virginia. All rights reserved.
//

import Foundation
import CoreData

@objc(Memory) class Memory: NSManagedObject {
    
    @NSManaged var memdate: String
    @NSManaged var memtime: String
    @NSManaged var memloc: String
    @NSManaged var memname: String
    @NSManaged var picfileloc: String
}