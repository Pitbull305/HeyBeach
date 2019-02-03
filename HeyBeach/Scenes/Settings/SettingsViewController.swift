//
//  SettingsViewController.swift
//  HeyBeach
//

import UIKit

protocol SettingsViewControllerIn {
    func handleLogoutSuccess()
    func displayLogoutErrorMessage(_ viewModel: SettingsModel.Logout.ViewModel.Failure)
}

protocol SettingsViewControllerOut {
    func logout()
}

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var output: SettingsViewControllerOut?
    private let configurator = SettingsConfigurator()
    private let rowHeight: CGFloat = 64
    private let settings = ["Logout"]
    
    // MARK: - UIViewController
    override func awakeFromNib() {
        super.awakeFromNib()
        configurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    private func logout() {
        activityIndicator.isHidden = false
        output?.logout()
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ heightForRowAttableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            logout()
        default:
            break
        }
    }
}

// MARK: - SettingsViewControllerIn
extension SettingsViewController: SettingsViewControllerIn {
    func handleLogoutSuccess() {
        activityIndicator.isHidden = true
        performSegue(withIdentifier: "Settings-Authentication-Segue", sender: self)
    }
    
    func displayLogoutErrorMessage(_ viewModel: SettingsModel.Logout.ViewModel.Failure) {
        activityIndicator.isHidden = true
        let alertController = UIAlertController(title: "", message: viewModel.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
