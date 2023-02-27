//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by N Shukla on 24/02/23.
//

import UIKit

enum TableViewCell: String {
    case noDataCell = "NoDataInfoCell"
    case cityDataCell = "CityDetailsCell"
}

class CityListViewController: UIViewController {
    
    private var cityListVM: CityListViewModelProtocol?
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        getCitiesWeatherRecords()
        hideKeyboardWhenTappedAround()
    }
    
    func setViewModel(cityListVM: CityListViewModelProtocol){
        self.cityListVM = cityListVM
    }
    
    /**
     This is method to fetch Cities weather by invoking viewmodel class.
     * Update the UI as data gets updated.
     
     */
    private func getCitiesWeatherRecords() {
        // Reload TableView closure - {binding}
        guard var cityListviewModel = cityListVM else {
            return
        }
        cityListviewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        cityListviewModel.fetchCitiesWeatherData()
    }
    
}

// MARK: - Table view data source
extension CityListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cityListviewModel = cityListVM else {
            return 0
        }
        return cityListviewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cityListviewModel = cityListVM else {
            return UITableViewCell()
        }
        switch cityListviewModel.getCellType() {
        case .noDataCell:
            return getNoDataCell(tableView: tableView, indexPath: indexPath)
        case .cityDataCell:
            return getCityDetailsCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    /**
     This is method to provide cell object i.e. 'NoDataInfoCell'
     */
    private func getNoDataCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.noDataCell.rawValue, for: indexPath) as? NoDataInfoCell else{
            return UITableViewCell()
        }
        return cell
    }
    
    /**
     This is method to provide cell object i.e. 'CityDetailsCell'
     */
    private func getCityDetailsCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cityDataCell.rawValue, for: indexPath) as? CityDetailsCell, let cityListviewModel = cityListVM  else{
            return UITableViewCell()
        }
        if let cityViewModel = cityListviewModel.cityVMAtIndex(index: indexPath.row) {
            cell.setUpData(cityVM: cityViewModel)
        }
        return cell
    }
}

// MARK: - Search bar delegate
extension CityListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard var cityListviewModel = cityListVM else {
            return
        }
        cityListviewModel.searchText = searchText
    }
}
