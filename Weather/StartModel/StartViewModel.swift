

import Foundation

protocol IStartViewModel {
    var stateChanged: ((StartViewModel.State) -> ())? {get set}
    func didTabAllowGeo()
    func didTabDoNotAllowGeo()
}

final class StartViewModel {
    
    
    //MARK: - Enum
    
    enum State {
        case allow
        case notAllow
        
    }
    
    
    //MARK: - Properties
    
    var stateChanged: ((State) ->())?
    
    private weak var coordinator: IStartCoordinator?
    private var state: State = .allow {
        didSet {
            self.stateChanged?(self.state)
        }
    }
    
    
    //MARK: - Life Cycle
    
    init( coordinator: IStartCoordinator?) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("StartViewmodel \(#function)")
    }
}


    //MARK: - IStartViewModel

extension StartViewModel:IStartViewModel {
    func didTabAllowGeo() {
        self.coordinator?.switchToNextFlow()
    }
    
    func didTabDoNotAllowGeo() {
        self.coordinator?.switchToNextFlow()
    }
    
 
    
    
}
