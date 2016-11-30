//
//  AddDriverViewController.swift
//  DriveSafeHackathon
//
//  Created by YAK3579 on 30/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit
import Alamofire

class AddDriverViewController: UIViewController
    ,UITableViewDataSource,UITableViewDelegate

{

    @IBOutlet weak var tableview: UITableView!
    
    var listKids: Dictionary  = [String: Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let nib = UINib(nibName: "AddDriverTableViewCell", bundle: nil)
        tableview.register(nib, forHeaderFooterViewReuseIdentifier: "AddDriverTableViewCell")
        
        
        let nib2 = UINib(nibName: "CloseAddDriverTableViewCell", bundle: nil)
        tableview.register(nib2, forCellReuseIdentifier: "CloseAddDriverTableViewCell")
    
        let nib3 = UINib(nibName: "AddDriverButtonTableViewCell", bundle: nil)
        tableview.register(nib3, forCellReuseIdentifier: "AddDriverButtonTableViewCell")
        
    
        //tableview.reloadData()
        getAllKids()
    
    
    
    }

    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt")
        
        //if indexPath.row == 0{
            
        //}else if indexPath.row ==
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverTableViewCell", for: indexPath) as! DriverTableViewCell
     
        
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    /*
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
     print("viewForHeaderInSection")
     
     let cell = tableview.dequeueReusableHeaderFooterView(withIdentifier: "SectionTableViewHeaderFooterView") as! SectionTableViewHeaderFooterView
     
     return cell
     
     
     }
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 80
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        80
    }
    */
    
    
    
    
    
    func getAllKids(){
        
        let url = URL(string: serverURL + kidsListService)
        let params = ["email": testEmail]
        
        Alamofire
            .request(url!, method: .get, parameters: params, encoding: JSONEncoding.default)
            .responseString { response in
                
                let result = response.result
                
                if (result.isFailure) {
                    
                    return
                }
                
                if let JSON = response.result.value {
                    
                    
                    self.listKids = JSON.JSONStringToDictionary()!
                    
                    print("JSON: \(self.listKids)")
                    
                    
                }
        }
        
        
        
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
