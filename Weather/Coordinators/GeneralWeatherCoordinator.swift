
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


    //MARK: - IStartCoordinator
extension GeneralWeatherCoordinator: IGeneralWeatherCoordinator {
    func switchToNextFlow() {
        self.parentCoordunator?.switchToNextFlow(from: self)
    }
}


    //MARK: - ICoordinator
extension GeneralWeatherCoordinator: ICoordinator {
    func start() -> UIViewController {
        let viewModel = GeneralViewModel(coordinator: self)
        let startVC = GeneralViewController(viewModel: viewModel)
        let startNC = UINavigationController(rootViewController: startVC)
        self.navigationController = startNC
        return self.navigationController
    }
}
