//
//  AddRecordViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/24/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import Segmentio
import CoreData

class AddRecordViewController: BaseController {

    
    @IBOutlet weak var viewMoney: UIView!
    
    
    @IBOutlet weak var tfMoney: PickerBasedTextField!
    
    @IBOutlet weak var segmentioView: Segmentio!
    
    
    @IBOutlet weak var viewCategory: UIView!
    
    @IBOutlet weak var tfCategory: PickerBasedTextField!
    
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var viewDate: UIView!
    
    @IBOutlet weak var prefixLabel: UILabel!
    
    @IBOutlet weak var tfDate: PickerBasedTextField!
    
    var filterDirection : Int = -1
    
    var container: NSPersistentContainer!
    var categoryPicker: UIPickerView!
    var accountPicker: UIPickerView!
    var accountsList: [Accounts] = []
    var expenseCategoriesList: [Categories] = []
    var incomeCategoriesList: [Categories] = []
    var currentUid = ""
    var model: AddRecordModel = Facade.share.model.addRecordModel
    var record: Records!
    var currentString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        model.amount = 0
        model.datetime = Date()
        model.uid = nil
        self.setupAuthorList()
        self.setupCategoriesList()
        self.setupUI()
        self.title = "Thêm khoản thu/chi"

        // Do any additional setup after loading the view.
    }
    
    
    
    override func touchOnBack() {
        self.navigationController!.popViewController(animated: true)

        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }

    func setupUI(){
        segmentioView.setup(
            content: AddRecordViewController.segmentioContent(),
            style: .imageBeforeLabel,
            options: AddRecordViewController.segmentioOptions(segmentioStyle: .imageBeforeLabel)
        )
        
        segmentioView.selectedSegmentioIndex = 0
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            switch segmentIndex {
            case 0:
                self!.tfCategory.text = (self!.expenseCategoriesList.count > 0) ? self!.expenseCategoriesList[self!.model.expenseIndex].name : ""
    //            if model.expenseIndex <= categoryPicker.numberOfRows(inComponent: 0) {
                self!.categoryPicker.selectRow(self!.model.expenseIndex, inComponent: 0, animated: false)
    //            }
                self!.prefixLabel.text = "-" + "VNĐ"
                self!.prefixLabel.textColor = UIColor.black
                self?.filterDirection = -1
            case 1:
                self?.filterDirection = 1
                self!.tfCategory.text = (self!.incomeCategoriesList.count > 0) ? self!.incomeCategoriesList[self!.model.incomeIndex].name : ""
    //            if model.expenseIndex <= categoryPicker.numberOfRows(inComponent: 0) {
                self!.categoryPicker.selectRow(self!.model.incomeIndex, inComponent: 0, animated: false)
    //            }
                self!.prefixLabel.text = "+" + "VNĐ"
                self!.prefixLabel.textColor = UIColor.mainColor()
                
            default:
                break
            }
            
        }
        
        viewMoney.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewMoney.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewMoney.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewMoney.layer.shadowOpacity = 0.5
        viewMoney.layer.shadowRadius = 3
        viewMoney.layer.cornerRadius = 8
        
        viewCategory.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewCategory.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewCategory.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewCategory.layer.shadowOpacity = 0.5
        viewCategory.layer.shadowRadius = 3
        viewCategory.layer.cornerRadius = 8
        
        viewDate.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewDate.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewDate.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewDate.layer.shadowOpacity = 0.5
        viewDate.layer.shadowRadius = 3
        viewDate.layer.cornerRadius = 8
        
        guard expenseCategoriesList.count > 0 else {
            let errorDesc = """
You should have at least one expense category.
Go to Settings > Categories and add an 'Expense' category.
"""
            let alert = UIAlertController(title: "Error",
                                          message: errorDesc,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            })
            present(alert, animated: true, completion: nil)

            return
        }

        guard incomeCategoriesList.count > 0 else {
            let errorDesc = """
You should have at least one income category.
Go to Settings > Categories and add an 'Income' category.
"""
            let alert = UIAlertController(title: "Error",
                                          message: errorDesc,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            })
            present(alert, animated: true, completion: nil)

            return
        }

        if model.incomeIndex >= incomeCategoriesList.count {
            model.incomeIndex = 0
        }

        if model.expenseIndex >= expenseCategoriesList.count {
            model.expenseIndex = 0
        }

       
        // datePicker
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        tfDate.text = formatter.string(from: model.datetime)

        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = model.datetime
        datePicker.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker.backgroundColor = UIColor.white
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        tfDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        tfDate.delegate = self
        tfMoney.delegate = self
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor.black
        toolBar2.sizeToFit()

        let doneButton2 = UIBarButtonItem(title: "Done",
                                          style: UIBarButtonItem.Style.plain,
                                          target: self,
                                          action: #selector(AddRecordViewController.donePicker))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                           target: nil,
                                           action: nil)
        toolBar2.setItems([spaceButton2, spaceButton2, doneButton2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        tfDate.inputAccessoryView = toolBar2

        let frame = self.view.frame

        // categoryPicker config
        let catFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 216)
        categoryPicker = UIPickerView(frame: catFrame)
        categoryPicker.backgroundColor = UIColor.white
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        tfCategory.inputView = categoryPicker
        tfCategory.delegate = self

        // directionField config
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(AddRecordViewController.donePicker))
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        tfCategory.inputAccessoryView = toolBar

        // accountPicker config
        let accFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 216)
        accountPicker = UIPickerView(frame: accFrame)
        accountPicker.dataSource = self
        accountPicker.delegate = self
        accountTextField.inputView = accountPicker
        accountTextField.delegate = self
        accountTextField.text = (accountsList.count > 0) ? accountsList[0].name : ""

        tfMoney.becomeFirstResponder()
        self.tfCategory.text = (self.expenseCategoriesList.count > 0) ? self.expenseCategoriesList[self.model.expenseIndex].name : ""
//            if model.expenseIndex <= categoryPicker.numberOfRows(inComponent: 0) {
        self.categoryPicker.selectRow(self.model.expenseIndex, inComponent: 0, animated: false)
//            }
        self.prefixLabel.text = "-" + "VNĐ"
        self.prefixLabel.textColor = UIColor.black
        
        
        if let record = Facade.share.model.getRecord(uid: currentUid) {
            self.record = record

            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2

            //tfMoney.text = String("\(formatter.string(from: NSNumber(value: record.amount))!)")
            var strAmount = String(record.amount)
            let arr = strAmount.split(separator: ".").map(String.init)

            self.currentString = String(arr[0])
            self.formatCurrency(string: String(record.amount))
            if record.direction == 1 {
                model.direction = 1

                for (index, cat) in incomeCategoriesList.enumerated()
                    where cat.uid == record.relatedCategory.uid {
                        model.incomeIndex = index
                        break
                }
                segmentioView.selectedSegmentioIndex = 1

                self.filterDirection = 1
                self.tfCategory.text = (self.incomeCategoriesList.count > 0) ? self.incomeCategoriesList[self.model.incomeIndex].name : ""
    //            if model.expenseIndex <= categoryPicker.numberOfRows(inComponent: 0) {
               // self.categoryPicker.selectRow(self.model.incomeIndex, inComponent: 0, animated: false)
    //            }
                self.prefixLabel.text = "+" + "VNĐ"
                self.prefixLabel.textColor = UIColor.mainColor()
            } else {
                model.direction = -1
                segmentioView.selectedSegmentioIndex = 0

                for (index, cat) in expenseCategoriesList.enumerated()
                    where cat.uid == record.relatedCategory.uid {
                        model.expenseIndex = index
                        break
                }
                self.tfCategory.text = (self.expenseCategoriesList.count > 0) ? self.expenseCategoriesList[self.model.expenseIndex].name : ""
    //            if model.expenseIndex <= categoryPicker.numberOfRows(inComponent: 0) {
                //self.categoryPicker.selectRow(self.model.expenseIndex, inComponent: 0, animated: false)
    //            }
                self.prefixLabel.text = "-" + "VNĐ"
                self.prefixLabel.textColor = UIColor.black
                self.filterDirection = -1
            }
            model.datetime = record.datetime
            model.uid = record.uid
        } else {

        }

    }

    @objc func donePicker() {
        tfMoney.becomeFirstResponder()
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Thuộc khoản chi", image: UIImage(named: "ic_money_up")),
            SegmentioItem(title: "Thuộc khoản thu", image: UIImage(named: "ic_money_down"))
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
    
    
    public func setupCategoriesList() {
        do {
            let fetchRequest: NSFetchRequest<Categories> = Categories.createFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "direction == %d", 1)
            let sort = NSSortDescriptor(key: "sortId", ascending: true)
            fetchRequest.sortDescriptors = [sort]
            incomeCategoriesList = try Facade.share.model.container.viewContext.fetch(fetchRequest)

            fetchRequest.predicate = NSPredicate(format: "direction == %d", -1)
            fetchRequest.sortDescriptors = [sort]
            expenseCategoriesList = try Facade.share.model.container.viewContext.fetch(fetchRequest)
        } catch {
            print ("fetch task failed", error)
        }
    }
    
    public func setupAuthorList() {
        do {
            let fetchRequest: NSFetchRequest<Accounts> = Accounts.createFetchRequest()
            accountsList = try Facade.share.model.container.viewContext.fetch(fetchRequest)
        } catch {
            print ("fetch task failed", error)
        }
    }
    
    
    @IBAction func touchAddRecord(_ sender: Any) {
        guard tfMoney.text != "" && tfMoney.text != "0" else {
            let alert = UIAlertController(title: "Lỗi", message: "Bạn cần nhập vào số tiền", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        model.amount = tfMoney.text!.getDoubleFromLocal()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale =  NSLocale(localeIdentifier: "vi_VN") as Locale
        if let date = formatter.date(from: tfDate.text!) {
            model.datetime = date
        }

        if model.uid == "" || model.uid == nil {
            // new record
            record = Records(context: Facade.share.model.container.viewContext)
            record.uid = Facade.share.model.getNewUID()
        }

        if(filterDirection == -1){
            model.direction = -1
        }
        else {
            model.direction = 1
        }
        
        
        if model.direction == -1 {
            record.relatedCategory = expenseCategoriesList[model.expenseIndex]
            record.direction = -1
        } else {
            record.relatedCategory = incomeCategoriesList[model.incomeIndex]
            record.direction = 1
        }
        record.relatedAccount = accountsList[model.accountIndex]

        record.reported = (filterDirection == -1) ? true : false
        var amount : String = tfMoney.text!.replace(string: ".", replacement: "")
        
        
        record.amount = amount.getDoubleFromLocal()

        record.datetime = model.datetime

        Facade.share.model.saveContext()
        self.navigationController?.setNavigationBarHidden(true, animated: false)


        navigationController?.popViewController(animated: true)
    }
    
}


extension AddRecordViewController :  UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            if filterDirection == -1 {
                return expenseCategoriesList.count
            } else {
                return incomeCategoriesList.count
            }
        } else if pickerView == accountPicker {
            return accountsList.count
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            if filterDirection == -1 {
                return expenseCategoriesList[row].name
            } else {
                return incomeCategoriesList[row].name
            }
        } else if pickerView == accountPicker {
            return accountsList[row].name
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker {
            model.direction = filterDirection
            if model.direction == -1 {
                model.expenseIndex = row
                tfCategory.text = expenseCategoriesList[row].name
            } else {
                model.incomeIndex = row
                tfCategory.text = incomeCategoriesList[row].name
            }
        } else if pickerView == accountPicker {
            model.accountIndex = row
            accountTextField.text = accountsList[row].name
        }
    }

    @objc public func datePickerValueChanged(sender: UIDatePicker) {

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        model.datetime = sender.date.dateOnly()

        tfDate.text = dateFormatter.string(from: model.datetime)
    }

}


extension AddRecordViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if(textField == tfMoney){
            
            if(tfMoney.text!.count < 17){
                switch string {
                       case "0","1","2","3","4","5","6","7","8","9":
                           currentString += string
                           
                           formatCurrency(string: currentString)
                       default:
                           var array = Array(string)
                           var currentStringArray = Array(currentString)
                           if array.count == 0 && currentStringArray.count != 0 {
                               currentStringArray.removeLast()
                               currentString = ""
                               for character in currentStringArray {
                                   currentString += String(character)
                               }
                               formatCurrency(string: currentString)
                           }
                       }
                
            }
            else {
                if(tfMoney.text!.count == 17 && string == ""){
                    switch string {
                           case "0","1","2","3","4","5","6","7","8","9":
                               currentString += string
                               
                               formatCurrency(string: currentString)
                           default:
                               var array = Array(string)
                               var currentStringArray = Array(currentString)
                               if array.count == 0 && currentStringArray.count != 0 {
                                   currentStringArray.removeLast()
                                   currentString = ""
                                   for character in currentStringArray {
                                       currentString += String(character)
                                   }
                                   formatCurrency(string: currentString)
                               }
                           }
                }
                else {
                    return false

                }
            }
            
        }
        return false
    }
    
    func formatCurrency(string: String) {
          print(currentString)
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        formatter.currencySymbol = ""
            var numberFromField = (NSString(string: currentString).doubleValue)
        tfMoney.text = formatter.string(from: NSNumber(value: numberFromField))
        }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField is PickerBasedTextField {
            let textField2 = textField as! PickerBasedTextField
            textField2.border.borderColor = UIColor.myAppBlue.cgColor
            textField2.textColor = UIColor.myAppBlue
        }
        
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField is PickerBasedTextField {
            let textField2 = textField as! PickerBasedTextField
            textField2.border.borderColor = UIColor.black.cgColor
            textField2.textColor = UIColor.black
            
            
        }
        
        

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
