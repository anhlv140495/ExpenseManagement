//
//  RecordData.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
import CoreData

extension Records {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Records> {
        return NSFetchRequest<Records>(entityName: "Records")
    }

    @NSManaged public var amount: Double
    @NSManaged public var datetime: Date
    @NSManaged public var direction: Int16
    @NSManaged public var note: String
    @NSManaged public var reported: Bool
    @NSManaged public var uid: String
    @NSManaged public var year: Int64
    @NSManaged public var month: Int16
    @NSManaged public var relatedAccount: Accounts
    @NSManaged public var relatedCategory: Categories

    public override func willSave() {
        super.willSave()

        if self.year != Int64(datetime.year()) {
            self.year = Int64(datetime.year())
        }

        if self.month != Int64(datetime.month()) {
            self.month = Int16(datetime.month())
        }
    }

}
