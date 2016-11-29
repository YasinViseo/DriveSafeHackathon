//
//  DriverTableViewCell.swift
//  DriveSafeHackathon
//
//  Created by YAK3579 on 28/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class DriverTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var pseudoLbl: UILabel!
    @IBOutlet weak var dateStartLbl: UILabel!
    @IBOutlet weak var dateEndLbl: UILabel!
    @IBOutlet weak var timeStartLbl: UILabel!
    @IBOutlet weak var timeEndLbl: UILabel!
    @IBOutlet weak var percentLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    
    
    
}
