//
//  CustomViewCell.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/26/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit

@IBDesignable class CustomViewCell: UIView {
    @IBOutlet weak var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.nibSetup()
        self.initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.nibSetup()
        self.initUI()
    }

    private func nibSetup() {
        self.backgroundColor = .clear

        self.view = loadViewFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.translatesAutoresizingMaskIntoConstraints = true

        self.addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }

    func initUI() {

    }
}
