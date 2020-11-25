//
//  AccountsData.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
import CoreData

extension Accounts {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Accounts> {
        return NSFetchRequest<Accounts>(entityName: "Accounts")
    }

    @NSManaged public var currency: String
    @NSManaged public var initial: Double
    @NSManaged public var name: String
    @NSManaged public var uid: String
    @NSManaged public var relatedRecords: NSSet

}

// MARK: Generated accessors for relatedRecords
extension Accounts {

    @objc(addRelatedRecordsObject:)
    @NSManaged public func addToRelatedRecords(_ value: Records)

    @objc(removeRelatedRecordsObject:)
    @NSManaged public func removeFromRelatedRecords(_ value: Records)

    @objc(addRelatedRecords:)
    @NSManaged public func addToRelatedRecords(_ values: NSSet)

    @objc(removeRelatedRecords:)
    @NSManaged public func removeFromRelatedRecords(_ values: NSSet)

}
