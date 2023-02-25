//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

struct CityListViewModel {
    var cityList: [CityModel]
    init() {
        self.cityList = [CityModel]()
    }
}

extension CityListViewModel {
    mutating func getCitiesWeatherData() {
        self.cityList = Bundle.main.decode(from: "weather")
        self.cityList.removeSubrange(5...self.cityList.count-10)
        print(self.cityList)
        print(self.cityList.count)
    }
}

extension CityListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.cityList.count
    }
    
    func cityVMAtIndex(index: Int) -> CityViewModel {
        let cityVM = self.cityList[index]
        return CityViewModel(cityModel: cityVM)
    }
    
}
