//
//  AirQualityClient.swift
//  XCAAQI
//
//  Created by Alfian Losari on 28/09/23.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct AirQualityClient {
    
    let client: Client
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey 
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport())
    }
    
    public func getCurrentCondition(latitude: Double, longitude: Double) async throws -> AQIResponse {
        let response  = try await client.currentConditions(
            .init(query: .init(key: apiKey),
                  body: .json(.init(
                    location: .init(
                        latitude: latitude,
                        longitude: longitude)
                  )))
        )
        
        switch response {
            case .ok(let response):
                switch response.body {
                case .json(let resp) where resp.indexes?.first != nil:
                    let item = resp.indexes![0]
                    return AQIResponse(
                        aqiIndex: item.aqi ?? 0,
                        aqiDisplay: item.aqiDisplay ?? "",
                        category: item.category ?? "",
                        code: item.code ?? "",
                        displayName: item.displayName ?? "",
                        dominantPollutant: item.dominantPollutant ?? "",
                        color: AQIColor(
                            red: item.color?.red ?? 0,
                            green: item.color?.green ?? 0,
                            blue: item.color?.blue ?? 0),
                        latitude: latitude,
                        longitude: longitude,
                        timestamp: resp.dateTime ?? "")
                default:
                    throw "Unknown response"
                }
            default:
                throw "Failed to generate image"
            }
    }
    
    /// Each element in array will be accounted as 1 api call. Total api calls == total element in array
    public func getCurrentConditions(coordinates: [(Double, Double)]) async throws -> [AQIResponse] {
        try await withThrowingTaskGroup(of: AQIResponse.self) { group in
            for coordinate in coordinates {
                group.addTask {
                    try await self.getCurrentCondition(latitude: coordinate.0, longitude: coordinate.1)
                }
            }
            var results = [AQIResponse]()
            for try await result in group {
                results.append(result)
            }
            return results
        }
    }
}
