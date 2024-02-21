
import UIKit

protocol IGeneralWeatherCoordinator:AnyObject {
    func switchToNextFlow(delegate: AddButtonLocationDelegate)
    func presentChildViewController(_ viewController: UIViewController)
}

final class GeneralWeatherCoordinator {
    
    
    //MARK: - Properties
    
    private weak var parentCoordunator: IMainCoordinator?
    private var navigationController:UINavigationController
    private var childCoordinator: [ICoordinator] = []
    private let cityName: String?
    private var city: City?
    private var cities: [City] = []
    //MARK: - Life Cycle
    init(navigationController: UINavigationController, parentCoordunator: IMainCoordinator?, cityName: String?) {
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
        //        let viewModel = GeneralViewModel(coordinator: self, cityName: cityName)
        //        let generalVC = GeneralViewController(viewModel: viewModel)
        //        let generalNC = UINavigationController(rootViewController: generalVC)
        //        self.navigationController = generalNC
        //        return self.navigationController
        //    }        let viewModel = GeneralViewModel(coordinator: self, cityName: cityName)
        let viewModel = GeneralViewModel(coordinator: self, cityName: cityName)
        let generalVC = GeneralViewController(viewModel: viewModel)
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.setViewControllers([generalVC], direction: .forward, animated: true, completion: nil)
        
        self.navigationController = UINavigationController(rootViewController: pageViewController)
        
        return self.navigationController
    }
}


    //MARK: - IGeneralWeatherCoordinator
extension GeneralWeatherCoordinator: IGeneralWeatherCoordinator {
    func switchToNextFlow(delegate: AddButtonLocationDelegate) {
        let locationCoordinator = AddButtonLocationCoordinator(parentCoordunator: self, parentController: delegate)
        let locationCoordinatorVC = locationCoordinator.start()
        let locationCoordinatorNC = UINavigationController(rootViewController: locationCoordinatorVC)
        locationCoordinatorNC.modalPresentationStyle = .pageSheet
        locationCoordinatorNC.modalTransitionStyle = .crossDissolve
        self.presentChildViewController(locationCoordinatorNC)
    }
}

