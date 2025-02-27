//
//  LocationDataModel.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import Foundation

class LocationDataModel {
    var locationName: String = ""
    var weatherDataList: [WeatherDataModel] = []
    
    init() {
        
    }
    
    static func convertFromHTTPServiceRecords(_ records: HTTPServiceRecords) -> [LocationDataModel] {
        var locationDataList: [LocationDataModel] = []
        
        for location in records.location {
            let locationData = LocationDataModel()
            locationData.locationName = location.locationName
            locationData.weatherDataList = WeatherDataModel.convertFromHTTPServiceLocation(location)
            locationDataList.append(locationData)
        }
        
        return locationDataList
    }
}

class WeatherDataModel {
    var locationName: String = ""
    var weatherPhenomenon: String = ""
    var rainfallProbability: String = ""
    var comfortIndex: String = ""
    var maxTemperature: String = ""
    var minTemperature: String = ""
    var time: Date = .now
    
    init() {
        
    }
    
    static func convertFromHTTPServiceLocation(_ location: HTTPServiceLocation) -> [WeatherDataModel] {
        var weatherDataList: [WeatherDataModel] = []
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        
        for _ in 0..<3 {
            weatherDataList.append(WeatherDataModel())
        }
        
        for weatherElement in location.weatherElement {
            for (index, time) in weatherElement.time.enumerated() {
                weatherDataList[index].time = time.startTime
                switch weatherElement.elementName {
                case HTTPServiceWeatherElement.ElementName.Wx.rawValue:
                    weatherDataList[index].weatherPhenomenon = time.parameter.parameterName
                case HTTPServiceWeatherElement.ElementName.PoP.rawValue:
                    weatherDataList[index].rainfallProbability = time.parameter.parameterName
                case HTTPServiceWeatherElement.ElementName.CI.rawValue:
                    weatherDataList[index].comfortIndex = time.parameter.parameterName
                case HTTPServiceWeatherElement.ElementName.MaxT.rawValue:
                    weatherDataList[index].maxTemperature = time.parameter.parameterName
                case HTTPServiceWeatherElement.ElementName.MinT.rawValue:
                    weatherDataList[index].minTemperature = time.parameter.parameterName
                default:
                    break
                }
            }
        }
        
        return weatherDataList
    }
}
