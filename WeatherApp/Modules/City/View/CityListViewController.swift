//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by N Shukla on 24/02/23.
//

import UIKit

class CityListViewController: UIViewController {

    private var cityListVM: CityListViewModel!
    
    required init?(coder: NSCoder) {
        cityListVM = CityListViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCitiesWeatherRecords()
    }
    
    private func getCitiesWeatherRecords() {
        cityListVM.getCitiesWeatherData()
    }
}

// MARK: - Table view data source
extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsCell", for: indexPath) as? CityDetailsCell else{
            return UITableViewCell()
        }
        
        let cityVM = cityListVM.cityVMAtIndex(index: indexPath.row)
        
        cell.lblCity.text = cityVM.city
        cell.lblCountry.text = cityVM.country
        cell.lblTemperature.text = cityVM.temperature
        cell.lblLatitude.text = cityVM.latitude
        cell.lblLongitude.text = cityVM.longitude

        return cell
    }
}
