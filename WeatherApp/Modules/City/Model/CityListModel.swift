//
//  CityListModel.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

// MARK: - CityModel
struct CityModel: Decodable {
    let city: City?
    let time: Int?
    let main: Main?
    let wind: Wind?
    let clouds: Clouds?
    let weather: [Weather]?
    let rain: Rain?
}

// MARK: - City
struct City: Decodable {
    let id: Int?
    let name, findname, country: String?
    let coord: Coord?
    let zoom: Int?
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double?
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int?
}

// MARK: - Main
struct Main: Decodable {
    let temp, pressure: Double?
    let humidity: Int?
    let tempMin, tempMax, seaLevel, grndLevel: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct Rain: Decodable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Decodable {
    let speed, deg: Double?
    let varBeg, varEnd: Int?

    enum CodingKeys: String, CodingKey {
        case speed, deg
        case varBeg = "var_beg"
        case varEnd = "var_end"
    }
}
