//
//  Exercise+CoreDataProperties.swift
//  Spotty
//
//  Created by David Krystall on 2/12/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise");
    }

    @NSManaged public var exercise: String?
    @NSManaged public var weight: Double

}
