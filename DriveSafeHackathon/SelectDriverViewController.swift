//
//  SelectDriverViewController.swift
//  DriveSafeHackathon
//
//  Created by YAK3579 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit
import Alamofire


class SelectDriverViewController: UIViewController
                            ,UITableViewDataSource,UITableViewDelegate
                            //,UICollectionViewDataSource,UICollectionViewDelegate
{

    
    @IBOutlet weak var driverNameScrollView: UIScrollView!

    //@IBOutlet weak var filtreCollectionView: UICollectionView!
    @IBOutlet weak var tripTableView: UITableView!
    
    var allTrips: Dictionary  = [String: Any?]()
	//    var reports: NSArray = [Dictionary]
	var selectedIndex = 0
    
    var drivers: [String] = ["All", "Unassigned", "Kevin", "Léa", "Marcel","Bernard"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.driveSafePink()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white]
        
        self.title = "TRIPS"
        
        let nib = UINib(nibName: "SectionTableViewHeaderFooterView", bundle: nil)
        tripTableView.register(nib, forHeaderFooterViewReuseIdentifier: "SectionTableViewHeaderFooterView")

        
        let nib2 = UINib(nibName: "DriverTableViewCell", bundle: nil)
        tripTableView.register(nib2, forCellReuseIdentifier: "DriverTableViewCell")
		
		tripTableView.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
		
        getAllTrip()
        
        loadDrivernameOnScrollView()
		
    }

	
    func loadDrivernameOnScrollView(){
        
        var i = 0
        
        for name in drivers {
            
            let btn: UIButton = UIButton(frame: CGRect(x: 100*i, y: 0, width: 100, height: 60))
            btn.backgroundColor = UIColor.white
            btn.setTitle(name, for: .normal)
            btn.addTarget(self, action: #selector(filtreByName(sender:)), for: .touchUpInside)
            btn.tag = i
            btn.setTitleColor(#colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), for: UIControlState.normal)
            
            driverNameScrollView.addSubview(btn)
			
            i += 1
        }
        
        driverNameScrollView.contentSize = CGSize(width:100*i, height:60)
		
        
    }
    
    
    func filtreByName(sender: UIButton!) {
        
        print("filtreByName \(sender)")
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            //do anything here
        }
    }

    func getAllTrip(){
        
        let url = URL(string: serverURL + reportService)
        let params = [String: String]()
		
		let activityIndicatorView = ActivityIndicatorView()
		activityIndicatorView.show(onView: self.view)
		
        Alamofire
            .request(url!, method: .get, parameters: params, encoding: JSONEncoding.default)
            .responseString { response in
				
				activityIndicatorView.hide()
                
                let result = response.result
                
                if (result.isFailure) {
                    
                    return
                }
                
                if let JSON = response.result.value {
                    
                    //print("JSON: \(JSON)")
                    
                    self.allTrips = JSON.JSONStringToDictionary()!
                    
                    let reports = self.allTrips["reports"] as! NSArray
                    
                    print(reports[0])
                    
                    self.tripTableView.reloadData()

                }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
		selectedIndex = indexPath.row
		performSegue(withIdentifier: "tripAnalysisSegue", sender: self)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier != "tripAnalysisSegue" { return }
		
		if let trips = self.allTrips["reports"] as? [JSONDictionary] {
			if segue.destination is TripAnalysisViewController {
				let tripAnalysisViewController = segue.destination as! TripAnalysisViewController
				tripAnalysisViewController.tripDictionary = trips[selectedIndex]
			}
		}
	}
	
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		//let reports = self.allTrips["reports"] as! NSArray

		
        return allTrips.count
    }

    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print("viewForHeaderInSection")
        
        let cell = tripTableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionTableViewHeaderFooterView") as! SectionTableViewHeaderFooterView
        cell.tripDayLbl.text = "date trip"
        
        return cell
        
        
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt")
        
        let reports = self.allTrips["reports"] as! NSArray
        var report = reports[indexPath.row] as! JSONDictionary//[String: Any?]()
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverTableViewCell", for: indexPath) as! DriverTableViewCell
        let finalScoreDict = report["finalScore"] as! JSONDictionary
		
        if let mark = finalScoreDict["mark"] as? Int {
            cell.percentLbl.text = String(mark) + "%"
		} else {
			cell.percentLbl.text = "N/A"
		}
		
		cell.percentLbl.backgroundColor = UIColor.driveSafeColor(string: finalScoreDict["color"] as? String)
        
        let trip = report["trip"] as! JSONDictionary
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
        
        
        let driver = report["driver"] as! JSONDictionary

        if let name = driver["name"] {
            
            if String(describing:name) == "Unknown driver"{
                
                cell.pseudoLbl.alpha = 0
                cell.avatarImgView.alpha = 0
                cell.addDriverBtn.alpha = 1
                
            }else{
                
                cell.pseudoLbl.text = String(describing:name)
			
                let url = URL(string: String(describing:driver["picUrl"]!))
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                cell.avatarImgView.image = UIImage(data: data!)
            }
		}
		
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
	
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
