//
//  SWRecordHeaderView.swift
//  SmartWallet
//
//  Created by Soheil on 12/01/2020.
//  Copyright © 2020 Soheil Novinfard. All rights reserved.
//

import UIKit

struct RecordHeaderViewModel {
	let title: String?
	let spending: String?
}

class RecordHeaderView: CustomViewCell {
	@IBOutlet private var titleLabel: UILabel?
	@IBOutlet private var spendingLabel: UILabel?

	override func initUI() {
		self.titleLabel?.font = self.titleLabel?.font.withSize(17)
		self.spendingLabel?.font = self.spendingLabel?.font.withSize(15)
		self.spendingLabel?.textColor = .gray
	}

	func setup(with viewModel: RecordHeaderViewModel) {
		self.titleLabel?.text = viewModel.title
		self.spendingLabel?.text = viewModel.spending
        print(viewModel.spending)
        if(Array(viewModel.spending!)[0] == "-"){
            self.spendingLabel?.textColor = .red

        }
        else {
            self.spendingLabel?.textColor = .mainColor()

        }
	}
}
