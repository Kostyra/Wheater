
import UIKit

protocol IGeneralWeatherCoordinator:AnyObject {
    func switchToNextFlow()
}

final class GeneralWeatherCoordinator {
    
    
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


//MARK: - ICoordinator
extension GeneralWeatherCoordinator: ICoordinator {
    func start() -> UIViewController {
        let viewModel = GeneralViewModel(coordinator: self)
        let generalVC = GeneralViewController(viewModel: viewModel)
        let generalNC = UINavigationController(rootViewController: generalVC)
        self.navigationController = generalNC
        return self.navigationController
    }
}

    //MARK: - IGeneralWeatherCoordinator
extension GeneralWeatherCoordinator: IGeneralWeatherCoordinator {
    func switchToNextFlow() {
        self.parentCoordunator?.switchToNextFlow(from: self)
    }
}



