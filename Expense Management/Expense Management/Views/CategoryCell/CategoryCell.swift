//
//  CategoryCell.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit


struct CategoryTableViewCellModel {
    let title: String?
    let icon: UIImage?
}



class CategoryCell: UITableViewCell {
    
    @IBOutlet private var iconView: UIImageView?
    @IBOutlet private var titleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: CategoryTableViewCellModel, filterDirect : Int,colorIndex : Int64) {
        self.titleLabel?.text = model.title
        self.iconView?.image = model.icon

        if(filterDirect == -1){
            self.iconView?.image =  self.iconView?.image!.withRenderingMode(.alwaysTemplate)
            self.iconView?.tintColor = listColor[Int(colorIndex)]
        }
        else {
            self.iconView?.image =  self.iconView?.image!.withRenderingMode(.alwaysTemplate)
            self.iconView?.tintColor = listColor[Int(colorIndex)]
        }
        
    }

}
