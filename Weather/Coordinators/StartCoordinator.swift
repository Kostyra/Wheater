
import UIKit

protocol IStartCoordinator:AnyObject {
    func switchToNextFlow(cityName: String?)
}

final class StartCoordinator: IGeneralWeatherCoordinator {
    
    func switchToNextFlow(delegate: AddButtonLocationDelegate) {
        let locationCoordinator = AddButtonLocationCoordinator(parentCoordunator: self, parentController: delegate)
        let locationCoordinatorVC = locationCoordinator.start()
        let locationCoordinatorNC = UINavigationController(rootViewController: locationCoordinatorVC)
        locationCoordinatorNC.modalPresentationStyle = .pageSheet
        locationCoordinatorNC.modalTransitionStyle = .crossDissolve
        self.presentChildViewController(locationCoordinatorNC)
    }
    
    func presentChildViewController(_ viewController: UIViewController) {
       navigationController.present(viewController, animated: true, completion: nil)
   }
    
    
    
    //MARK: - Properties
    
    private weak var parentCoordunator: IMainCoordinator?
    private var navigationController:UIViewController
    private var childCoordinator: [ICoordinator] = []
    
    
    //MARK: - Life Cycle
    init(navigationController: UINavigationController, parentCoordunator: IMainCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordunator = parentCoordunator
    }
}


    //MARK: - IStartCoordinator
extension StartCoordinator: IStartCoordinator {
    func switchToNextFlow(cityName: String?) {
        self.parentCoordunator?.switchToNextFlow(from: self, cityName: cityName)
    }
}


    //MARK: - ICoordinator
extension StartCoordinator: ICoordinator {
    func start() -> UIViewController {
//        let coreDataHandler = CoreDataHandler()
//        if let cityEntities = coreDataHandler.fetchCityEntitiesForCityName(), !cityEntities.isEmpty {
//            let viewModel = GeneralViewModel(coordinator: self, cityName: cityEntities.first?.name ?? "")
//            let generalVC = GeneralViewController(viewModel: viewModel)
//            let generalNC = UINavigationController(rootViewController: generalVC)
//            self.navigationController = generalNC
//            return self.navigationController
        let coreDataHandler = CoreDataHandler()
        if let cityEntities = coreDataHandler.fetchCityEntitiesForCityName(), !cityEntities.isEmpty {
            let viewModel = GeneralViewModel(coordinator: self, cityName: cityEntities.first?.name ?? "")
            let generalVC = GeneralViewController(viewModel: viewModel)
              
            let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            pageViewController.setViewControllers([generalVC], direction: .forward, animated: true, completion: nil)
            
            navigationController.navigationController?.setViewControllers([pageViewController], animated: true)
              
            return pageViewController
        
        } else {
            let locationManager = LocationManager()
            let viewModel = StartViewModel(coordinator: self, locationManager: locationManager)
            let startVC = StartViewController(viewModel: viewModel)
            let startNC = UINavigationController(rootViewController: startVC)
            self.navigationController = startNC
            return self.navigationController
        }
    }
}
