//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by N Shukla on 25/02/23.
//

import Foundation

extension Bundle {
    
    /**
     This is method to read Json files & return Generic Object.
     
     - Parameters:
       - file: JSON file name located in application bundle.
     */
    
    func decode<T: Decodable>(from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            throw ServiceError.resourceNotFound("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            throw ServiceError.dataLoadFailed("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            throw ServiceError.decodingFailed("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            throw ServiceError.decodingFailed("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            throw ServiceError.decodingFailed("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            throw ServiceError.invalidJSON("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            throw ServiceError.unknownError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

