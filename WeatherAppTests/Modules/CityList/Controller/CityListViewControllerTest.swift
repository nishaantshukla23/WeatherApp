//
//  CityListViewControllerTest.swift
//  WeatherAppTests
//
//  Created by N Shukla on 27/02/23.
//

import XCTest
@testable import WeatherApp

class CityListViewControllerTest: XCTestCase {
    
    var sut: CityListViewController!
    var mockCityListVM: MockCityListViewModel!
    
    override func setUp() {
        super.setUp()
        mockCityListVM = MockCityListViewModel()
        sut = CityListViewControllerFactory.createCityListViewController(cityListVM: mockCityListVM)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockCityListVM = nil
        super.tearDown()
    }
    
    func testViewController_WhenLoaded_ShouldHave_TableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testViewController_WhenLoaded_ShouldHave_SearchBar() {
        XCTAssertNotNil(sut.searchBar)
    }
    
    func testViewController_WhenLoaded_FetchesCitiesWeatherRecords() {
        XCTAssertTrue(mockCityListVM.isFetchCitiesWeatherDataCalled)
    }
    
    func testTableView_NumberOfRowsInSection_ShouldReturn_CorrectNumberOfRows() {
        //given
        mockCityListVM.numberOfRowsInSectionResult = 5
        //when
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        //then
        XCTAssertEqual(numberOfRows, 5)
    }
    
    func testTableViewCellForRow_ShouldReturn_NoDataCell_WhenPass_NoDataType() {
        //given
        mockCityListVM.getCellTypeResult = .noDataCell
        //when
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        //then
        XCTAssertTrue(cell is NoDataInfoCell)
    }
    
    func testTableViewCellForRow_ShouldReturn_CityDetailsCell_WhenPass_CityDataType() {
        //given
        mockCityListVM.getCellTypeResult = .cityDataCell
        //when
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        //then
        XCTAssertTrue(cell is CityDetailsCell)
    }
    
    func testTableViewCellForRow_SetsUpCityDetailsCellWithViewModel() {
        //given
        mockCityListVM.getCellTypeResult = .cityDataCell
        mockCityListVM.cityVMAtIndexResult = CityViewModel(cityModel: CityModel(city: City(id: 5, name: "Test City", findname: "Test City", country: "Test Country", coord: Coord(lon: 0, lat: 0), zoom: 5), time: 5, main: Main(temp: 10, pressure: 5, humidity: 5, tempMin: 5, tempMax: 5, seaLevel: 5, grndLevel: 5), wind: Wind(speed: 5, deg: 5, varBeg: 5, varEnd: 5), clouds: Clouds(all: 5), weather: [Weather(id: 5, main: "", description: "", icon: "")], rain: Rain(the3H: 5)))
        //when
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CityDetailsCell
        //then
        XCTAssertEqual(cell.lblCity.text, "Test City")
        XCTAssertEqual(cell.lblTemperature.text, "10.00°")
    }
    
    func testSearchBarTextDidChange_SetsSearchTextOnViewModel() {
        //given //when
        sut.searchBar(UISearchBar(), textDidChange: "Test Search")
        //then
        XCTAssertEqual(mockCityListVM.searchText, "Test Search")
    }
    
}

class MockCityListViewModel: CityListViewModelProtocol {
    
    var reloadTableView: (() -> Void)?
    var searchText: String = ""
    
    var isFetchCitiesWeatherDataCalled = false
    func fetchCitiesWeatherData() {
        isFetchCitiesWeatherDataCalled = true
    }
    
    var numberOfRowsInSectionResult = 0
    func numberOfRowsInSection(_ section: Int) -> Int {
        return numberOfRowsInSectionResult
    }
    
    var getCellTypeResult: TableViewCell = .noDataCell
    func getCellType() -> TableViewCell {
        return getCellTypeResult
    }
    
    var cityVMAtIndexResult: CityViewModel?
    func cityVMAtIndex(index: Int) -> CityViewModel? {
        return cityVMAtIndexResult
    }
    
}
