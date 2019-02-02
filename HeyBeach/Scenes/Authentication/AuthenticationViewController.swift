//
//  AuthenticationViewController.swift
//  HeyBeach
//

import UIKit

class AuthenticationViewController: UIViewController {

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func tapped_on_main_view(_ sender: Any) {
        self.view.endEditing(true)
    }
}
