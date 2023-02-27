//
//  CityViewModelTest.swift
//  WeatherAppTests
//
//  Created by N Shukla on 27/02/23.
//

import XCTest
@testable import WeatherApp

final class CityViewModelTest: XCTestCase {
    
    var sut: CityViewModel!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCityViewModel_Should_Init_ForGivenModelObjectValue_1() {
        // given
        let cityModel = CityModel(city: City(id: 1, name: "pune", findname: "PUNE", country: "IN", coord: Coord(lon: 1, lat: 1), zoom: 1), time: 1, main: Main(temp: 1, pressure: 1, humidity: 1, tempMin: 1, tempMax: 1, seaLevel: 1, grndLevel: 1), wind: Wind(speed: 1, deg: 1, varBeg: 1, varEnd: 1), clouds: Clouds(all: 1), weather: [Weather(id: 1, main: "main1", description: "description1", icon: "icon1")], rain: Rain(the3H: 1))
        // when
        sut = CityViewModel(cityModel: cityModel)
        // then
        // check for city name
        XCTAssertEqual(sut.city, cityModel.city?.name)
        // check for country
        XCTAssertEqual(sut.country, cityModel.city?.country)
        //check latitude
        let lat = "\(cityModel.city?.coord?.lat ?? 0)"
        XCTAssertEqual(sut.latitude, lat)
        // check logitude
        let long = "\(cityModel.city?.coord?.lon ?? 0)"
        XCTAssertEqual(sut.longitude, long)
        // check temperature
        let temp = cityModel.main?.temp ?? 0
        XCTAssertEqual(sut.temperature, temp.formatAsDegree)
    }
    
    func testCityViewModel_Should_Init_ForGivenModelObjectValue_2() {
        // given
        let cityModel = CityModel(city: City(id: 2, name: "mumbai", findname: "MUMBAI", country: "India", coord: Coord(lon: 2, lat: 2), zoom: 2), time: 2, main: Main(temp: 2, pressure: 2, humidity: 2, tempMin: 2, tempMax: 2, seaLevel: 2, grndLevel: 2), wind: Wind(speed: 2, deg: 2, varBeg: 2, varEnd: 2), clouds: Clouds(all: 2), weather: [Weather(id: 2, main: "main2", description: "description2", icon: "icon2")], rain: Rain(the3H: 2))
        // when
        sut = CityViewModel(cityModel: cityModel)
        // then
        // check for city name
        XCTAssertEqual(sut.city, cityModel.city?.name)
        // check for country
        XCTAssertEqual(sut.country, cityModel.city?.country)
        //check latitude
        let lat = "\(cityModel.city?.coord?.lat ?? 0)"
        XCTAssertEqual(sut.latitude, lat)
        // check logitude
        let long = "\(cityModel.city?.coord?.lon ?? 0)"
        XCTAssertEqual(sut.longitude, long)
        // check temperature
        let temp = cityModel.main?.temp ?? 0
        XCTAssertEqual(sut.temperature, temp.formatAsDegree)
    }
    
    func testCityViewModel_Should_Init_WithEmptyStr_ForGivenModelObjectValue_Nil() {
        // given
        let cityModel = CityModel(city: nil, time: 2, main: nil, wind: Wind(speed: 2, deg: 2, varBeg: 2, varEnd: 2), clouds: Clouds(all: 2), weather: [Weather(id: 2, main: "main2", description: "description2", icon: "icon2")], rain: Rain(the3H: 2))
        // when
        sut = CityViewModel(cityModel: cityModel)
        // then
        // check for city name
        XCTAssertEqual(sut.city, "")
        // check for country
        XCTAssertEqual(sut.country, "")
        //check latitude
        XCTAssertEqual(sut.latitude, "")
        // check logitude
        XCTAssertEqual(sut.longitude, "")
        // check temperature
        XCTAssertEqual(sut.temperature, "")
    }

}
