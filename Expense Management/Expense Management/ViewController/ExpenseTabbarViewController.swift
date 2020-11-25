//
//  ExpenseTabbarViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/23/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit

class ExpenseTabbarViewController: UITabBarController {
    let expenseStoryboard = UIStoryboard(name: "ExpenseStoryBoard", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.setupController()
        
    }
    

   
    
    func setupController(){
        
          
        let recordVC =  expenseStoryboard.instantiateViewController(withIdentifier: "RecordViewController")as! RecordViewController
        recordVC.title = "Bản ghi"
        recordVC.tabBarItem.image = UIImage(named: "ic_saving")
        recordVC.tabBarItem.selectedImage = UIImage(named: "ic_saving")
                  let navRecord =  UINavigationController(rootViewController: recordVC)
         
//        let dashboardVC =  expenseStoryboard.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
//        dashboardVC.title = "Thống kê"
//        dashboardVC.tabBarItem.image = UIImage(named: "ic_profit")
//        dashboardVC.tabBarItem.selectedImage = UIImage(named: "ic_profit")
//                  let navDashboard =  UINavigationController(rootViewController: dashboardVC)
        
        let dashboardVC =  expenseStoryboard.instantiateViewController(withIdentifier: "ReportViewController")as! ReportViewController
        dashboardVC.title = "Thống kê"
        dashboardVC.tabBarItem.image = UIImage(named: "ic_profit")
        dashboardVC.tabBarItem.selectedImage = UIImage(named: "ic_profit")
                  let navDashboard =  UINavigationController(rootViewController: dashboardVC)
        
        let settingVC =  expenseStoryboard.instantiateViewController(withIdentifier: "SettingsViewController")as! SettingsViewController
        settingVC.title = "Cài đặt"
        settingVC.tabBarItem.image = UIImage(named: "ic_settings")
        settingVC.tabBarItem.selectedImage = UIImage(named: "ic_settings")
                  let navSetting =  UINavigationController(rootViewController: settingVC)
       
                        self.viewControllers = [navRecord,navDashboard,navSetting]

       
          
        
         
         tabBar.tintColor = UIColor.mainColor()
    }
}
