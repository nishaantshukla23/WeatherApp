//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

class CityListViewModel {
    private var citiesWeatherService: WeatherServiceProtocol
    var reloadTableView: (() -> Void)?
    private var cityList: [CityModel] = []
    var filteredCityList: [CityModel] = [] {
        didSet{
            reloadTableView?()
        }
    }
    var searchText: String = "" {
        didSet {
            filterCityList()
        }
    }
    
    init(citiesWeatherService: WeatherServiceProtocol = WeatherService()) {
        self.citiesWeatherService = citiesWeatherService
    }
}

extension CityListViewModel {
    
    /**
     This is method to fetch weather data for all Cities.
     
     */
     func getCitiesWeatherData() {
        self.citiesWeatherService.getCitiesWeatherData(completion: { result in
            switch result {
            case .success(let citiesWeatherList):
                self.cityList = citiesWeatherList
                self.filteredCityList = self.cityList
            case .failure(let error):
                print(error)
            }
        })
        print(self.cityList.count)
    }
    
    /**
     This is method to filter fetched cities weather data as per Serach query.
     */
    private func filterCityList() {
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
    
    /**
     Method to convert Network Model to UI ViewModel Object. Used to populate data on cell.
     
     - Parameters:
       - index: pass integer value to get CityViewModel from Network Model array i.e. [CityModel]
     */
    func cityVMAtIndex(index: Int) -> CityViewModel {
        let cityVM = self.filteredCityList[index]
        return CityViewModel(cityModel: cityVM)
    }
    
}
