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
		guard let name = nameTextField.text else { return }
		
		print("Should add \(name) as driver")
		
		// TODO: Call API to add driver (kid)
		// Test TripAnalysis
		let tripAnalysisViewController = TripAnalysisViewController()
		
		let tripString = "{\"tripDuration\":53,\"lateralAccelerationScore\":{\"mark\":82,\"color\":\"GREEN\",\"commentTitle\":\"Normal lateral accelerations\",\"commentBody\":\"Awesome. Your kid drives normally. You can sleep well.\"},\"accelerationScore\":{\"mark\":42,\"color\":\"RED\",\"commentTitle\":\"Multiple violent accelerations\",\"commentBody\":\"This kind of accelerations is bad for your engine, the integrity of your car and the life of your kid. You two should have a talk.\"},\"brakeScore\":{\"mark\":0,\"color\":\"RED\",\"commentTitle\":\"Severe brake use\",\"commentBody\":\"Driving as a rallye pilot on public open traffic road is a major cause of accident and may induce death.\"},\"speedScore\":{\"mark\":71,\"color\":\"YELLOW\",\"commentTitle\":\"Excessive speeding\",\"commentBody\":\"High speeding increase risks of accident, car consumption and don't really reduce the time of a trip. Even your kid could understand that.\"},\"finalScore\":{\"mark\":53,\"color\":\"RED\",\"commentTitle\":\"\",\"commentBody\":\"\"},\"trip\":{\"start\":\"2016-11-28 08:12\",\"end\":\"2016-11-28 09:05\",\"startDate\":{\"dayOfYear\":333,\"dayOfWeek\":\"MONDAY\",\"month\":\"NOVEMBER\",\"dayOfMonth\":28,\"year\":2016,\"monthValue\":11,\"hour\":8,\"minute\":12,\"second\":0,\"nano\":0,\"chronology\":{\"calendarType\":\"iso8601\",\"id\":\"ISO\"}},\"endDate\":{\"dayOfYear\":333,\"dayOfWeek\":\"MONDAY\",\"month\":\"NOVEMBER\",\"dayOfMonth\":28,\"year\":2016,\"monthValue\":11,\"hour\":9,\"minute\":5,\"second\":0,\"nano\":0,\"chronology\":{\"calendarType\":\"iso8601\",\"id\":\"ISO\"}},\"distance\":24,\"totalBrakeUse\":140,\"excessiveBrakeUse\":22,\"violentBrakeUse\":24,\"totalAccelerations\":125,\"excessiveAccelerations\":30,\"violentAccelerations\":3,\"totalLateralAccelerations\":60,\"excessiveLateralAccelerations\":4,\"violentLateralAccelerations\":0,\"lightSpeedLimitViolationTime\":7,\"mediumSpeedLimitViolationTime\":1,\"severeSpeedLimitViolationTime\":0,\"duration\":53}}"
		
		tripAnalysisViewController.tripDictionary = tripString.JSONStringToDictionary()!
		
		present(tripAnalysisViewController, animated: true)
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
