//
//  AuthenticationViewController.swift
//  HeyBeach
//

import UIKit

protocol AuthenticationViewControllerIn {
    func handleSignUpSuccess()
}

protocol AuthenticationViewControllerOut {
    func signUp(_ request: AuthenticationModel.SignUp.Request)
}

class AuthenticationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var textField_email: UITextField!
    @IBOutlet weak var textField_password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var output: AuthenticationViewControllerOut?
    private let configurator = AuthenticationConfigurator()
    
    // MARK: - UIViewController
    override func awakeFromNib() {
        super.awakeFromNib()
        configurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func tapped_on_main_view(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func button_signIn_touchUpInside(_ sender: Any) {
    }
    
    @IBAction func button_signUp_touchUpInside(_ sender: Any) {
        guard let email = textField_email.text, email != "", let password = textField_password.text, password != "" else { return }
        activityIndicator.isHidden = false
        let request = AuthenticationModel.SignUp.Request(email: email, password: password)
        output?.signUp(request)
    }
}

// MARK: - AuthenticationViewControllerIn
extension AuthenticationViewController: AuthenticationViewControllerIn {
    func handleSignUpSuccess() {
        activityIndicator.isHidden = true
        performSegue(withIdentifier: "Authentication-TabBar-Segue", sender: self)
    }
}
