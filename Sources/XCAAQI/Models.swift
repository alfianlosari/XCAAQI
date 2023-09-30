//
//  Models.swift
//  AirQualityAPI
//
//  Created by Alfian Losari on 30/09/23.
//

import Foundation

public struct AQIColor: Hashable, Codable {
    public let red: Double
    public let green: Double
    public let blue: Double
    
    public init(red: Double = 0, green: Double = 0, blue: Double = 0) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

public struct AQIResponse: Identifiable, Hashable, Codable {
    public let id = UUID()
    public let aqiIndex: Double
    public let aqiDisplay: String
    public let category: String
    public let code: String
    public let displayName: String
    public let dominantPollutant: String
    public let color: AQIColor
    public let latitude: Double
    public let longitude: Double
    public let timestamp: String
    
    public init(aqiIndex: Double = 0, aqiDisplay: String = "", category: String = "", code: String = "", displayName: String = "", dominantPollutant: String = "", color: AQIColor = .init(), latitude: Double = 0, longitude: Double = 0, timestamp: String = "") {
        self.aqiIndex = aqiIndex
        self.aqiDisplay = aqiDisplay
        self.category = category
        self.code = code
        self.displayName = displayName
        self.dominantPollutant = dominantPollutant
        self.color = color
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
}
