//
//  CityListViewModelTest.swift
//  WeatherAppTests
//
//  Created by N Shukla on 27/02/23.
//

import XCTest
@testable import WeatherApp

struct MockWeatherService: WeatherServiceProtocol {

    func getCitiesWeatherData(completion: @escaping (Result<[WeatherApp.CityModel], WeatherApp.ServiceError>) -> Void) {
                   
            let result: [CityModel] = [CityModel(city: City(id: 1, name: "Pune", findname: "PUNE", country: "IN", coord: Coord(lon: 1, lat: 1), zoom: 1), time: 1, main: Main(temp: 1, pressure: 1, humidity: 1, tempMin: 1, tempMax: 1, seaLevel: 1, grndLevel: 1), wind: Wind(speed: 1, deg: 1, varBeg: 1, varEnd: 1), clouds: Clouds(all: 1), weather: [Weather(id: 1, main: "main1", description: "description1", icon: "icon1")], rain: Rain(the3H: 1)),
               CityModel(city: City(id: 2, name: "Mumbai", findname: "MUMBAI", country: "India", coord: Coord(lon: 2, lat: 2), zoom: 2), time: 2, main: Main(temp: 2, pressure: 2, humidity: 2, tempMin: 2, tempMax: 2, seaLevel: 2, grndLevel: 2), wind: Wind(speed: 2, deg: 2, varBeg: 2, varEnd: 2), clouds: Clouds(all: 2), weather: [Weather(id: 2, main: "main2", description: "description2", icon: "icon2")], rain: Rain(the3H: 2))
            ]
            completion(.success(result))
    
    }

}

final class CityListViewModelTest: XCTestCase {

    var cityListVM: CityListViewModel!
    var mockService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        cityListVM = CityListViewModel(citiesWeatherService: mockService)
        cityListVM.fetchCitiesWeatherData()
    }
    
    override func tearDown() {
        super.tearDown()
        cityListVM = nil
        mockService = nil
    }
    
    func test_fetchCitiesWeatherData_shouldReturn_Success() {
            // given
            let expectation = XCTestExpectation(description: "Cities weather data should be fetched")
            cityListVM.reloadTableView = {
                expectation.fulfill()
            }
            // when
            cityListVM.fetchCitiesWeatherData()
            // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.numberOfRowsInSection(0), 2, "Number of rows should match the count of cityList")
        XCTAssertEqual(cityListVM.filteredCityList.count, 2, "filteredCityList should contain all cityList data initially")
        }
    
    
    func test_filterCityList_ForSearchText_Mum_ShouldReturn_Mumbai() {
        // given
        let expectation = XCTestExpectation(description: "data should be fetched & reload should be called.")
        cityListVM.fetchCitiesWeatherData()

        cityListVM.reloadTableView = {
            expectation.fulfill()
        }
        // when
        cityListVM.searchText = "Mum"
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.filteredCityList.count, 1, "filteredCityList should contain 1 city for search query 'Mum'")
        let cityModel = cityListVM.filteredCityList[0]
        XCTAssertEqual(cityModel.city?.name, "Mumbai", "CityViewModel cityName should match the CityModel name")

    }
    
    func test_filterCityList_ForSearchText_Pu_ShouldReturn_Pune() {
        // given
        let expectation = XCTestExpectation(description: "data should be fetched & reload should be called.")
        cityListVM.fetchCitiesWeatherData()

        cityListVM.reloadTableView = {
            expectation.fulfill()
        }
        // when
        cityListVM.searchText = "Pu"
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.filteredCityList.count, 1, "filteredCityList should contain 1 city for search query 'Pu'")
        let cityModel = cityListVM.filteredCityList[0]
        XCTAssertEqual(cityModel.city?.name, "Pune", "CityViewModel cityName should match the CityModel name")

    }
    
    func test_filterCityList_ForSearchText_EmptyString_ShouldReturn_Pune() {
        // given
        let expectation = XCTestExpectation(description: "data should be fetched & reload should be called.")
        cityListVM.fetchCitiesWeatherData()

        cityListVM.reloadTableView = {
            expectation.fulfill()
        }
        // when
        cityListVM.searchText = ""
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.filteredCityList.count, 2, "filteredCityList should contain 1 city for search query ''")
        let cityModelForPune = cityListVM.filteredCityList[0]
        XCTAssertEqual(cityModelForPune.city?.name, "Pune", "CityViewModel cityName should match the CityModel name")
        let cityModelForMumbai = cityListVM.filteredCityList[1]
        XCTAssertEqual(cityModelForMumbai.city?.name, "Mumbai", "CityViewModel cityName should match the CityModel name")

    }
    
    func test_filterCityList_ForSearchText_InvalidString_ShouldReturn_ZeroCount() {
        // given
        let expectation = XCTestExpectation(description: "data should be fetched & reload should be called.")
        cityListVM.fetchCitiesWeatherData()

        cityListVM.reloadTableView = {
            expectation.fulfill()
        }
        // when
        cityListVM.searchText = "ABC123"
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.filteredCityList.count, 0, "filteredCityList should return 0 object.")

    }
    
    func test_cityVMAtIndex_ShouldReturn_Pune() {
        // given
        cityListVM.fetchCitiesWeatherData()
        // when
        let cityVM = cityListVM.cityVMAtIndex(index: 0)
        // then
        XCTAssertNotNil(cityVM, "CityViewModel should not be nil for index 0")
        XCTAssertEqual(cityVM?.city, "Pune", "CityViewModel cityName should match the CityModel name")
    }
    
    func test_cityVMAtIndex_ShouldReturn_Mumbai() {
        // given
        cityListVM.fetchCitiesWeatherData()
        // when
        let cityVM = cityListVM.cityVMAtIndex(index: 1)
        // then
        XCTAssertNotNil(cityVM, "CityViewModel should not be nil for index 1")
        XCTAssertEqual(cityVM?.city, "Mumbai", "CityViewModel cityName should match the CityModel name")
    }
    
    func test_cityVMAtIndex_ShouldReturn_Nil() {
        // given
        cityListVM.fetchCitiesWeatherData()
        // when
        let cityVM = cityListVM.cityVMAtIndex(index: 5)
        // then
        XCTAssertNil(cityVM, "CityViewModel should be nil for index 5")
    }
        
    func testGetCellType_ShouldReturn_NODataInfoCell() {
        // given
        let expectation = XCTestExpectation(description: "data should be fetched & reload should be called.")
        cityListVM.fetchCitiesWeatherData()

        cityListVM.reloadTableView = {
            expectation.fulfill()
        }
        // when
        cityListVM.searchText = "ABC123"
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.filteredCityList.count, 0, "filteredCityList should return 0 object.")
        let tableCellType = cityListVM.getCellType()
        XCTAssertEqual(TableViewCell.noDataCell, tableCellType, "filteredCityList should return 'noDataInfoCell'")
    }
    
    func testGetCellType_ShouldReturn_cityDataCell() {
        // given
        let expectation = XCTestExpectation(description: "data should be fetched & reload should be called.")
        cityListVM.fetchCitiesWeatherData()

        cityListVM.reloadTableView = {
            expectation.fulfill()
        }
        // when
        cityListVM.searchText = "Pu"
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(cityListVM.filteredCityList.count, 1, "filteredCityList should return 0 object.")
        let tableCellType = cityListVM.getCellType()
        XCTAssertEqual(TableViewCell.cityDataCell, tableCellType, "filteredCityList should return 'CityDataCell'.")

    }
}
