//
//  DashboardCostViewCell.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/26/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit

protocol BudgetFieldDelegate: AnyObject {
    func didEndEditing(cell: DashboardCostViewCell)
}

class DashboardCostViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var budgetAmount: UITextField!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var budgetPercentage: UIProgressView!
    weak var budgetDelegate: BudgetFieldDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        if amountLabel != nil {
            amountLabel.text = NSLocale.defaultCurrency
        }
        budgetAmount.delegate = self

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.mainColor()
        self.selectedBackgroundView = bgColorView
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        setSelected(true, animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setSelected(false, animated: true)
        self.budgetDelegate?.didEndEditing(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func makeFirstResponder() {
        budgetAmount.becomeFirstResponder()
    }

}
