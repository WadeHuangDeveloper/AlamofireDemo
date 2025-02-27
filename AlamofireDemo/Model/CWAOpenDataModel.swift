//
//  CWAOpenDataModel.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import Foundation

struct CWAOpenDataModel {
    static let Host = "https://opendata.cwa.gov.tw"
    static let ApiKey = ""
}

struct CWAOpenDataEndPointModel {
    static let Forecast36Hours = "/api/v1/rest/datastore/F-C0032-001"
}

struct CWAOpenDataHeaderModel {
    static let Authorization = "Authorization"
}
