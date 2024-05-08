import UIKit

final class FelCalculatorViewController: UIViewController {
    
    // MARK: Private properties
    
    private var fuel: [Fuel]? = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient([UIColor.green, UIColor.yellow, UIColor.red], locations: [0.0, 0.5, 1.0],frame: view.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkService.shared.fetchFuel { result in
            switch result {
            case .success(let fuel):
                self.fuel = fuel
                //                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription, buttons: [], viewController: self)
            }
        }
    }
}
