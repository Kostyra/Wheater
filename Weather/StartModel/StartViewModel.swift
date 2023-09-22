

import Foundation

protocol IStartViewModel {
    var stateChanged: ((StartViewModel.State) -> ())? {get set}
    var stateChangedPosition: ((StartViewModel.StatePosition) ->())? {get set}
    func didTabAllowGeo()
    func didTabDoNotAllowGeo()
}

final class StartViewModel {
    
    
    //MARK: - Enum
    
     enum State {
        case initial
    }
    
    enum StatePosition {
        case allow
        case notAllow
    }
    
    
    //MARK: - Properties
    
    var stateChanged: ((State) ->())?
    var stateChangedPosition: ((StatePosition) ->())?
    
    
    private weak var coordinator: IStartCoordinator?
    private var state: State = .initial {
        didSet {
            self.stateChanged?(self.state)
        }
    }
    
    private var position:StatePosition = .allow {
        didSet {
            self.stateChangedPosition?(self.position)
        }
    }
    
    
    //MARK: - Life Cycle
    
    init( coordinator: IStartCoordinator?) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("StartViewModel \(#function)")
    }
}


    //MARK: - IStartViewModel

extension StartViewModel:IStartViewModel {
    func didTabAllowGeo() {
        self.coordinator?.switchToNextFlow()
        self.position = .allow
        print(position)
        
    }
    
    func didTabDoNotAllowGeo() {
        self.coordinator?.switchToNextFlow()
        self.position = .notAllow
    }
    

    
    
}
