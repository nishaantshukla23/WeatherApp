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
}

extension CityViewModel {
    
    var city: String {
        guard let city = self.cityModel.city?.name else { return "" }
        return city
    }
    
    var country: String {
        guard let country = self.cityModel.city?.country else { return "" }
        return country
    }
    
    var temperature: String {
        guard let temp = self.cityModel.main?.temp else { return "" }
        return "\(temp)"
    }
    
    var latitude: String {
        guard let lat = self.cityModel.city?.coord?.lat else { return "" }
        return "\(lat)"
    }
    
    var longitude: String {
        guard let long = self.cityModel.city?.coord?.lon else { return "" }
        return "\(long)"
    }
}
