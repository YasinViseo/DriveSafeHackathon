//
//  AddDriverViewController.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 29/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class AddDriverViewController: UIViewController {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var genderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var dismissButton: UIButton!
	@IBOutlet weak var removeButton: UIButton!
	
	internal let imagePickerController = UIImagePickerController()
	internal var didSelectProfileImage = false
	
	override func viewDidLoad() {
        super.viewDidLoad()

		imagePickerController.delegate = self
		imagePickerController.allowsEditing = false
		imagePickerController.sourceType = .photoLibrary
		
		nameTextField.setLeftPadding(textFieldPadding)
		nameTextField.setRightPadding(textFieldPadding)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
	@IBAction func addDriver(_ sender: Any) {
		guard let name = nameTextField.text, name.characters.count > 0 else { return }
		
		print("Should add \(name) as driver")
		
		// TODO: Call API to add driver (kid)
		
		performSegue(withIdentifier: "tripsSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "tripsSegue" && segue.destination is UINavigationController {
			let viewController = (segue.destination as? UINavigationController)?.topViewController
			
			if viewController is SelectDriverViewController {
				print("Should show trips")
			}
		}
	}
	
	@IBAction func selectProfilePhoto(_ sender: Any) {
		present(imagePickerController, animated: true, completion: nil)
	}
	
	@IBAction func selectGender(_ sender: Any) {
//		if genderSegmentedControl.selectedSegmentIndex == 0 {
//			genderSegmentedControl.tintColor = UIColor.driveSafeBlue()
//		} else {
//			genderSegmentedControl.tintColor = UIColor.driveSafePink()
//		}
		
		if !didSelectProfileImage {
			resetProfileImage(sender)
		}
	}
	
	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func resetProfileImage(_ sender: Any) {
		didSelectProfileImage = false
		removeButton.isHidden = true
		profileImageView.contentMode = .scaleAspectFit
		
		if genderSegmentedControl.selectedSegmentIndex == 0 {
			profileImageView.image = UIImage(named: "profile_boy")
//			profileImageView.backgroundColor = UIColor.driveSafeBlue()
		} else {
			profileImageView.image = UIImage(named: "profile_girl")
//			profileImageView.backgroundColor = UIColor.driveSafePink()
		}
	}
	
}
