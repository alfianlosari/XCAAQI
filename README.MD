# XCAAQI

![alt text](https://i.ibb.co/MPG2sXR/Whats-App-Image-2023-09-30-at-09-39-28.jpg)

Unofficial Google Air Quality API Swift Client. 

You can use it to fetch current AQI Conditions given a coordinate, it provides:
- Air Quality Index (UAQI).
- Dominant Pollutant.
- Color.
- Air Quality Condition.

## Requirements

Enable Google Air Quality API from GCP Console and create a new API Key

- iOS 17
- macOS 14
- tvOS 17
- watchOS 10

## Installation

### Swift Package Manager
- File > Swift Packages > Add Package Dependency
- Add https://github.com/alfianlosari/XCAAQI.git

## Usage

Initialize `AirQualityClient` passing your Google API Key.

```swift
import XCAAQI

let aqiClient = AirQualityClient(apiKey: "YOUR_GOOGLE_API_KEY")
```

### Fetch current AQ condition given a coordinate

```swift
Task {
    do {
        let response = try await aqiClient.getCurrentCondition(latitude: -6.224856390623585, longitude: 106.80432119416706)
        print(response)
    } catch {
        print(error.localizedDescription)
    }
}
```

### Fetch current AQ condition given array of coordinates

Note: Each of element in array will account to 1 API call to Google AQI API. If you have 20 coordinates, it will count toward 20 API call in your billing usage.

```swift
Task {
    do {
        let responses = try await aqiClient.getCurrentConditions(coordinates: [
            (-6.224856390623585, 106.80432119416706),
            (-5.224856390623585, 103.80432119416706)
        ])
        print(responses)
    } catch {
        print(error.localizedDescription)
    }
}
```
 
 ## TODO

 - Current Condition Additional request parameters
 - Historical data
 - Heatmap data
