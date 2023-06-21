//
//  AmiiboEntity+CoreDataProperties.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//
//

import Foundation
import CoreData


extension AmiiboEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AmiiboEntity> {
        return NSFetchRequest<AmiiboEntity>(entityName: "AmiiboEntity")
    }

    @NSManaged public var amiiboSeries: String
    @NSManaged public var character: String
    @NSManaged public var head: String
    @NSManaged public var image: String
    @NSManaged public var name: String
    @NSManaged public var tail: String
    @NSManaged public var type: String
    @NSManaged public var amiiboRelease: ReleaseEntity

}

extension AmiiboEntity : Identifiable {

}
