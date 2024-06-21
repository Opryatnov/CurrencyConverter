import UIKit

final class FuelCalculatorViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 15
        static let tableViewContentInset: CGFloat = 20
    }
    
    // MARK: UI
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor(resource: .darkGray6)
        
        return tableView
    }()
    
    // MARK: Private properties
    
    private var fuelList: [Fuel]? = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .darkGray6)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.tableViewBottomInset)
            $0.bottom.equalToSuperview().inset((self.tabBarController?.tabBar.frame.height ?? .zero) + Constants.tableViewAdditionalInset)
        }
        tableView.contentInset.bottom = Constants.tableViewContentInset
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FuelCalculatorCell.self, forCellReuseIdentifier: FuelCalculatorCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkService.shared.fetchFuel { result in
            switch result {
            case .success(let fuelList):
                self.fuelList = fuelList
                self.tableView.reloadData()
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: Private methods
    
    private func showError(message: String?) {
        let closeAction = [
            UIAlertAction(title: LS("ALERT.CLOSE.BUTTON"), style: .cancel)
        ]
        showAlert(message: message, buttons: closeAction, viewController: self)
    }
}

// MARK: - UITableViewDelegate, - UITableViewDataSource

extension FuelCalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fuelList?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FuelCalculatorCell.identifier, for: indexPath) as? FuelCalculatorCell
        cell?.selectionStyle = .none
        if let fuel = fuelList?[indexPath.row] {
            cell?.fill(fuel: fuel)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let currency = currencies?[indexPath.row] {
//            currency.isSelected.toggle()
//            tableView.reloadData()
//        }
    }
}
