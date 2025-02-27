//
//  HTTPServiceResponse.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import Foundation

struct HTTPServiceResponse: Codable {
    let success: String
    let result: HTTPServiceResult
    let records: HTTPServiceRecords
}

// MARK: - HTTPServiceResult

struct HTTPServiceResult: Codable {
    let resourceId: String
    let fields: [HTTPServiceField]
    
    enum CodingKeys: String, CodingKey {
        case resourceId = "resource_id"
        case fields
    }
}

struct HTTPServiceField: Codable {
    let id: String
    let type: String
}

// MARK: - HTTPServiceRecords

struct HTTPServiceRecords: Codable {
    let datasetDescription: String
    let location: [HTTPServiceLocation]
}

struct HTTPServiceLocation: Codable {
    let locationName: String
    let weatherElement: [HTTPServiceWeatherElement]
}

struct HTTPServiceWeatherElement: Codable {
    let elementName: String
    let time: [HTTPServiceTime]
    
    enum ElementName: String {
        case Wx = "Wx"
        case CI = "CI"
        case PoP = "PoP"
        case MaxT = "MaxT"
        case MinT = "MinT"
    }
}

struct HTTPServiceTime: Codable {
    let startTime: Date
    let endTime: Date
    let parameter: HTTPServiceParameter
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        self.startTime = try dateFormatter.date(from: container.decode(String.self, forKey: .startTime)) ?? .now
        self.endTime = try dateFormatter.date(from: container.decode(String.self, forKey: .endTime)) ?? .now
        self.parameter = try container.decode(HTTPServiceParameter.self, forKey: .parameter)
    }
}

struct HTTPServiceParameter: Codable {
    let parameterName: String
    let parameterValue: String?
    let parameterUnit: String?
}
