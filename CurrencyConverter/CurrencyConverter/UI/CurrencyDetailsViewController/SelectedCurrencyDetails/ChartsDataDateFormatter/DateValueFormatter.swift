import Foundation
import Charts
import DGCharts

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
