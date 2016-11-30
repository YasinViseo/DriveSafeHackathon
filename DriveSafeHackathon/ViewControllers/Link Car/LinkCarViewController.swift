//
//  LinkCarViewController.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit
import Alamofire

class LinkCarViewController: UIViewController {

	@IBOutlet weak var vinTextField: UITextField!
	
	private var isWaiting = false
	private var drivers = [JSONDictionary]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		vinTextField.setLeftPadding(textFieldPadding)
		vinTextField.setRightPadding(textFieldPadding)
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		isWaiting = false
		
		vinTextField.text = testVIN
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Actions
	@IBAction func logOut(_ sender: Any) {
		AlertGenerator.displayConfirmationAlert(title: "Log out ?",
		                                        message: "Are you sure you want to log out?",
		                                        yesHandler: { [weak self] _ in
													guard let strongSelf = self else { return }
													
													// TODO: Call log out API
													
													
													strongSelf.dismiss(animated: true, completion: nil)
		},
		                                        noHandler: nil)
	}
	
	@IBAction func linkCar(_ sender: Any) {
		if isWaiting {
			return
		}
		
		let activityIndicatorView = ActivityIndicatorView()
		activityIndicatorView.show(onView: self.view)
		
		isWaiting = true
		
		let group = DispatchGroup()
		
		group.enter()
		
		linkCar() { result, error in
			group.leave()
		}
		
		group.enter()
		
		getDriversList() { [weak self] drivers, error in
			guard let strongSelf = self else { return }
			
			strongSelf.drivers = drivers
			
			group.leave()
		}
		
		group.notify(queue: DispatchQueue.main) { [weak self] in
			activityIndicatorView.hide()
			
			guard let strongSelf = self else { return }
			
			strongSelf.isWaiting = false
			
//			if strongSelf.drivers.count > 0 {
//				strongSelf.performSegue(withIdentifier: "tripsSegue", sender: strongSelf)
//			} else {
				strongSelf.performSegue(withIdentifier: "addDriverSegue", sender: strongSelf)
//			}
		}

	}
	
	func linkCar(completion: ((_ result: Bool, _ error: Error?) -> Void)?) {
		
		guard let vinText = vinTextField.text else {
			AlertGenerator.displayInfoAlert(title: nil,
			                                message: "Empty fields")
			
			return
		}
		
		let url = URL(string: serverURL + linkCarService)		
		let params = [ emailKey: testEmail, vinKey: vinText ]
		
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
				
				if let completion = completion {
					completion(true, nil)
				}
		}

	}
	
	func getDriversList(completion: ((_ drivers: [JSONDictionary], _ error: Error?) -> Void)?) {
		let url = URL(string: serverURL + kidsListService)
		let params = [ emailKey: testEmail]
		
		Alamofire
			.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default)
			.responseString { response in
				
				let result = response.result
				
				if (result.isFailure) {
					if let completion = completion {
						if let error = response.result.error {
							completion([], error)
						} else {
							completion([], nil)
						}
					}
					
					return
				}
				
				if let JSON = response.result.value {
					print("JSON: \(JSON)")
					
					guard let completion = completion else { return }
					
					if let dictionary = JSON.JSONStringToDictionary(),
						let kids = dictionary["kidList"] as? [JSONDictionary] {
							completion(kids, nil)
					} else {
						completion([], nil)
					}
				}
		}
	}
	
}
