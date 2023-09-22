
import UIKit

protocol IMainCoordinator:AnyObject {
    func switchToNextFlow(from currentCoordinator: ICoordinator)
}



final class MainCoordinator {

    
    //MARK: - Propertis
    
    private var rootViewController: UIViewController
    private var childCoordinator: [ICoordinator] = []
    
    
    //MARK: - Life Cicle
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    //MARK: - Methods
    
    
    private func makeStartCoordinator() -> ICoordinator {
        let startCoordinator = StartCoordinator(
            navigationController: UINavigationController(),
            parentCoordunator: self
        )
        return startCoordinator
    }
    
    private func addChildCoordinator(_ coordinator:ICoordinator) {
        guard !self.childCoordinator.contains(where: { $0 === coordinator})
        else { return }
        self.childCoordinator.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator:ICoordinator) {
        self.childCoordinator.removeAll { $0 === coordinator}
    }
    
    // Методы установки/переключения Flow
    func setFlow(to newViewController: UIViewController) {
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: self.rootViewController)
    }
    
    func switchFlow(to newViewController: UIViewController) {
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.children[0].navigationController?.navigationBar.isHidden = true
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        
        self.rootViewController.transition(
            from: self.rootViewController.children[0],
            to: newViewController,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {}
        ) { _ in
            self.rootViewController.children[0].removeFromParent()
            newViewController.didMove(toParent: self.rootViewController)
            }
    }
    
    private func switchCoordinators(from oldCoordinator: ICoordinator, to newCoordinator: ICoordinator) {
        self.addChildCoordinator(newCoordinator)
        self.switchFlow(to: newCoordinator.start())
        self.removeChildCoordinator(oldCoordinator)
    }
    

}

// MARK: - ICoordinator

extension MainCoordinator: ICoordinator {

func start() -> UIViewController {
    var coordinator: ICoordinator
    // Тут проверка:
//        if пользователь авторизирован {
//            coordinator = self.makeToTabBarCoordinator()
//        } else {
//            coordinator = self.makeLoginCoordinator()
//        }
    // Для примера, пользователь не авторизирован:
    coordinator = self.makeStartCoordinator()
    self.addChildCoordinator(coordinator)
    self.setFlow(to: coordinator.start())
    return self.rootViewController
}
}

// MARK: - CoordinatbleMain

extension MainCoordinator: IMainCoordinator {
    func switchToNextFlow(from currentCoordinator: ICoordinator) {
        
    }
    
    
   
}
