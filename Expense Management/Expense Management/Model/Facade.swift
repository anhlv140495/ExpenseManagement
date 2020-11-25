//
//  Facade.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import Foundation
class Facade {
    static let share = Facade()
    let model = PersistentModel()

    private init() {
//        print("Facade - init")
    }
}
