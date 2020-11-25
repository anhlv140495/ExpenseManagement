//
//  CategoriesData.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
import CoreData

extension Categories {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var direction: Int16
    @NSManaged public var sortId: Int64
    @NSManaged public var colorIndex: Int64
    @NSManaged public var iconIndex: Int64
    @NSManaged public var name: String
    @NSManaged public var icon: String
    @NSManaged public var generalId: String
    @NSManaged public var parent: String
    @NSManaged public var uid: String
    @NSManaged public var relatedRecords: NSSet
    @NSManaged public var budget: Double

    public override func willSave() {
        super.willSave()

        if self.sortId == 0 {
            setPrimitiveValue(getAutoIncremenet(), forKey: "sortId")
        }
    }

    func getAutoIncremenet() -> Int64 {
        let url = self.objectID.uriRepresentation()
        let urlString = url.absoluteString
        if let partialNumber = urlString.components(separatedBy: "/").last {
            let numberPart = partialNumber.replacingOccurrences(of: "p", with: "")
            if let number = Int64(numberPart) {
                return number
            }
        }
        return 0
    }

}

// MARK: Generated accessors for relatedRecords
extension Categories {

    @objc(addRelatedRecordsObject:)
    @NSManaged public func addToRelatedRecords(_ value: Records)

    @objc(removeRelatedRecordsObject:)
    @NSManaged public func removeFromRelatedRecords(_ value: Records)

    @objc(addRelatedRecords:)
    @NSManaged public func addToRelatedRecords(_ values: NSSet)

    @objc(removeRelatedRecords:)
    @NSManaged public func removeFromRelatedRecords(_ values: NSSet)

}
