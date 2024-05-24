
import UIKit

protocol IGeneralWeatherCoordinator:AnyObject {
    func switchToNextFlow(delegate: AddButtonLocationDelegate)
    func switchToNextFlowProperties()
    func presentChildViewController(_ viewController: UIViewController)
}

final class GeneralWeatherCoordinator {
    
    
    //MARK: - Properties
    
    private weak var parentCoordunator: IMainCoordinator?
    private var navigationController:UIViewController
    private var childCoordinator: [ICoordinator] = []
    private let cityName: String?
    private var city: City?
    private var cities: [City] = []
    
    
    //MARK: - Life Cycle
    
    init(navigationController: UIViewController, parentCoordunator: IMainCoordinator?, cityName: String?) {
        self.navigationController = navigationController
        self.parentCoordunator = parentCoordunator
        self.cityName = cityName
    }
    
     func presentChildViewController(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true, completion: nil)
    }
    

}


//MARK: - ICoordinator

extension GeneralWeatherCoordinator: ICoordinator {
    func start() -> UIViewController {
                let viewModel = GeneralViewModel(coordinator: self, cityName: cityName)
                let generalVC = GeneralViewController(viewModel: viewModel)
                let generalNC = UINavigationController(rootViewController: generalVC)
                self.navigationController = generalNC
                return self.navigationController
            } 
}


    //MARK: - extension

extension GeneralWeatherCoordinator: IGeneralWeatherCoordinator {
    func switchToNextFlow(delegate: AddButtonLocationDelegate) {
        let locationCoordinator = AddButtonLocationCoordinator(parentCoordunator: self, parentController: delegate)
        let locationCoordinatorVC = locationCoordinator.start()
//        let locationCoordinatorNC = UINavigationController(rootViewController: locationCoordinatorVC)
//        locationCoordinatorNC.modalPresentationStyle = .pageSheet
//        locationCoordinatorNC.modalTransitionStyle = .crossDissolve
        self.presentChildViewController(locationCoordinatorVC)
    }
    
    func switchToNextFlowProperties() {
        let locationCoordinator = ChangePropertiesCoordinator(navigationController: navigationController, parentCoordunator: self)
        let locationCoordinatorVC = locationCoordinator.start()
//        let locationCoordinatorNC = UINavigationController(rootViewController: locationCoordinatorVC)
  
//        locationCoordinatorNC.modalPresentationStyle = .overFullScreen
//        locationCoordinatorNC.modalTransitionStyle = .crossDissolve
        self.presentChildViewController(locationCoordinatorVC)
    }
    
//    func switchToNextFlowProperties() -> UIViewController  {
//        let viewModel = ChangePropertiesModel(coordinator: self)
//        let locationCoordinatorVC = ChangePropertiesController(viewModel: viewModel)
//        let locationCoordinatorNC = UINavigationController(rootViewController: locationCoordinatorVC)
//        self.navigationController = locationCoordinatorNC
//        return self.navigationController
//        return UIViewController()
//    }
    

}

