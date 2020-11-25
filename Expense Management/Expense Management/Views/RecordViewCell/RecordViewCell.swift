//
//  RecordViewCell.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/26/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit

class RecordViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIScreen.main.nativeBounds.height == 1136 {
            amountLabel.font = amountLabel.font.withSize(17) // for others 20
            titleLabel.font = titleLabel.font.withSize(14) // for others 17
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
