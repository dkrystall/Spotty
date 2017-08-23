//
//  Profile+CoreDataProperties.swift
//  Spotty
//
//  Created by David Krystall on 2/12/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile");
    }

    @NSManaged public var experience: Int16
    @NSManaged public var gender: Int16
    @NSManaged public var name: String?
    @NSManaged public var sex: Int16
    @NSManaged public var weight: Double

}
