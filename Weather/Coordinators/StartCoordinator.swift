
import UIKit

protocol IStartCoordinator:AnyObject {
    func switchToNextFlow()
}

final class StartCoordinator {
    
    
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
    func switchToNextFlow() {
        self.parentCoordunator?.switchToNextFlow(from: self)
    }
}


    //MARK: - ICoordinator
extension StartCoordinator: ICoordinator {
    func start() -> UIViewController {
        let viewModel = StartViewModel(coordinator: self)
        let startVC = StartViewController(viewModel: viewModel)
        let startNC = UINavigationController(rootViewController: startVC)
        self.navigationController = startNC
        return self.navigationController
    }
}
