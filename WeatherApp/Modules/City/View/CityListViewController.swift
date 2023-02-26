//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by N Shukla on 24/02/23.
//

import UIKit

class CityListViewController: UIViewController {
    
    private var cityListVM: CityListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    required init?(coder: NSCoder) {
        cityListVM = CityListViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCitiesWeatherRecords()
        hideKeyboardWhenTappedAround()
    }
    
    /**
     This is method to fetch Cities weather by invoking viewmodel class.
        * Update the UI as data gets updated.
    
     */
    private func getCitiesWeatherRecords() {
        cityListVM.getCitiesWeatherData()
        // Reload TableView closure
        cityListVM.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - Table view data source
extension CityListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cityListVM.shouldShowNoDataFoundCell() {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataInfoCell", for: indexPath) as? NoDataInfoCell else{
                return UITableViewCell()
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsCell", for: indexPath) as? CityDetailsCell else{
                return UITableViewCell()
            }
            let cityViewModel = cityListVM.cityVMAtIndex(index: indexPath.row)
            cell.setUpData(cityVM: cityViewModel)
            return cell
        }
    }
}

extension CityListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cityListVM.searchText = searchText
    }
}
