//
//  LogInViewController+UITextFieldDelegate.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

extension LogInViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailTextField {
			passwordTextField.becomeFirstResponder()
		} else if textField == passwordTextField {
			textField.resignFirstResponder()
			login(self)
		}
		
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		if textField == emailTextField {
			if textField.text?.isEmail() == false {
				textField.backgroundColor = UIColor.error()
				
				AlertGenerator.displayInfoAlert(title: nil,
				                                message: "Invalid email address") { [weak self] _ in
													guard let strongSelf = self else { return }
													
													strongSelf.emailTextField.becomeFirstResponder()
				}
				
				emailTextField.becomeFirstResponder()
			} else {
				textField.backgroundColor = UIColor.white
			}
		}
	}
	
}
