//
//  TripAnalysisViewController.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 29/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class TripAnalysisViewController: UITableViewController {

	private let tripInfoCell = "TripAnalysisCell"
	var tripDictionary = JSONDictionary()
	var driverResultDictionary = JSONDictionary()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let cellNib = UINib(nibName: tripInfoCell, bundle: nil)
		tableView.register(cellNib, forCellReuseIdentifier: tripInfoCell)
		
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationController?.navigationBar.barTintColor = UIColor.driveSafePink()
		navigationController?.navigationBar.tintColor = UIColor.white
		navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white]
		
		title = "TRIP ANALYSIS"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - UITableViewDataSource
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 5
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 78
		} else {
			return 220
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// 1st section: Overall result
		if indexPath.section == 0 {
			return DriverTableViewCell()		// bad name
		}
		
		// Other sections : Details
		var cell: TripAnalysisCell
		
		if let reusedCell = tableView.dequeueReusableCell(withIdentifier: tripInfoCell) as? TripAnalysisCell {
			cell = reusedCell
		} else {
			cell = TripAnalysisCell()
		}
		
		cell.configure(forSection: indexPath.section, withData: tripDictionary)
		
		return cell
	}

}
