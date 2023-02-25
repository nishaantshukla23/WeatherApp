//
//  CityDetailsCell.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import UIKit

class CityDetailsCell: UITableViewCell {

    @IBOutlet weak var stackViewCity: UIStackView!
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
