//
//  TemperatureDataView.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/27.
//

import UIKit

class TemperatureDataView: UIView {
    private var timeLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var weatherPhenomenonLabel = UILabel()
    private var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        timeLabel.font = .systemFont(ofSize: 10, weight: .medium)
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        temperatureLabel.font = .systemFont(ofSize: 14, weight: .bold)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .systemGray
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weatherPhenomenonLabel.font = .systemFont(ofSize: 10, weight: .regular)
        weatherPhenomenonLabel.textAlignment = .center
        weatherPhenomenonLabel.textColor = .systemBlue
        weatherPhenomenonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherPhenomenonLabel)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
    
    func configure(_ weatherData: WeatherDataModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        dateFormatter.timeZone = .current
        timeLabel.text = dateFormatter.string(from: weatherData.time)
        temperatureLabel.text = "\(weatherData.minTemperature)~\(weatherData.maxTemperature) ºc"
        weatherPhenomenonLabel.text = weatherData.weatherPhenomenon
    }
}
