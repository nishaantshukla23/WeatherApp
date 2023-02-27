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
    
    private var cityListVM: CityListViewModelProtocol = CityListViewModel()
        
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
        cityListVM.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        cityListVM.fetchCitiesWeatherData()
    }
    
}

// MARK: - Table view data source
extension CityListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cityListVM.getCellType() {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cityDataCell.rawValue, for: indexPath) as? CityDetailsCell else{
            return UITableViewCell()
        }
        if let cityViewModel = cityListVM.cityVMAtIndex(index: indexPath.row) {
            cell.setUpData(cityVM: cityViewModel)
        }
        return cell
    }
}

// MARK: - Search bar delegate
extension CityListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cityListVM.searchText = searchText
    }
}
