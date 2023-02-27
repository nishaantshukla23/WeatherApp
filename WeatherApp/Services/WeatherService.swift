//
//  WeatherService.swift
//  WeatherApp
//
//  Created by N Shukla on 26/02/23.
//

import Foundation

enum ServiceError: Error {
    case resourceNotFound(String)
    case dataLoadFailed(String)
    case decodingFailed(String)
    case invalidJSON(String)
    case unknownError(String)
}

enum Resources: String {
    case jsonFile = "weather"
}

protocol WeatherServiceProtocol {
    func getCitiesWeatherData(completion: @escaping (Result<[CityModel], ServiceError>) -> Void)
}

struct WeatherService: WeatherServiceProtocol {
    
    /**
     This is method to read Json files & return [CityModel] Object.
     
     - Parameters:
       - completion: clouse to return success or error case.
     */
    func getCitiesWeatherData(completion: @escaping (Result<[CityModel], ServiceError>) -> Void) {
        do {
            let result: [CityModel] = try Bundle.main.decode(from: Resources.jsonFile.rawValue)
            DispatchQueue.main.async {
                completion(.success(result))
            }
        } catch {
            completion(.failure(.decodingFailed("decoding failed.")))
        }
    }
}
