//
//  ChangeProperties.swift
//  Weather
//
//  Created by Юлия Филиппова on 01.04.2024.
//

import Foundation



import UIKit

protocol IChangePropertiesCoordinator:AnyObject {
//    func switchToNextFlow()
}

final class ChangePropertiesCoordinator {
    
    
    //MARK: - Properties
    
    private weak var parentCoordunator: IGeneralWeatherCoordinator?
    private var childCoordinator: [ICoordinator] = []
    private var navigationController:UIViewController
    
    
    //MARK: - Life Cycle
    
    init(navigationController: UIViewController, parentCoordunator: IGeneralWeatherCoordinator? ) {
        self.navigationController = navigationController
        self.parentCoordunator = parentCoordunator
    }

}


//MARK: - ICoordinator

extension ChangePropertiesCoordinator: ICoordinator {
    func start() -> UIViewController {
//        let viewModel = ChangePropertiesModel(coordinator: self)
//        let changePropertiesVC = ChangePropertiesController(viewModel: viewModel)
//        changePropertiesVC.modalPresentationStyle = .overFullScreen
//        changePropertiesVC.modalTransitionStyle = .crossDissolve
//        return changePropertiesVC
        return UIViewController()
    }
}

extension ChangePropertiesCoordinator: IChangePropertiesCoordinator {
 
    
}
 





