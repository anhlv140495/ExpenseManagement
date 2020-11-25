//
//  AddCategoryViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import Segmentio
import FontAwesome_swift
class AddCategoryViewController: BaseController {

    
    
    @IBOutlet weak var iconImg: UIImageView!
    
    
    @IBOutlet weak var tfCategoryName: UITextField!
    
    
    @IBOutlet weak var viewCategoryName: UIView!
    
    
    @IBOutlet weak var segmentioView: Segmentio!
    var filterDirection : Int = -1
    
    var isEdit : Bool = false
    
    @IBOutlet weak var btnAddCategory: UIButton!
    
    
    var currentIcon: FontAwesome? {
        didSet {
            guard let currentIcon = currentIcon else { return }
            self.iconImg?.image = UIImage.SWFontIcon(name: currentIcon)
        }
    }
    
    var currentUid = ""
    var category: Categories!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Thêm danh mục"
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        if(isEdit == true){
            self.title = "Sửa danh mục"
            self.btnAddCategory.setTitle("Lưu danh mục", for: UIControl.State.normal)
        }
        
        category = Facade.share.model.getOrCreateCategory(uid: currentUid)
        var defaultDirection = UserDefaults.standard.integer(forKey: "DirectionInAddCategories")
        if category.uid == "" {
            // default initialisation for new category
            self.currentIcon = FontAwesome.stream
        } else {
            // manipulate fields with current object data
            self.currentIcon = FontAwesome(rawValue: category.icon)
            tfCategoryName.text = category.name
            if category.direction == 1 {
                defaultDirection = 1
            } else {
                defaultDirection = 0
            }
        }
        //categoryTypeInput.selectedSegmentIndex = defaultDirection
        
        segmentioView.setup(
            content: AddCategoryViewController.segmentioContent(),
            style: .imageBeforeLabel,
            options: AddCategoryViewController.segmentioOptions(segmentioStyle: .imageBeforeLabel)
        )
        
        segmentioView.selectedSegmentioIndex = 0
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
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapAddCategory(_ sender: Any) {
        guard tfCategoryName.text != "" else {
            let alert = UIAlertController(title: "Error", message: "You should enter the name", preferredStyle: .alert)
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
        category.icon = currentIcon?.rawValue ?? ""

        Facade.share.model.saveContext()

        category.sortId = category.getAutoIncremenet()
        Facade.share.model.saveContext()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        navigationController?.popViewController(animated: true)
    }
    
    func setupUI(){
        viewCategoryName.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewCategoryName.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewCategoryName.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewCategoryName.layer.shadowOpacity = 0.5
        viewCategoryName.layer.shadowRadius = 3
        viewCategoryName.layer.cornerRadius = 8
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let iconSelectorVC = segue.destination as? IconSelectorViewController else { return }
        iconSelectorVC.delegate = self
        iconSelectorVC.selectedFont = currentIcon
    }
    
    @IBAction func tapIcon(_ sender: Any) {
       
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Khoản Chi", image: nil),
            SegmentioItem(title: "Khoản Thu", image: nil)
        ]
    }
    
    override func touchOnBack() {
        self.navigationController!.popViewController(animated: true)

        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if category.uid == "" {
            Facade.share.model.container.viewContext.delete(category)
            Facade.share.model.saveContext()
        }
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

}

extension AddCategoryViewController: IconSelectorDelegate {
    func iconSelected(icon: FontAwesome?) {
        self.currentIcon = icon
    }
}
