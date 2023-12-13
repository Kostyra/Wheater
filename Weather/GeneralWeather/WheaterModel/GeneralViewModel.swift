

import Foundation

protocol IGeneralViewModel {
    var stateChanged: ((GeneralViewModel.State) -> ())? {get set}
    func nextFlow()

}

final class GeneralViewModel {
    
    
    //MARK: - Enum
    
    enum State {
        case allow
        case notAllow
    }
    
    
    //MARK: - Properties
    var position:StartViewModel.StatePosition?
    var stateChanged: ((State) ->())?
    
    private weak var coordinator: IGeneralWeatherCoordinator?
    private var state: State = .allow {
        didSet {
            self.stateChanged?(self.state)
        }
    }
    
    
    //MARK: - Life Cycle
    
    init( coordinator: IGeneralWeatherCoordinator?) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("StartViewmodel \(#function)")
    }
}


    //MARK: - IStartViewModel

extension GeneralViewModel:IGeneralViewModel {
    func nextFlow() {
        coordinator?.switchToNextFlow()
    }
    

    
}
