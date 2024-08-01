//
//  SelectedCurrencyDetailsViewController.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 26.07.24.
//

import UIKit
import Charts
import DGCharts

enum ChartsPeriod: CaseIterable {
    case week
    case month
    case threeMonths
    case sixMonths
    case year
    
    var title: String {
        switch self {
        case .week:
            return LS("WEEK")
        case .month:
            return LS("MONTH")
        case .threeMonths:
            return LS("THREE.MONTHS")
        case .sixMonths:
            return LS("SIX.MONTHS")
        case .year:
            return LS("YEAR")
        }
    }
    
    var countOfDays: Int {
        switch self {
        case .week:
            return 6
        case .month:
            return 30
        case .threeMonths:
            return  90
        case .sixMonths:
            return  180
        case .year:
            return 365
        }
    }
}

final class SelectedCurrencyDetailsViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 15
        static let tableViewContentInset: CGFloat = 20
    }
    
    // MARK: UI
    
    private lazy var chartView: BarChartView = {
        let chartView = BarChartView()
        chartView.backgroundColor = UIColor(resource: .darkGray6WithAlph56)
        chartView.rightAxis.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        leftAxis.labelTextColor = .white
        leftAxis.axisLineColor = .white
        leftAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        chartView.delegate = self
        
        return chartView
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: [
            ChartsPeriod.week.title,
            ChartsPeriod.month.title,
            ChartsPeriod.threeMonths.title,
            ChartsPeriod.sixMonths.title,
            ChartsPeriod.year.title
        ])
        
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor(resource: .darkGray6)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude))
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude))
        
        return tableView
    }()
    
    // MARK: Private properties
    
    private let networkService = NetworkService.shared
    private var chartsPeriod: ChartsPeriod = .week
    private var selectedCurrencyModel: CurrencyData?
    
    private var startDate: String? {
        let dateFormatter = DateFormatter()
        let daysCount: Int = chartsPeriod.countOfDays
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let previousDate = Calendar.current.date(byAdding: .day, value: -daysCount, to: Date()) else {
            return nil
        }
        
        return dateFormatter.string(from: previousDate)
    }
    
    private var endDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    private var selectedRate: String?
    
    // MARK: Initialisation
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, selectedCurrencyModel: CurrencyData?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.selectedCurrencyModel = selectedCurrencyModel
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .darkGray6)
        let sortedRates = NetworkService.shared.currencyRates?.sorted(by: {$0.curOfficialRate ?? 0 > $1.curOfficialRate ?? 0})
        selectedRate = sortedRates?.first?.formattedAmount
        configureNavigationBar(selectedRate ?? "")
        addSubViews()
        setupConstraints()
        configureSegmentControl()
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(periodSegmentControlChanged), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLineChart(with: networkService.currencyRates ?? [])
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar(_ rate: String) {
        title = "1" + " " + (selectedCurrencyModel?.currencyAbbreviation ?? "") + " = " + "\(rate) BYN"
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func addSubViews() {
        view.addSubview(chartView)
        view.addSubview(segmentControl)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        chartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.size.height / 2)
            $0.leading.trailing.equalToSuperview()
        }
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RatesTableViewCell.self, forCellReuseIdentifier: RatesTableViewCell.identifier)
    }
    
    private func configureSegmentControl() {
        let titleDeSelectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleSelectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(resource: .gray70)]
        
        segmentControl.setTitleTextAttributes(titleDeSelectedTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(titleSelectedTextAttributes, for: .selected)
        segmentControl.layer.cornerRadius = 9.0
        segmentControl.layer.borderWidth = 2.0
        segmentControl.layer.masksToBounds = true
    }
    
    @objc private func periodSegmentControlChanged() {
        guard let currencyID = selectedCurrencyModel?.currencyID else { return }
        chartsPeriod = ChartsPeriod.allCases[segmentControl.selectedSegmentIndex]
        fetchRates(currencyCode: currencyID)
    }
    
    private func setupLineChart(with data: [DynamicCources]) {
        var barChartEntries: [BarChartDataEntry] = []
        
        for (index, course) in data.enumerated() {
            let barChartDataEntry = BarChartDataEntry(x: Double(index), y: course.curOfficialRate ?? 0)
            barChartEntries.append(barChartDataEntry)
        }
        
        let barDataSet = BarChartDataSet(entries: barChartEntries, label: "")
        var colors: [NSUIColor] = []
        barChartEntries.enumerated().forEach { (index, value) in
            if index > 0 {
                let positiveColor = NSUIColor.green
                let negativeColor = NSUIColor.red
                let noChangesColor = NSUIColor.white
                if value.y > barChartEntries[index - 1].y {
                    colors.append(positiveColor)
                } else  if value.y == barChartEntries[index - 1].y {
                    colors.append(noChangesColor)
                } else {
                    colors.append(negativeColor)
                }
            } else {
                colors.append(NSUIColor.white)
            }
        }
        barDataSet.colors = colors
        barDataSet.valueColors = colors
        
        barDataSet.barBorderColor = .white
        barDataSet.barBorderWidth = 1
        
        let barChartData = BarChartData(dataSet: barDataSet)
        chartView.data = barChartData
        
        let barWidth = 0.2  // Установите необходимую ширину столбиков
        barChartData.barWidth = barWidth
        
        chartView.chartDescription.text = "Currency Rate Over Time"
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.valueFormatter = DateValueFormatter(dates: data.map { $0.date ?? "" })
        chartView.xAxis.granularity = 1
        chartView.dragEnabled = true
        chartView.pinchZoomEnabled = true
        chartView.highlightPerDragEnabled = true
        chartView.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .easeOutSine)
        chartView.setNeedsDisplay()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let midPoint = CGPoint(x: self.chartView.bounds.midX, y: self.chartView.bounds.midY)
            let closestPoint = self.chartView.getHighlightByTouchPoint(midPoint)
            self.chartView.highlightValue(closestPoint, callDelegate: true)
        }
        
        // Прокрутка к началу и сброс зума
        let chartViewHorizontalPoints = barChartEntries.count < 10 ? Double(barChartEntries.count) : 7
        chartView.fitScreen()
        chartView.moveViewToX(0)
        chartView.setVisibleXRangeMaximum(chartViewHorizontalPoints)
    }
    
    private func fetchRates(currencyCode: Int) {
        guard let endDate = endDate, let startDate = startDate else { return }
        NetworkService.shared.getCurrencyRates(
            networkProvider: NetworkRequestProviderImpl(),
            currencyCode: currencyCode,
            startDate: startDate,
            endDate: endDate
        ) { result in
            switch result {
            case .success(let rates):
                DispatchQueue.main.async {
                    self.setupLineChart(with: rates ?? [])
                    self.tableView.reloadData()
                }
            case .failure:
                self.showError(message: LS("SORRY.SOME.MISTAKE"))
            }
        }
    }
    
    private func showError(message: String?) {
        let closeAction = [
            UIAlertAction(title: LS("ALERT.CLOSE.BUTTON"), style: .cancel)
        ]
        showAlert(message: message, buttons: closeAction, viewController: self)
    }
}

// MARK: - UITableViewDelegate, - UITableViewDataSource

extension SelectedCurrencyDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        networkService.currencyRates?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatesTableViewCell.identifier, for: indexPath) as? RatesTableViewCell
        cell?.selectionStyle = .none
        var rateState: RateState = .equal
        if let currencyRates = networkService.currencyRates {
            let sortedCurrencyRates = currencyRates.sorted(by: {$0.date ?? "" > $1.date ?? ""})
            let currencyRate = sortedCurrencyRates[indexPath.row]
            
            if indexPath.row < sortedCurrencyRates.count - 1,
                let curOfficialRate = currencyRate.curOfficialRate,
               let previousCurOfficialRate = sortedCurrencyRates[indexPath.row + 1].curOfficialRate {
                if curOfficialRate > previousCurOfficialRate {
                    rateState = .positive
                } else if curOfficialRate < previousCurOfficialRate {
                    rateState = .negative
                } else {
                    rateState = .equal
                }
            }
            
            cell?.fill(currencyRate: currencyRate, rateState: rateState)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currencyRates = networkService.currencyRates {
            let sortedCurrencyRates = currencyRates.sorted(by: {$0.date ?? "" > $1.date ?? ""})
            if let rate = sortedCurrencyRates[indexPath.row].curOfficialRate {
                title = "1" + " " + (selectedCurrencyModel?.currencyAbbreviation ?? "") + " = " + "\(rate) BYN"
            }
        }
    }
}

extension SelectedCurrencyDetailsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        selectedRate = "\(entry.y)"
        title = "1" + " " + (selectedCurrencyModel?.currencyAbbreviation ?? "") + " = " + "\(selectedRate ?? "") BYN"
    }
}
