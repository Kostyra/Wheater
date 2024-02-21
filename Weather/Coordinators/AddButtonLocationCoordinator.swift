
import UIKit

protocol IAddButtonLocationCoordinator:AnyObject {
    func switchToNextFlow()
}

final class AddButtonLocationCoordinator {
    
    
    //MARK: - Properties
    
    private weak var parentCoordunator: IGeneralWeatherCoordinator?
    private var childCoordinator: [ICoordinator] = []
    private let parentController: AddButtonLocationDelegate
    
    
    //MARK: - Life Cycle
    
    init( parentCoordunator: IGeneralWeatherCoordinator?, parentController: AddButtonLocationDelegate ) {
        self.parentCoordunator = parentCoordunator
        self.parentController = parentController
    }
}


//MARK: - ICoordinator

extension AddButtonLocationCoordinator: ICoordinator {
    func start() -> UIViewController {
        let viewModel = AddButtonLocationModel(coordinator: self)
        let addButtonLocationVC = AddButtonLocationViewController(viewModel: viewModel)
        addButtonLocationVC.delegate = parentController
        addButtonLocationVC.modalPresentationStyle = .fullScreen
        addButtonLocationVC.modalTransitionStyle = .crossDissolve
        return addButtonLocationVC
    }
}

    //MARK: - IGeneralWeatherCoordinator

extension AddButtonLocationCoordinator: IAddButtonLocationCoordinator {
    func switchToNextFlow() {
    }
    

}



