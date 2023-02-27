//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

struct CityViewModel {
    
    private let cityModel: CityModel
    
    init(cityModel: CityModel) {
        self.cityModel = cityModel
    }
    
    var city: String {
        self.cityModel.city?.name ?? ""
    }
    
    var country: String {
        self.cityModel.city?.country ?? ""
    }
    
    var latitude: String {
        guard let lat = self.cityModel.city?.coord?.lat else { return "" }
        return "\(lat)"
    }
    
    var longitude: String {
        guard let long = self.cityModel.city?.coord?.lon else { return "" }
        return "\(long)"
    }
    
    var temperature: String {
        guard let temp = self.cityModel.main?.temp else { return "" }
        return "\(temp.formatAsDegree)"
    }

}
