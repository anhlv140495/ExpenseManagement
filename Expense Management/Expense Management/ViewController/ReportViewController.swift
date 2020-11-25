//
//  ReportViewController.swift
//  VayMuonP4New
//
//  Created by LE VIET ANH on 10/29/20.
//  Copyright © 2020 Sơn Bùi. All rights reserved.
//

import UIKit
import Segmentio
import CoreData
import Charts
import FontAwesome_swift
class ReportViewController: BaseController {
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var segmentioView: Segmentio!
    
    private var monthYearList = [EMMonth]()
    private var currentYear: Int = Date().year()
    private var currentMonth: Int = Date().month()
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private var overalInfo = [(label: String, value:String)]()
    private var costInfo = [(icon : String,label: String, value:String)]()
    private var budgetInfo = [(amount:Double, budget:Double)]()
    private var incomeInfo = [(icon : String,label: String, value:String)]()
    private var currencyLabel = NSLocale.defaultCurrency
    private var totalBudget = 0.0
    private var monthData = ReportModel.monthlyOveralInfo()
    
    @IBOutlet weak var viewExpense: UIView!
    
    
    @IBOutlet weak var viewIncome: UIView!
    
    
    @IBOutlet weak var viewTotal: UIView!
    
    @IBOutlet weak var segmentioViewOption: Segmentio!
    
    @IBOutlet weak var lbCost: UILabel!
    
    @IBOutlet weak var lbIncome: UILabel!
    
    @IBOutlet weak var lbTotal: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var check : Int = 1
    var direction : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        check = 0
        StoreReviewHelper.checkAndAskForReview()

        configureSegmentedView()
        totalBudget = Facade.share.model.getTotalBudget()
       
        calculateOveralInfo()
        calculateCostInfo()
        calculateIncomeInfo()
        self.setupUI()
        if(direction == -1){
            self.setDataCount(costInfo.count, list: costInfo)
            

        }
        else{
            self.setDataCount(incomeInfo.count, list: incomeInfo)

        }
       // configureChart()
        tableView?.register(UINib(nibName: "DashboardViewCell", bundle: nil), forCellReuseIdentifier: "DashboardViewCell")
        tableView?.register(UINib(nibName: "DashboardCostViewCell", bundle: nil), forCellReuseIdentifier: "DashboardCostViewCell")
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.tableFooterView  = UIView()
        tableView.reloadData()
        self.remakeConstraint()
        lbCost.text = overalInfo[0].value
        lbIncome.text = overalInfo[1].value
        lbTotal.text = overalInfo[2].value
    }
    
    private static func segmentioTitleContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Khoản Chi", image: nil),
            SegmentioItem(title: "Khoản Thu", image: nil)
        ]
    }
    
    func setupUI(){
        viewExpense.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewExpense.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewExpense.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewExpense.layer.shadowOpacity = 0.5
        viewExpense.layer.shadowRadius = 3
        viewExpense.layer.cornerRadius = 8
        
        viewIncome.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewIncome.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewIncome.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewIncome.layer.shadowOpacity = 0.5
        viewIncome.layer.shadowRadius = 3
        viewIncome.layer.cornerRadius = 8
        
        viewTotal.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewTotal.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewTotal.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        viewTotal.layer.shadowOpacity = 0.5
        viewTotal.layer.shadowRadius = 3
        viewTotal.layer.cornerRadius = 8
        
        
        segmentioViewOption.setup(
            content: ReportViewController.segmentioTitleContent(),
            style: .imageBeforeLabel,
            options: ReportViewController.segmentioOptions(segmentioStyle: .imageBeforeLabel)
        )
        
        segmentioViewOption.selectedSegmentioIndex = 0
        segmentioViewOption.valueDidChange = { [weak self] _, segmentIndex in
            switch segmentIndex {
            case 0:
                self!.direction = -1
                self!.setDataCount(self!.costInfo.count, list: self!.costInfo)

                self?.tableView.reloadData()
                self!.remakeConstraint()

                break
            case 1:
                self!.direction = 1
                self!.setDataCount(self!.incomeInfo.count, list: self!.incomeInfo)

                self?.tableView.reloadData()
                self!.remakeConstraint()

               break
            default:
                break
            }
            
        }
    }

    private func configureChart() {
        //lineChartView = LineChartView(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 200))

        //lineChartView?.delegate = self

        lineChartView?.chartDescription?.enabled = false
        lineChartView?.dragEnabled = true
        lineChartView?.setScaleEnabled(false)
        lineChartView?.pinchZoomEnabled = false
        lineChartView?.rightAxis.enabled = false

       // lineChartView?.xAxis.valueFormatter = self
        lineChartView?.xAxis.granularity = 1

        lineChartView?.legend.form = .line

        lineChartView?.animate(yAxisDuration: 0.3)

        
        //setupLineChartData()
    }

   
   
    func setDataCount(_ count: Int,list : [(icon : String,label: String, value:String)]) {
        var total : Double  = 0
        for i in list{
            let arr = i.value.split(separator: " ").map(String.init)
            var value = arr[1].replace(string: ",", replacement: "")
            total += Double(value)!
        }
        
        
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            let arr = list[i].value.split(separator: " ").map(String.init)
            var value = arr[1].replace(string: ",", replacement: "")
            return PieChartDataEntry(value: Double((Double(value)!/total) * 100),
                                     label: list[i].label,
                                     icon: nil)
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.white)
        data.setDrawValues(false)
        //pieChartView.isDrawEntryLabelsEnabled = false
        pieChartView.drawEntryLabelsEnabled = false
        
        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }
    
    func configureSegmentedView() {
//        let frame = tableView.frame
//        let segmentioViewRect = CGRect(x: frame.minX, y: frame.minY, width: UIScreen.main.bounds.width, height: 50)
//        segmentioView = Segmentio(frame: segmentioViewRect)
        segmentioView?.setup(
            content: segmentioContent(),
            style: .onlyLabel,
            options: ReportViewController.segmentioOptions(segmentioStyle: .imageBeforeLabel)
        )
        segmentioView?.selectedSegmentioIndex = segmentioView?.segmentioItems.count ?? 0 - 1
        currentYear = monthYearList.last!.year
        currentMonth = monthYearList.last!.month

        segmentioView?.valueDidChange = { [weak self] _, index in
           
           
            self?.updateDataAt(index: index)
            self?.lineChartView?.highlightValue(x: Double(index), dataSetIndex: -1)
            self?.lineChartView?.centerViewToAnimated(xValue: Double(index), yValue: 0, axis: .left, duration: 0.3)
            if(self!.direction == -1){
                self!.setDataCount(self!.costInfo.count, list: self!.costInfo)
                self!.remakeConstraint()

            }
            else {
                self!.setDataCount(self!.incomeInfo.count, list: self!.incomeInfo)
                self!.remakeConstraint()

            }
        }

        
    }

    func calculateOveralInfo() {
        overalInfo.removeAll()

        let numDays = Date.getMonthDuration(year: currentYear, month: currentMonth, considerCurrent: true)
        let numDaysAll =  Date.getMonthDuration(year: currentYear, month: currentMonth, considerCurrent: false)

        let monthlyTotalCost = Facade.share.model.getTotalMonth(year: currentYear, month: currentMonth, type: .cost)
        let dailyAverageCost = monthlyTotalCost / Double(numDays)

        let monthlyTotalIncome = Facade.share.model.getTotalMonth(year: currentYear,
                                                                  month: currentMonth,
                                                                  type: .income)
        let dailyAverageIncome = monthlyTotalIncome / Double(numDays)

        let monthlyTotal = monthlyTotalIncome - monthlyTotalCost
        let dailyAverage = dailyAverageIncome - dailyAverageCost

        overalInfo.append((
            "Tổng khoản chi",
            monthlyTotalCost.recordPresenter(for: .cost)
        ))
        overalInfo.append((
            "Tổng khoản thu",
            monthlyTotalIncome.recordPresenter(for: .income)
        ))
        overalInfo.append((
            "Tổng",
            monthlyTotal.recordPresenter(for: .all)
        ))

        if totalBudget > 0 {
            let monthlyTotalSave = totalBudget - monthlyTotalCost
            overalInfo.append((
                "Tông tiết kiệm",
                monthlyTotalSave.recordPresenter(for: .all)
            ))
        }

        overalInfo.append((" ", " "))

        overalInfo.append((
            "Trung bình thu chi một ngày",
            dailyAverage.recordPresenter(for: .all)
        ))
        overalInfo.append((
            "Trung bình chi tiêu một ngày",
            dailyAverageCost.recordPresenter(for: .cost)
        ))
        overalInfo.append((
            "Trung bình thu nhập một ngày",
            dailyAverageIncome.recordPresenter(for: .income)
        ))

        if Date().year() == currentYear && Date().month() == currentMonth {
            overalInfo.append((" ", " "))

            let monthlyForecast = dailyAverage * Double(numDaysAll)
            overalInfo.append((
                "Dự báo thu chi hàng tháng",
                monthlyForecast.recordPresenter(for: .all)
            ))

            let monthlyForecastCost = dailyAverageCost * Double(numDaysAll)
            overalInfo.append((
                "Dự báo chi phí hàng tháng",
                monthlyForecastCost.recordPresenter(for: .cost)
            ))

            let monthlyForecastIncome = dailyAverageIncome * Double(numDaysAll)
            overalInfo.append((
                "Dự báo thu nhập hàng tháng",
                monthlyForecastIncome.recordPresenter(for: .income)
            ))
        }

    }

    func calculateCostInfo() {
        costInfo.removeAll()
        budgetInfo.removeAll()
        let catWithCost = Facade.share.model.getMonthlyTotalByCategory(year: currentYear,
                                                                       month: currentMonth,
                                                                       type: .cost)
        for result in catWithCost {
            costInfo.append((
                icon : result.category.icon,
                label: result.category.name,
                value: result.amount.recordPresenter(for: .cost)
            ))
            budgetInfo.append((amount: result.amount, budget: result.category.budget))
        }
    }

    func calculateIncomeInfo() {
        incomeInfo.removeAll()
        let catWithCost = Facade.share.model.getMonthlyTotalByCategory(year: currentYear,
                                                                       month: currentMonth,
                                                                       type: .income)
        for result in catWithCost {
            incomeInfo.append((
                icon : result.category.icon,
                label: result.category.name,
                value: result.amount.recordPresenter(for: .income)
            ))
        }
    }

    private func segmentioContent() -> [SegmentioItem] {
        let (minDate, maxDate) = Facade.share.model.getMinMaxDateInRecords()
        self.monthYearList = Date.monthsBetweenDates(
            startDate: minDate,
            endDate: maxDate)

        return self.monthYearList.compactMap {
            return SegmentioItem(title: $0.titleWithCurrentYear, image: nil)
        }
    }

    private static func segmentioOptions(
        segmentioStyle: SegmentioStyle,
        segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 3))
        -> SegmentioOptions {
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

     func updateDataAt(index: Int) {
        let (minDate, maxDate) = Facade.share.model.getMinMaxDateInRecords()
        self.monthYearList = Date.monthsBetweenDates(
            startDate: minDate,
            endDate: maxDate)
       
            if(index == monthYearList.count){
                guard let currentYear : Int = self.monthYearList[index - 1].year,
                      let currentMonth : Int = self.monthYearList[index - 1].month else {
                        assertionFailure("No data for selected index")
                        return
                }
                self.currentYear = currentYear
                self.currentMonth = currentMonth
            }
            else {
                guard let currentYear : Int = self.monthYearList[index].year,
                      let currentMonth : Int = self.monthYearList[index].month else {
                        assertionFailure("No data for selected index")
                        return
                }
                self.currentYear = currentYear
                self.currentMonth = currentMonth
            }
           
        
      
      

        self.totalBudget = Facade.share.model.getTotalBudget()
        self.currencyLabel = NSLocale.defaultCurrency

        self.calculateOveralInfo()
        self.calculateCostInfo()
        self.calculateIncomeInfo()
        lbCost.text = overalInfo[0].value
        lbIncome.text = overalInfo[1].value
        lbTotal.text = overalInfo[2].value

        self.tableView.reloadData()
        self.remakeConstraint()
    }
    
    func remakeConstraint() {
       // tableView.layoutIfNeeded()
        if(direction == -1){
            tableViewHeight.constant = CGFloat(45 * (costInfo.count ))

        }
        else {
            tableViewHeight.constant = CGFloat(45 * (incomeInfo.count))

        }
    }
    
    func iconImage(size: CGSize = SWIconConfig.defaultSize, icon : String ) -> UIImage? {
//        guard icon.isEmpty,
//            let font = FontAwesome(rawValue: icon) else {
//           //let defaultIcon = self.direction > 0 ? "UpIcon" : "DownIcon"
//            return UIImage(named: icon)
//        }
        //let font = FontAwesome(rawValue: icon)
        let fontIcon = FontAwesome(rawValue: icon)
        return UIImage.SWFontIcon(
            name: fontIcon!,
            size: size
        )
    }
}


extension ReportViewController : UITableViewDelegate, UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch direction {
        case -1:
            return costInfo.count
        case 1:
            return incomeInfo.count
       
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Xoá"
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if direction == -1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardViewCell", for: indexPath) as! DashboardViewCell
            cell.selectionStyle = .none

            cell.textNameLabel?.text = costInfo[indexPath.row].label
            cell.textValue?.text = costInfo[indexPath.row].value
            cell.imgIcon.image = self.iconImage(icon: costInfo[indexPath.row].icon)

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardViewCell", for: indexPath) as! DashboardViewCell
            cell.selectionStyle = .none

            cell.textNameLabel?.text = incomeInfo[indexPath.row].label
            cell.textValue?.text = incomeInfo[indexPath.row].value
            cell.imgIcon.image = self.iconImage(icon: incomeInfo[indexPath.row].icon)
            return cell
        }
    
    }
}
