//
//  SettingsViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import Segmentio
//import FontAwesome
import CoreData

class SettingsViewController: BaseController,NSFetchedResultsControllerDelegate {
    let expenseStoryboard = UIStoryboard(name: "ExpenseStoryBoard", bundle: nil)

    @IBOutlet weak var segmentioView: Segmentio!
    var generalPredicate: NSPredicate?

    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<Categories>!
    var filterDirection: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.title = "Cài đặt"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView?.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")

        segmentioView.setup(
            content: SettingsViewController.segmentioContent(),
            style: .imageBeforeLabel,
            options: SettingsViewController.segmentioOptions(segmentioStyle: .imageBeforeLabel)
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
            self?.loadSavedData()
        }
        self.loadSavedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadSavedData()

    }

    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Khoản Chi", image: UIImage(named: "ic_money_up")),
            SegmentioItem(title: "Khoản Thu", image: UIImage(named: "ic_money_down"))
        ]
    }
    
    @IBAction func tapAddCategory(_ sender: Any) {
        //let addCategoryVC = expenseStoryboard.instantiateViewController(withIdentifier: "AddCategoryViewController")as! AddCategoryViewController
        
        let addCategoryVC = expenseStoryboard.instantiateViewController(withIdentifier: "CreateCategoryController")as! CreateCategoryController
        addCategoryVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(addCategoryVC, animated: true)
    }
    
    
    
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = Categories.createFetchRequest()
            let sort = NSSortDescriptor(key: "sortId", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20

            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: Facade.share.model.container.viewContext,
                sectionNameKeyPath: "direction",
                cacheName: nil)
            fetchedResultsController.delegate = self
        }

        generalPredicate = NSPredicate(format: "direction = %d", filterDirection)
        fetchedResultsController.fetchRequest.predicate = generalPredicate

        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
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


extension SettingsViewController  : UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        if((fetchedResultsController) != nil){
            return fetchedResultsController.sections?.count ?? 0

        }
        else {
            return 0
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    
  

     func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = fetchedResultsController.object(at: indexPath)

            if Facade.share.model.getNumberOfRecordsInCategory(uid: category.uid) == 0 {

                Facade.share.model.container.viewContext.delete(category)
                Facade.share.model.saveContext()
            } else {
                let alert = UIAlertController(
                    title: "Error",
                    message: "You should remove all records in this category first",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
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

     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

     func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        let category = fetchedResultsController.object(at: sourceIndexPath)
        let newSortId = fetchedResultsController.object(at: destinationIndexPath).sortId

        Facade.share.model.changeCategoryOrdering(category, newSortId: newSortId)

        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }

    }

     func tableView(_ tableView: UITableView,
                            targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            var row = 0
            if sourceIndexPath.section < proposedDestinationIndexPath.section {
                row = self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1
            }
            return IndexPath(row: row, section: sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        let category = fetchedResultsController.object(at: indexPath)

        cell.setup(model: CategoryTableViewCellModel(
            title: category.name,
            icon: category.iconImage()
        ), filterDirect: self.filterDirection, colorIndex: category.colorIndex)
        

        return cell
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = fetchedResultsController.object(at: indexPath)

        let storyboard = UIStoryboard(name: "ExpenseStoryBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateCategoryController") as! CreateCategoryController
        controller.hidesBottomBarWhenPushed = true
        controller.isEdit = true
        controller.currentUid = category.uid
        navigationController?.pushViewController(controller, animated: true)
    }

}
