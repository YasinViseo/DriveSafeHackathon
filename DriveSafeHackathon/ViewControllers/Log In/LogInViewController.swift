//
//  LogInViewController.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController {

	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	private var isWaiting = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.setNavigationBarHidden(true, animated: false)
        
		emailTextField.setLeftPadding(textFieldPadding)
		emailTextField.setRightPadding(textFieldPadding)
		
		passwordTextField.setLeftPadding(textFieldPadding)
		passwordTextField.setRightPadding(textFieldPadding)
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		isWaiting = false
		
		emailTextField.text = testEmail
		passwordTextField.text = testPassword
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Actions
	
	@IBAction func loginWithFacebook(_ sender: Any) {
		print("Should log in using Facebook")
	}
	
	@IBAction func login(_ sender: Any) {
		if isWaiting {
			return
		}
		
		// If empty fields
		if (emailTextField.text == "") || (passwordTextField.text == "") {
			
			AlertGenerator.displayInfoAlert(title: nil,
			                                message: "Empty fields")
			
			return
		}
		
		// If email is invalid
		if emailTextField.text?.isEmail() == false {
			
			AlertGenerator.displayInfoAlert(title: nil,
			                                message: "Invalid email address")
			
			return
		}
		
		// Login
		let activityIndicatorView = ActivityIndicatorView()
		activityIndicatorView.show(onView: self.view)
		
		isWaiting = true
		
		login(name: emailTextField.text!, password: passwordTextField.text!) { [weak self] success, error in
			activityIndicatorView.hide()
			
			guard let strongSelf = self else { return }
			
			strongSelf.isWaiting = false
			
			if success {
				strongSelf.performSegue(withIdentifier: "addCarSegue", sender: strongSelf)
			} else {
				AlertGenerator.displayInfoAlert(title: nil,
				                                message: "Failed to log in")
			}
			
		}
	}
	
	@IBAction func recoverPassword(_ sender: Any) {
		print("Should allow to recover the user password")
	}
	
	func login(name: String, password: String, completion: ((_ success: Bool, _ error: Error?) -> Void)?) {
		
		let url = URL(string: serverURL + loginService)
		let params = [ loginKey: name, passwordKey: password]
		
		Alamofire
			.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default)
			.responseString { response in
				
				let result = response.result
				
				if (result.isFailure) {
					if let completion = completion {
						if let error = response.result.error {
							completion(false, error)
						} else {
							completion(false, nil)
						}
					}
					
					return
				}
				
				if let JSON = response.result.value {
					print("JSON: \(JSON)")
					
					if let completion = completion {
						completion(true, nil)
					}
				}
		}
	}
	
}
