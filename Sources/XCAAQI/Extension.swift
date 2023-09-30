//
//  Extension.swift
//  AirQualityAPI
//
//  Created by Alfian Losari on 30/09/23.
//

import Foundation
#if canImport(CoreLocation)
import CoreLocation

public extension AQIResponse {
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
#endif

extension String: LocalizedError {
    
    public var errorDescription: String? { self }
}

