//
//  NormalForecastListViewControllerViewModel.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import Foundation
import Combine

class NormalForecastListViewControllerViewModel {
    var locationDataList = CurrentValueSubject<[LocationDataModel], Never>([])
    
    func getForcast36Hours() {
        Task {
            do {
                self.locationDataList.send([])
                let locationDataList = try await HTTPService.shared.getForecast36Hours()
                self.locationDataList.send(locationDataList)
            } catch {
                print("\(#function) error: \(error.localizedDescription)")
            }
        }
    }
}
