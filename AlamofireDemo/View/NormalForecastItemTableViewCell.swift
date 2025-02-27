//
//  NormalForecastItemTableViewCell.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import UIKit

class NormalForecastItemTableViewCell: UITableViewCell {
    static let identifier = "\(NormalForecastItemTableViewCell.self)"
    var viewModel = NormalForecastItemTableViewCellViewModel()
    private var locationNameLabel = UILabel()
    private var firstTemperatureDataView = TemperatureDataView()
    private var secondTemperatureDataView = TemperatureDataView()
    private var thirdTemperatureDataView = TemperatureDataView()
    private var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        locationNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        locationNameLabel.textColor = .black
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(locationNameLabel)
        stackView.addArrangedSubview(firstTemperatureDataView)
        stackView.addArrangedSubview(secondTemperatureDataView)
        stackView.addArrangedSubview(thirdTemperatureDataView)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            locationNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    func configure(_ locationData: LocationDataModel) {
        viewModel.locationData = locationData
        locationNameLabel.text = locationData.locationName
        firstTemperatureDataView.configure(locationData.weatherDataList[0])
        secondTemperatureDataView.configure(locationData.weatherDataList[1])
        thirdTemperatureDataView.configure(locationData.weatherDataList[2])
    }
}
