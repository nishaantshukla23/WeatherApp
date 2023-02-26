//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by N Shukla on 26/02/23.
//

import Foundation

extension Double {
    
    /**
     * This member is used to convert Double into String form.
     * It adds degree symbol to dobule value.
     */
    var formatAsDegree: String {
        return String(format: "%.02f°",self)
    }
    
}
