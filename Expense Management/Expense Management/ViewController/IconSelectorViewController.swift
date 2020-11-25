//
//  IconSelectorViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol IconSelectorDelegate: AnyObject {
    func iconSelected(icon: FontAwesome?)
}

class IconSelectorViewController: UIViewController {
    @IBOutlet weak var iconCollectionView: UICollectionView!
    weak var delegate: IconSelectorDelegate?

    let fontStyle = SWIconConfig.style
    let fontColor = SWIconConfig.color
    lazy var fontList = FontAwesome.fontList(style: self.fontStyle)

    let selectedColor = UIColor.green.withAlphaComponent(0.1)
    let deselectedColor = UIColor.white

    var selectedFont: FontAwesome?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.iconCollectionView.delegate = self
        self.iconCollectionView.dataSource = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.delegate?.iconSelected(icon: selectedFont)
    }
}

extension IconSelectorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFont = self.fontList[indexPath.row]
        dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = selectedColor
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = deselectedColor
        }
    }

}

extension IconSelectorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.iconCollectionView.dequeueReusableCell(withReuseIdentifier: "gallery", for: indexPath) as! IconCollectionCell

        let fontItem = self.fontList[indexPath.row]

        cell.iconView.image = UIImage.fontAwesomeIcon(
            name: fontItem,
            style: fontStyle,
            textColor: fontColor,
            size: CGSize(width: 35, height: 35)
        )

        let isSelected = fontItem == selectedFont
        cell.contentView.backgroundColor = isSelected ? selectedColor : deselectedColor

        return cell
    }

}
