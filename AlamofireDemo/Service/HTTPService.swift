//
//  HTTPService.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import Foundation
import Alamofire

class HTTPService {
    static let shared = HTTPService()
    
    private init() {
        
    }
    
    private func get(url: URL, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) async throws -> HTTPServiceResponse {
        do {
            let serviceResponse = try await AF.request(url, method: .get, parameters: parameters, headers: headers)
                .serializingDecodable(HTTPServiceResponse.self)
                .value
            return serviceResponse
        } catch {
            throw HTTPServiceError.InvalidWithError(error)
        }
    }
    
    func getForecast36Hours() async throws -> [LocationDataModel] {
        guard let url = URL(string: CWAOpenDataModel.Host + CWAOpenDataEndPointModel.Forecast36Hours) else {
            throw HTTPServiceError.InvalidURL
        }
        let headers: HTTPHeaders = [
            CWAOpenDataHeaderModel.Authorization: CWAOpenDataModel.ApiKey
        ]
        let serviceResponse = try await get(url: url, headers: headers)
        let locationDataList = LocationDataModel.convertFromHTTPServiceRecords(serviceResponse.records)
        return locationDataList
    }
}
