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
	private let driverCell = "DriverTableViewCell"
	
	var tripDictionary = JSONDictionary()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let cellNib = UINib(nibName: tripInfoCell, bundle: nil)
		tableView.register(cellNib, forCellReuseIdentifier: tripInfoCell)
		
		let driverCellNib = UINib(nibName: driverCell, bundle: nil)
		tableView.register(driverCellNib, forCellReuseIdentifier: driverCell)
		
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
			return 80
		} else {
			return 220
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// 1st section: Overall result
		if indexPath.section == 0 {
			var cell: DriverTableViewCell
			
			if let reusedCell = tableView.dequeueReusableCell(withIdentifier: driverCell) as? DriverTableViewCell {
				cell = reusedCell
			} else {
				cell = DriverTableViewCell()
			}
			
			configureDriverCell(cell)
			
			return cell
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

	func configureDriverCell(_ cell: DriverTableViewCell) {
		let finalScoreDict = tripDictionary["finalScore"] as! JSONDictionary
		
		if let mark = finalScoreDict["mark"] as? Int {
			cell.percentLbl.text = String(mark) + "%"
		} else {
			cell.percentLbl.text = "N/A"
		}
		
		cell.percentLbl.backgroundColor = UIColor.driveSafeColor(string: finalScoreDict["color"] as? String)
		
		let trip = tripDictionary["trip"] as! JSONDictionary
		let startDate = trip["startDate"] as! JSONDictionary
		let endDate = trip["endDate"] as! JSONDictionary
		
		let dateEnd = String(describing:endDate["dayOfMonth"]!)+"."+String(describing:endDate["monthValue"]!)+"."+String(describing:endDate["year"]!)
		cell.dateEndLbl.text = dateEnd
		
		let timeEnd = String(describing:endDate["minute"]!)+":"+String(describing:endDate["hour"]!)
		cell.timeEndLbl.text = timeEnd
		
		let dateStart = String(describing:startDate["dayOfMonth"]!)+"."+String(describing:startDate["monthValue"]!)+"."+String(describing:startDate["year"]!)
		cell.dateStartLbl.text = dateStart
		
		let timeStart = String(describing:endDate["minute"]!)+":"+String(describing:endDate["hour"]!)
		cell.timeStartLbl.text = timeStart
		
		let driver = tripDictionary["driver"] as! JSONDictionary
		
		if let name = driver["name"] {
			
			if String(describing:name) == "Unknown driver"{
				
				cell.pseudoLbl.alpha = 0
				cell.avatarImgView.alpha = 0
				cell.addDriverBtn.alpha = 1
				
			}else{
				
				cell.pseudoLbl.text = String(describing:name)
				
				let url = URL(string: String(describing:driver["picUrl"]!))
				let data = try? Data(contentsOf: url!)
				cell.avatarImgView.image = UIImage(data: data!)
			}
		}
	}
	
}
