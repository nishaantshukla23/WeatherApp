//
//  Coordinator.swift
//  WeatherApp
//
//  Created by N Shukla on 27/02/23.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    func start()
}

final class Coordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    var childCoordinators = [CoordinatorProtocol]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let cityListVM = CityListViewModel()
        let cityListViewController = CityListViewControllerFactory.createCityListViewController(cityListVM: cityListVM)
        navigationController.pushViewController(cityListViewController, animated: false)
    }
    
}


class CityListViewControllerFactory {
    static func createCityListViewController(cityListVM: CityListViewModelProtocol) -> CityListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityListViewController") as! CityListViewController
        viewController.setViewModel(cityListVM: cityListVM)
        return viewController
    }
}
