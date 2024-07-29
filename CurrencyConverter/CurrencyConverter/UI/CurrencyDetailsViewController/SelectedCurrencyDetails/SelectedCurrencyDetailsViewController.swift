//
//  SelectedCurrencyDetailsViewController.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 26.07.24.
//

import UIKit
import Charts
import DGCharts

final class SelectedCurrencyDetailsViewController: UIViewController, ChartViewDelegate {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 15
        static let tableViewContentInset: CGFloat = 20
    }
    
    // MARK: UI
    
//    lazy var lineChartView: LineChartView = {
    lazy var lineChartView: BarChartView = {
//        let chartView = LineChartView()
        let chartView = BarChartView()
        chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .boldSystemFont(ofSize: 10)
        leftAxis.setLabelCount(7, force: false)
        leftAxis.labelTextColor = .white
        leftAxis.axisLineColor = .white
        leftAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        chartView.xAxis.setLabelCount(7, force: false)
        chartView.xAxis.axisLineColor = .white
        
        chartView.animate(xAxisDuration: 1.5)
        
        return chartView
    }()
    
    
    // MARK: Private properties
    
    private let networkService = NetworkService.shared
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .darkGray6)
        configureNavigationBar()
        addSubViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLineChart(with: networkService.currencyRates ?? [], chartView: lineChartView)
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar() {
        title = LS("CURRENCIES.TAB.TITLE")
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupConstraints() {
        lineChartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview().inset(300)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func addSubViews() {
        view.addSubview(lineChartView)
    }
    
    private func setLineChartData(_ charDataEntry: [ChartDataEntry]) {
        let dataSet = LineChartDataSet(entries: charDataEntry, label: "")
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.setColor(.white)
        dataSet.fillColor = .white
        dataSet.fillAlpha = 0.8
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

class DateValueFormatter: AxisValueFormatter {
    private let dates: [String]
    private let dateFormatter: DateFormatter

    init(dates: [String]) {
        self.dates = dates
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"  // формат исходных данных
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index >= 0 && index < dates.count {
            let dateStr = dates[index]
            if let date = dateFormatter.date(from: dateStr) {
                let displayFormatter = DateFormatter()
                displayFormatter.dateFormat = "dd/MMM"  // нужный формат отображения
                return displayFormatter.string(from: date)
            }
        }
        return ""
    }
}

//func setupLineChart(with data: [DynamicCources], chartView: LineChartView) {
func setupLineChart(with data: [DynamicCources], chartView: BarChartView) {
//    var lineChartEntries: [ChartDataEntry] = []
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd/MMM"
//    
//    let sortedData = data.sorted {
//            guard let date1 = dateFormatter.date(from: $0.date),
//                  let date2 = dateFormatter.date(from: $1.date) else { return false }
//            return date1 < date2
//        }
//
//    for (index, course) in data.enumerated() {
//        let chartDataEntry = ChartDataEntry(x: Double(index), y: course.curOfficialRate)
//        lineChartEntries.append(chartDataEntry)
//    }
//
//    let lineDataSet = LineChartDataSet(entries: lineChartEntries, label: "Currency Rates")
//    
//    lineDataSet.mode = .cubicBezier
//    lineDataSet.drawCirclesEnabled = false
//    lineDataSet.lineWidth = 2
//    lineDataSet.setColor(.white)
//    lineDataSet.fillColor = .white
//    lineDataSet.fillAlpha = 0.8
//    lineDataSet.drawHorizontalHighlightIndicatorEnabled = false
//    lineDataSet.highlightColor = .systemRed
//    
//    let lineChartData = LineChartData(dataSet: lineDataSet)
//    lineChartData.setDrawValues(false)
//    chartView.data = lineChartData
//    
//    // Настройка внешнего вида графика
//    chartView.chartDescription.text = "Currency Rate Over Time"
//    chartView.xAxis.labelPosition = .bottom
//    chartView.xAxis.valueFormatter = DateValueFormatter(dates: data.map { $0.date })
//    chartView.xAxis.granularity = 1
//    chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
//    
//    // Настройка масштабирования и прокрутки
//       chartView.setScaleMinima(20, scaleY: 1)  // Отображать только 5 точек данных по оси X
//       chartView.dragEnabled = true
//       chartView.pinchZoomEnabled = true
//       chartView.highlightPerDragEnabled = true
//       chartView.setVisibleXRangeMaximum(20)  // Отображать максимум 5 точек данных
//       
//       chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM"

        // Сортировка данных по дате
        let sortedData = data.sorted {
            guard let date1 = dateFormatter.date(from: $0.date),
                  let date2 = dateFormatter.date(from: $1.date) else { return false }
            return date1 < date2
        }

        var barChartEntries: [BarChartDataEntry] = []

        for (index, course) in sortedData.enumerated() {
            let barChartDataEntry = BarChartDataEntry(x: Double(index), y: course.curOfficialRate)
            barChartEntries.append(barChartDataEntry)
        }

    let barDataSet = BarChartDataSet(entries: barChartEntries, label: "Currency Rates")
    var colors: [NSUIColor] = []
    barChartEntries.enumerated().forEach { (index, value) in
        if index > 0 {
            let positiveColor = NSUIColor.green
            let negativeColor = NSUIColor.red
            let noChangesColor = NSUIColor.blue
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
    barDataSet.valueColors = [NSUIColor.black]
    
    let barChartData = BarChartData(dataSet: barDataSet)
    chartView.data = barChartData
    
    // Уменьшение ширины столбиков
    let barWidth = 0.3  // Установите необходимую ширину столбиков
    barChartData.barWidth = barWidth
    
    // Настройка внешнего вида графика
    chartView.chartDescription.text = "Currency Rate Over Time"
    chartView.xAxis.labelPosition = .bottom
    chartView.xAxis.valueFormatter = DateValueFormatter(dates: sortedData.map { $0.date })
    chartView.xAxis.granularity = 1
    chartView.setScaleMinima(7, scaleY: 1)  // Отображать только 10 точек данных по оси X
    chartView.dragEnabled = true
    chartView.pinchZoomEnabled = true
    chartView.highlightPerDragEnabled = true
    chartView.setVisibleXRangeMaximum(7)  // Отображать максимум 10 точек данных
    
    chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
}
