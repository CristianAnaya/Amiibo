//
//  ReleaseEntity+CoreDataProperties.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//
//

import Foundation
import CoreData


extension ReleaseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReleaseEntity> {
        return NSFetchRequest<ReleaseEntity>(entityName: "ReleaseEntity")
    }

    @NSManaged public var au: String?
    @NSManaged public var eu: String?
    @NSManaged public var jp: String?
    @NSManaged public var na: String?
    @NSManaged public var amiibo: AmiiboEntity?

}

extension ReleaseEntity : Identifiable {

}
