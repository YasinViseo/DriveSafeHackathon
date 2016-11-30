//
//  TripAnalysisCell.swift
//  DriveSafeHackathon
//
//  Created by lng3578 on 29/11/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class TripAnalysisCell: UITableViewCell {

	@IBOutlet weak var categoryImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var advicesButton: UIButton!
	@IBOutlet weak var arrowImageView: UIImageView!
	@IBOutlet weak var commentTitleLabel: UILabel!
	@IBOutlet weak var commentBodyLabel: UILabel!
	@IBOutlet weak var bubbleImageView: UIImageView!
	@IBOutlet weak var advisorImageView: UIImageView!
	@IBOutlet weak var containerView: UIView!
	
	private var areAdviceHidden = false
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(forSection section: Int, withData dictionary: JSONDictionary) {
		
		switch section {
		case 1:
			categoryImageView.image = UIImage(named:"brakes")
			nameLabel.text = "Use of brakes"
			
			setResult(data: dictionary["brakeScore"] as? JSONDictionary)
			
			break
		case 2:
			categoryImageView.image = UIImage(named:"acceleration")
			nameLabel.text = "Accelerations"
			
			setResult(data: dictionary["accelerationScore"] as? JSONDictionary)
			
			break
		case 3:
			categoryImageView.image = UIImage(named:"lateral_acceleration")
			nameLabel.text = "Lateral accelerations"
			
			setResult(data: dictionary["lateralAccelerationScore"] as? JSONDictionary)
			
			break
		case 4:
			categoryImageView.image = UIImage(named:"speed")
			nameLabel.text = "Speed limit"
			
			setResult(data: dictionary["speedScore"] as? JSONDictionary)
			
			break
		default:
			break
		}
	}
	
	func setResult(data: JSONDictionary?) {
		guard let data = data else {
			resultLabel.text = "N/A"
			resultLabel.backgroundColor = UIColor.gray
			
			commentTitleLabel.isHidden = true
			commentBodyLabel.isHidden = true
			
			return
		}
		
		if let mark = data["mark"] as? Int {
			resultLabel.text = String(mark) + "%"
		} else {
			resultLabel.text = "N/A"
		}
		
		resultLabel.backgroundColor = colorFromString(data["color"] as? String)
		
		if let title = data["commentTitle"] as? String {
			commentTitleLabel.isHidden = false
			commentTitleLabel.text = title
		} else {
			commentTitleLabel.isHidden = true
		}
		
		if let body = data["commentBody"] as? String {
			commentBodyLabel.isHidden = false
			commentBodyLabel.text = body
		} else {
			commentBodyLabel.isHidden = false
		}
		
		advicesButton.isHidden = commentTitleLabel.isHidden && commentBodyLabel.isHidden
	}
	
	func colorFromString(_ color: String?) -> UIColor {
		guard let color = color else { return UIColor.gray }
		
		switch color {
		case "YELLOW": return UIColor(red: 232.0/255.0, green: 215.0/255.0, blue: 22.0/255.0, alpha: 1.0)
		case "RED": return UIColor(red: 216.0/255.0, green: 47.0/255.0, blue: 44.0/255.0, alpha: 1.0)
		case "GREEN": return UIColor(red: 67.0/255.0, green: 207.0/255.0, blue: 35.0/255.0, alpha: 1.0)
		default: return UIColor.gray
		}
	}
	
	@IBAction func toggleAdvices(_ sender: Any) {
		areAdviceHidden = !areAdviceHidden
		
		commentBodyLabel.isHidden = areAdviceHidden
		commentTitleLabel.isHidden = areAdviceHidden
		advisorImageView.isHidden = areAdviceHidden
		bubbleImageView.isHidden = areAdviceHidden
		
		if areAdviceHidden {
			arrowImageView.image = UIImage(named: "down")
			advicesButton.setTitle("Show advices", for: .normal)
		} else {
			arrowImageView.image = UIImage(named: "up")
			advicesButton.setTitle("Hide advices", for: .normal)
		}
	}
}
