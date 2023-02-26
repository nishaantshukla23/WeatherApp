//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

struct CityListViewModel {
    private var cityList: [CityModel] = []
    var filteredCityList: [CityModel] = []
    var searchText: String = "" {
        didSet {
            filterCityList()
        }
    }
}

extension CityListViewModel {
    mutating func getCitiesWeatherData() {
        self.cityList = Bundle.main.decode(from: "weather")
        self.filteredCityList = self.cityList
       // self.cityList.removeSubrange(5...self.cityList.count-10)
      //  print(self.cityList)
        print(self.cityList.count)
    }
    
    private mutating func filterCityList() {
        if searchText.isEmpty {
            filteredCityList = cityList
        }else{
            filteredCityList = cityList.filter({
                ($0.city?.findname ?? "").contains(searchText.uppercased())
            })
        }
    }
    
}

extension CityListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.filteredCityList.count > 0 ? self.filteredCityList.count : 1
    }
    
    func shouldShowNoDataFoundCell() -> Bool {
        return self.filteredCityList.count > 0 ? false : true
    }
    
    func cityVMAtIndex(index: Int) -> CityViewModel {
        let cityVM = self.filteredCityList[index]
        return CityViewModel(cityModel: cityVM)
    }
    
}
