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
    var reports: NSArray = []
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
        
        

        getAllTrip()
        
        loadDrivernameOnScrollView()
		
    }

	
    func loadDrivernameOnScrollView(){
        
        var i = 0
        
        for name in drivers {
            
            let btn: UIButton = UIButton(frame: CGRect(x: 100*i, y: -60, width: 100, height: 60))
            btn.backgroundColor = hexStringToUIColor(hex:"FFFFFF")
            btn.setTitle(name, for: .normal)
            btn.addTarget(self, action: #selector(filtreByName(sender:)), for: .touchUpInside)
            btn.tag = i
            btn.setTitleColor(#colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), for: UIControlState.normal)
            
            driverNameScrollView.addSubview(btn)
            
            
            i += 1
        }
        
        print(driverNameScrollView.contentSize.height)
        driverNameScrollView.contentSize = CGSize(width:100*i, height:0)
		
        
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
        
        Alamofire
            .request(url!, method: .get, parameters: params, encoding: JSONEncoding.default)
            .responseString { response in
                
                let result = response.result
                
                if (result.isFailure) {
                    
                    return
                }
                
                if let JSON = response.result.value {
                    
                    //print("JSON: \(JSON)")
                    
                    self.allTrips = JSON.JSONStringToDictionary()!
                    
                    self.reports = self.allTrips["reports"] as! NSArray
                    
                    print(self.reports[0])
                    print(self.reports.count)
                    
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
			
//			let viewController = (segue.destination as? UINavigationController)?.topViewController
			
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

		
        return reports.count
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
        let finalScore = report["finalScore"] as! JSONDictionary
        
        cell.percentLbl.text = "00"
        
        if let mark = finalScore["mark"] as? Int {
            
            cell.percentLbl.text = String(mark)+"%"
        }
        
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
        
        if String(describing:finalScore["color"]!) == "YELLOW"{
            cell.percentLbl.backgroundColor = #colorLiteral(red: 1, green: 0.8002882004, blue: 0.004029067233, alpha: 1)
        }else if String(describing:finalScore["color"]!) == "RED"{
            cell.percentLbl.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }else if String(describing:finalScore["color"]!) == "GREEN"{
            cell.percentLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
	
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
