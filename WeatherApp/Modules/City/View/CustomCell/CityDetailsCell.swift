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
    
    
    func setUpData(cityVM: CityViewModel) {
        self.lblCity.text = cityVM.city
        self.lblCountry.text = cityVM.country
        self.lblTemperature.text = cityVM.temperature
        self.lblLatitude.text = cityVM.latitude
        self.lblLongitude.text = cityVM.longitude
    }

}
