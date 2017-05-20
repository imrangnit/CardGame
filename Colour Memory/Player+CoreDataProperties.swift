//
//  Player+CoreDataProperties.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 25/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player");
    }

    @NSManaged public var playerName: String?
    @NSManaged public var points: Int16
    @NSManaged public var rank: Int16
    
}
