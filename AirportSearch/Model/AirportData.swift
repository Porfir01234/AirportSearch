//
//  AirportData.swift
//  AirportSearch
//
//  Created by Porfirio on 18/08/24.
//

import Foundation


struct Airport: Codable {
    
    let alpha2countryCode: String
    let iataCode: String
    let icaoCode: String
    let latitude: Double
    let longitude: Double
    let name: String
}

