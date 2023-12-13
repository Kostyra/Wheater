
import UIKit

protocol IAddButtonLocationCoordinator:AnyObject {
    func switchToNextFlow()
}

final class AddButtonLocationCoordinator {
    
    
    //MARK: - Properties
    
    private weak var parentCoordunator: IGeneralWeatherCoordinator?
    private var childCoordinator: [ICoordinator] = []
    
    
    
    //MARK: - Life Cycle
    init( parentCoordunator: IGeneralWeatherCoordinator?) {
        self.parentCoordunator = parentCoordunator
    }
}


//MARK: - ICoordinator
extension AddButtonLocationCoordinator: ICoordinator {
    func start() -> UIViewController {
        let viewModel = AddButtonLocationModel(coordinator: self)
        let addButtonLocationVC = AddButtonLocationViewController(viewModel: viewModel)
        addButtonLocationVC.modalPresentationStyle = .fullScreen
        addButtonLocationVC.modalTransitionStyle = .crossDissolve
        return addButtonLocationVC
    }
}

    //MARK: - IGeneralWeatherCoordinator
extension AddButtonLocationCoordinator: IAddButtonLocationCoordinator {
    func switchToNextFlow() {
//        self.parentCoordunator?.switchToNextFlow(from: self)
    }
}



