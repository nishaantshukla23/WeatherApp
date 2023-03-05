//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

protocol CityListViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    var searchText: String { get set }
    
    func fetchCitiesWeatherData()
    func numberOfRowsInSection(_ section: Int) -> Int
    func getCellType() -> TableViewCell
    func cityVMAtIndex(index: Int) -> CityViewModel?
}

class CityListViewModel: CityListViewModelProtocol {
    private var citiesWeatherService: WeatherServiceProtocol
    private let cityListQueue = DispatchQueue(label: "cityListQueue", attributes: .concurrent)
    private var cityList: [CityModel] = []
    private var workItem: DispatchWorkItem?
    private(set) var filteredCityList: [CityModel] = [] {
        didSet{
            reloadTableView?()
        }
    }
    var reloadTableView: (() -> Void)?

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
     func fetchCitiesWeatherData() {
        self.citiesWeatherService.getCitiesWeatherData(completion: { [weak self] result in
            switch result {
            case .success(let citiesWeatherList):
                self?.cityList = citiesWeatherList
                self?.filteredCityList = self?.cityList ?? []
            case .failure(let error):
                print(error)
            }
        })
    }
    
    /**
     This is method to filter fetched cities weather data as per Serach query.
     */
    
    private func filterCityList() {
        if searchText.isEmpty {
            cityListQueue.async(flags: .barrier) { [weak self] in
                self?.filteredCityList = self?.cityList ?? []
            }
        } else {
            
            // Cancel the previous work item if it's still executing and create a new one
            workItem?.cancel()
            
            workItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                let result = self.cityList.filter {
                    ($0.city?.findname ?? "").contains(self.searchText.uppercased())
                }
                self.cityListQueue.async(flags: .barrier) {
                    self.filteredCityList = result
                }
            }
            
            if let searchOperation = self.workItem {
                cityListQueue.async(execute: searchOperation)
            }
        }
    }
    
}

extension CityListViewModel {
    
    /**
     Method to provide number of rows in tableView section.
     */
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.filteredCityList.count > 0 ? self.filteredCityList.count : 1
    }
    
    /**
     Method to provide type of tableView cell.
     */
    func getCellType() -> TableViewCell {
        return self.filteredCityList.count > 0 ? .cityDataCell : .noDataCell
    }
    
    /**
     Method to convert Network Model to UI ViewModel Object. Used to populate data on cell.
     
     - Parameters:
       - index: pass integer value to get CityViewModel from Network Model array i.e. [CityModel]
     */
    func cityVMAtIndex(index: Int) -> CityViewModel? {
        return self.filteredCityList.count > index ? CityViewModel(cityModel: self.filteredCityList[index]) : nil
    }
    
}
