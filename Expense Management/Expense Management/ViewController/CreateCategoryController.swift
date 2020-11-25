//
//  CreateCategoryController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/29/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import Segmentio
import FontAwesome_swift
class CreateCategoryController: BaseController {
    @IBOutlet weak var iconImg: UIImageView!
    
    
    @IBOutlet weak var tfCategoryName: UITextField!
    
    
    @IBOutlet weak var viewCategoryName: UIView!
    
    
    @IBOutlet weak var segmentioView: Segmentio!
    let fontStyle = SWIconConfig.style
    let fontColor = SWIconConfig.color
    lazy var fontList = FontAwesome.fontList(style: self.fontStyle)
    var filterDirection : Int = -1
    
    var isEdit : Bool = false
    
    @IBOutlet weak var collectionViewIcon: UICollectionView!
    
    
    @IBOutlet weak var btnAddCategory: UIButton!
    @IBOutlet weak var collectionViewColor: UICollectionView!
    let selectedColor = UIColor.green.withAlphaComponent(0.1)
    let deselectedColor = UIColor.white

    var selectedFont: FontAwesome?
    var iconSelectIdex : Int = 0
    var colorSelectIndex : Int = 0
    var category: Categories!
    var currentUid = ""
    var initialScrollDone : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Thêm thư mục"
        if(isEdit){
            self.title = "Sửa danh mục"
            self.btnAddCategory.setTitle("Lưu danh mục", for: UIControl.State.normal)
        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        category = Facade.share.model.getOrCreateCategory(uid: currentUid)
        var defaultDirection = UserDefaults.standard.integer(forKey: "DirectionInAddCategories")
        segmentioView.selectedSegmentioIndex = 0

        if category.uid == "" {
            // default initialisation for new category
           // self.currentIcon = FontAwesome.stream
        } else {
            // manipulate fields with current object data
           // self.currentIcon = FontAwesome(rawValue: category.icon)
            tfCategoryName.text = category.name
            if category.direction == 1 {
                segmentioView.selectedSegmentioIndex = 1

                defaultDirection = 1
                filterDirection = 1
            } else {
                segmentioView.selectedSegmentioIndex = 0
                filterDirection = -1
                defaultDirection = 0
            }
            self.iconSelectIdex = Int(category.iconIndex)
            if(iconSelectIdex == -1){
                for (index, element) in fontList.enumerated(){
                    if(self.category.icon == element.rawValue){
                        iconSelectIdex = index
                        
                    }
                }
            }
            self.colorSelectIndex = Int(category.colorIndex)
        }
        segmentioView.setup(
            content: CreateCategoryController.segmentioContent(),
            style: .imageBeforeLabel,
            options: CreateCategoryController.segmentioOptions(segmentioStyle: .imageBeforeLabel)
        )
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            switch segmentIndex {
            case 0:
                self?.filterDirection = -1
            case 1:
                self?.filterDirection = 1
            default:
                break
            }
            //self?.loadSavedData()
        }
        self.setupUI()
    }
    
    override func viewWillLayoutSubviews() {

       super.viewWillLayoutSubviews()

         
   }

    override func touchOnBack() {
        self.navigationController!.popViewController(animated: true)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupUI(){
        viewCategoryName.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewCategoryName.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewCategoryName.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewCategoryName.layer.shadowOpacity = 0.5
        viewCategoryName.layer.shadowRadius = 3
        viewCategoryName.layer.cornerRadius = 8
        
        
        let nib = UINib(nibName: "IconSelectionCell", bundle: nil)
        self.collectionViewIcon.register(nib, forCellWithReuseIdentifier: "IconSelectionCell")
        
        let nibColor = UINib(nibName: "CollectionColorCell", bundle: nil)
        self.collectionViewColor.register(nibColor, forCellWithReuseIdentifier: "CollectionColorCell")
        self.collectionViewIcon.delegate = self
        self.collectionViewIcon.dataSource = self
        
        collectionViewColor.delegate = self
        collectionViewColor.dataSource = self
        
        
        if (!self.initialScrollDone) {

           self.initialScrollDone = true
           let indexPath = NSIndexPath(row: iconSelectIdex, section: 0)
            let indexPathColor = NSIndexPath(row: colorSelectIndex, section: 0)

           self.collectionViewIcon.scrollToItem(at:IndexPath(item: iconSelectIdex, section: 0), at: .bottom, animated: true)
            
            self.collectionViewColor.scrollToItem(at:IndexPath(item: colorSelectIndex, section: 0), at: .bottom, animated: true)
      }

        
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Khoản Chi", image: nil),
            SegmentioItem(title: "Khoản Thu", image: nil)
        ]
    }
    
    private static func segmentioOptions(
        segmentioStyle: SegmentioStyle,
        segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3)) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }

        return SegmentioOptions(
            backgroundColor: UIColor.white,
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
//            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                type: SegmentioHorizontalSeparatorType.bottom, // Top, Bottom, TopAndBottom
                height: 1,
                color: .lightGray
            ),
            verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                ratio: 0.6, // from 0.1 to 1
                color: .lightGray
            ),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
//            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    
    
    @IBAction func tapAddCategory(_ sender: Any) {
        guard tfCategoryName.text != "" else {
            let alert = UIAlertController(title: "Có lỗi!", message: "Bạn cần nhập tên danh mục!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        if category.uid == "" {
            category.uid = Facade.share.model.getNewUID()
        }

        if filterDirection == -1 {
            category.direction = -1
        } else {
            category.direction = 1
        }
        category.name = tfCategoryName.text!
        category.icon = fontList[iconSelectIdex].rawValue
        category.iconIndex = Int64(iconSelectIdex)
        category.colorIndex = Int64(colorSelectIndex)
        Facade.share.model.saveContext()

        category.sortId = category.getAutoIncremenet()
        Facade.share.model.saveContext()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        navigationController?.popViewController(animated: true)
    }
    
}


extension CreateCategoryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionViewIcon){
            self.iconSelectIdex = indexPath.row
            self.collectionViewIcon.reloadData()
        }
        else {
            self.colorSelectIndex = indexPath.row
            self.collectionViewColor.reloadData()
            self.collectionViewIcon.reloadData()

        }
       
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

extension CreateCategoryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionViewIcon)
        {
            return fontList.count

        }
        else {
            return listColor.count

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionViewIcon == collectionView){
            let cell = self.collectionViewIcon.dequeueReusableCell(withReuseIdentifier: "IconSelectionCell", for: indexPath) as! IconSelectionCell

            let fontItem = self.fontList[indexPath.row]

            cell.imgIcon.image = UIImage.fontAwesomeIcon(
                name: fontItem,
                style: fontStyle,
                textColor: fontColor,
                size: CGSize(width: 35, height: 35)
            )
            
            //self.iconView?.image!.withRenderingMode(.alwaysTemplate)
            
            
            if(indexPath.row == iconSelectIdex){
                cell.viewSelectIcon.layer.borderColor = UIColor.red4.cgColor
                cell.viewSelectIcon.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.viewSelectIcon.layer.shadowColor = UIColor.red4.cgColor
                cell.viewSelectIcon.layer.shadowOpacity = 1
                cell.viewSelectIcon.layer.shadowRadius = 3
                cell.viewSelectIcon.layer.cornerRadius = 8
                cell.imgIcon.image =  cell.imgIcon.image!.withRenderingMode(.alwaysTemplate)
                cell.imgIcon.tintColor = listColor[colorSelectIndex]
            }
            
            else {
                cell.viewSelectIcon.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
                cell.viewSelectIcon.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.viewSelectIcon.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
                cell.viewSelectIcon.layer.shadowOpacity = 0.5
                cell.viewSelectIcon.layer.shadowRadius = 3
                cell.viewSelectIcon.layer.cornerRadius = 8
            }
            
            
            

            let isSelected = fontItem == selectedFont
            //cell.contentView.backgroundColor = isSelected ? selectedColor : deselectedColor

            return cell
        }
        else {
            let cell = self.collectionViewColor.dequeueReusableCell(withReuseIdentifier: "CollectionColorCell", for: indexPath) as! CollectionColorCell

            let fontItem = self.fontList[indexPath.row]

           
            if(indexPath.row == colorSelectIndex){
                cell.viewBorder.layer.borderColor = UIColor.red4.cgColor
                cell.viewBorder.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.viewBorder.layer.shadowColor = UIColor.red4.cgColor
                cell.viewBorder.layer.shadowOpacity = 1
                cell.viewBorder.layer.shadowRadius = 3
                cell.viewBorder.layer.cornerRadius = 8
            }
            
            else {
                cell.viewBorder.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
                cell.viewBorder.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.viewBorder.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
                cell.viewBorder.layer.shadowOpacity = 0.5
                cell.viewBorder.layer.shadowRadius = 3
                cell.viewBorder.layer.cornerRadius = 8
            }
            

            let isSelected = fontItem == selectedFont
            cell.viewColor.backgroundColor = listColor[indexPath.row]
            //cell.contentView.backgroundColor = isSelected ? selectedColor : deselectedColor

            return cell
        }
        
    }

}
