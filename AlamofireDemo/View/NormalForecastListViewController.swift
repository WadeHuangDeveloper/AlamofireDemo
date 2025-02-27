//
//  NormalForecastListViewController.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import UIKit
import Combine

class NormalForecastListViewController: UIViewController {
    var viewModel = NormalForecastListViewControllerViewModel()
    private var refreshControl = UIRefreshControl()
    private var weatherTableView = UITableView()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCombine()
        viewModel.getForcast36Hours()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cancellables.removeAll()
    }
    
    private func initUI() {
        refreshControl.addTarget(self, action: #selector(onRefreshControl), for: .valueChanged)
        
        weatherTableView.register(NormalForecastItemTableViewCell.self, forCellReuseIdentifier: NormalForecastItemTableViewCell.identifier)
        weatherTableView.refreshControl = refreshControl
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.rowHeight = 80
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(weatherTableView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            weatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func onRefreshControl() {
        viewModel.getForcast36Hours()
    }

    private func setupCombine() {
        viewModel.locationDataList
            .receive(on: DispatchQueue.main)
            .sink { _ in self.weatherDataListDidChange() }
            .store(in: &cancellables)
    }
    
    private func weatherDataListDidChange() {
        self.weatherTableView.refreshControl?.endRefreshing()
        self.weatherTableView.reloadData()
    }
}

extension NormalForecastListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationDataList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NormalForecastItemTableViewCell.identifier, for: indexPath) as! NormalForecastItemTableViewCell
        cell.configure(viewModel.locationDataList.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension NormalForecastListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
