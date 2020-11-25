//
//  RecordViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
class RecordViewController: BaseController,NSFetchedResultsControllerDelegate  {
    var commitPredicate: NSPredicate?
    var fetchedResultsController: NSFetchedResultsController<Records>!
    var emptyLabel:UILabel?
    var imgEmpty : UIImageView?
    //let style: Style = Style.myApp
    var coverImageView = UIImageView()
    
    var issAddView : Bool = false
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return style.preferredStatusBarStyle
//    }
    
    @IBOutlet weak var tableView: UITableView!
    let expenseStoryboard = UIStoryboard(name: "ExpenseStoryBoard", bundle: nil)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bản ghi"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView?.register(UINib(nibName: "RecordViewCell", bundle: nil), forCellReuseIdentifier: "RecordViewCell")
        // Do any additional setup after loading the view.
        self.loadSavedData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.loadSavedData()
    }


    
    @IBAction func tapAddRecord(_ sender: Any) {
        let addRecordVC = expenseStoryboard.instantiateViewController(withIdentifier: "AddRecordViewController")as! AddRecordViewController
        addRecordVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(addRecordVC, animated: true)
    }
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = Records.createFetchRequest()
            let sort = NSSortDescriptor(key: "datetime", ascending: false)
            let sort2 = NSSortDescriptor(key: "uid", ascending: false)

            request.sortDescriptors = [sort, sort2]
            request.fetchBatchSize = 20

            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: Facade.share.model.container.viewContext,
                sectionNameKeyPath: "datetime",
                cacheName: nil)
            fetchedResultsController.delegate = self
        }

        fetchedResultsController.fetchRequest.predicate = commitPredicate

        do {
            try fetchedResultsController.performFetch()
            if fetchedResultsController.fetchedObjects?.count == 0 {
                self.emptyLabel?.isHidden = false
                self.imgEmpty?.isHidden = false
                tableView.separatorStyle = .none
            } else {
                self.emptyLabel?.isHidden = true
                self.imgEmpty?.isHidden = true
                tableView.separatorStyle = .singleLine
            }
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if fetchedResultsController.fetchedObjects?.count == 0 {
            if(issAddView == false ){
                self.initEmptyMessage()
                issAddView = true
            }
            
            self.emptyLabel?.isHidden = false
            self.imgEmpty?.isHidden = false

        } else {
            self.emptyLabel?.isHidden = true
            self.imgEmpty?.isHidden = true
            
            DispatchQueue.main.async {
                self.coverImageView.removeFromSuperview()
            }
        }
    }
    
    func initEmptyMessage() {
        emptyLabel = UILabel()
        emptyLabel?.text = "Bạn chưa có bản ghi nào!"
        emptyLabel?.textAlignment = .center
        emptyLabel?.textColor = UIColor.darkGray
        emptyLabel?.font = UIFont.systemFont(ofSize: 14)
        emptyLabel?.numberOfLines = 0
        self.tableView.addSubview(emptyLabel!)
        emptyLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 290, height: 80))
        })
        imgEmpty = UIImageView()
        imgEmpty?.image = UIImage.init(named: "ic_empty_box")
        self.tableView.addSubview(imgEmpty!)

        imgEmpty?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.size.equalTo(CGSize(width: 120, height: 120))
        })

         tableView.bringSubviewToFront(imgEmpty!)
       // tblHistory.bringSubviewToFront(emptyLabel!)
    }
    
    
}


extension RecordViewController : UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects

    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return nil
        }

        let objects = sectionInfo.objects
        if let topRecord: Records = objects?[0] as? Records {
            return topRecord.datetime.dayRepresentation()
        } else {
            return sectionInfo.indexTitle
        }
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return nil
        }

        guard let records = sectionInfo.objects as? [Records],
            let topRecord = records.first else {
            return nil
        }
        
        let headerView = RecordHeaderView()
        headerView.setup(with: RecordHeaderViewModel(
            title: topRecord.datetime.dayRepresentation(),
            spending: records.sum().value.recordPresenter(
                for: .all,
                formatting: false
        )))
        return headerView
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordViewCell", for: indexPath) as? RecordViewCell else {
            assertionFailure("Cell not found: RecordTableViewCell")
            return UITableViewCell()
        }

        let record = fetchedResultsController.object(at: indexPath)
        if record.direction > 0 {
            cell.amountLabel.textColor = UIColor.mainColor()
            cell.amountLabel.text = record.amount.recordPresenter(for: .income, formatting: false)
        } else {
            cell.amountLabel.textColor = UIColor.red
            cell.amountLabel.text = record.amount.recordPresenter(for: .cost, formatting: false)
        }
        cell.icon.image = record.relatedCategory.iconImage()
        
        cell.icon.image =  cell.icon.image!.withRenderingMode(.alwaysTemplate)
        cell.icon.tintColor = listColor[Int(record.relatedCategory.colorIndex)]
        cell.titleLabel.text = record.relatedCategory.name

        return cell
    }

     func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let record = fetchedResultsController.object(at: indexPath)
            Facade.share.model.container.viewContext.delete(record)
            Facade.share.model.saveContext()
            do {
                try fetchedResultsController.performFetch()
                tableView.reloadData()
            } catch {
                print("Fetch failed")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Xoá"
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let record = fetchedResultsController.object(at: indexPath)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "DisplayRecord") as! DisplayRecordViewController

        //controller.currentUid = record.uid
        //navigationController?.pushViewController(controller, animated: true)
        
        let record = fetchedResultsController.object(at: indexPath)
        let storyboard = UIStoryboard(name: "ExpenseStoryBoard", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AddRecordViewController") as? AddRecordViewController {
            
            controller.currentUid = record.uid
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}
