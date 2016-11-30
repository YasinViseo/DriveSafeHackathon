//
//  AddDriverTableViewCell.swift
//  DriveSafeHackathon
//
//  Created by YAK3579 on 30/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class AddDriverTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var prenomLbl: UILabel!
    @IBOutlet weak var assignLbl: UILabel!
    
    @IBOutlet weak var excludeFromAnalysisLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
