//
//  SignUpViewController.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		nameTextField.setLeftPadding(textFieldPadding)
		nameTextField.setRightPadding(textFieldPadding)
		
		emailTextField.setLeftPadding(textFieldPadding)
		emailTextField.setRightPadding(textFieldPadding)
		
		passwordTextField.setLeftPadding(textFieldPadding)
		passwordTextField.setRightPadding(textFieldPadding)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: - Actions
	
	@IBAction func signUp(_ sender: Any) {
		print("Should call signUp API")
		
		
	}
	
	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true) {
			
		}
	}

}
