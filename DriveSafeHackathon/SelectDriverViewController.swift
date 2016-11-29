//
//  SelectDriverViewController.swift
//  DriveSafeHackathon
//
//  Created by YAK3579 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class SelectDriverViewController: UIViewController
                            ,UITableViewDataSource,UITableViewDelegate
                            ,UICollectionViewDataSource,UICollectionViewDelegate{

    
    
    @IBOutlet weak var filtreCollectionView: UICollectionView!
    @IBOutlet weak var tripTableView: UITableView!
    
    var drivers: [String] = ["All", "Unassigned", "Kevin", "Léa", "Marcel"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        
        
        //let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = UICollectionViewScrollDirection.vertical
        //filtreCollectionView.collectionViewLayout = layout
        
        
        let nib = UINib(nibName: "SectionTableViewHeaderFooterView", bundle: nil)
        tripTableView.register(nib, forHeaderFooterViewReuseIdentifier: "SectionTableViewHeaderFooterView")

        
        let nib2 = UINib(nibName: "DriverTableViewCell", bundle: nil)
        tripTableView.register(nib2, forCellReuseIdentifier: "DriverTableViewCell")
        

        filtreCollectionView.reloadData()
        tripTableView.reloadData()
        
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print("viewForHeaderInSection")
        
        
        let cell = tripTableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionTableViewHeaderFooterView") as! SectionTableViewHeaderFooterView
        cell.tripDayLbl.text = "date trip"
        
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCell", for: indexPath) as! SectionTableViewCell

        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCell") as! SectionTableViewCell
        
        //cell.backgroundColor = UIColor.blue
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverTableViewCell", for: indexPath) as! DriverTableViewCell
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("cellFornumberOfItemsInSectionRowAt \(drivers.count)")

        return drivers.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("UICollectionView cellForItemAt")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DriverName",for: indexPath) as! DriverNameCollectionViewCell
        
        cell.backgroundColor = UIColor.black
        
        return cell
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
