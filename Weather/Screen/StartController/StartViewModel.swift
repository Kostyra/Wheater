

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
    var locationManager: LocationManager
    
    
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
    
    init( coordinator: IStartCoordinator?, locationManager: LocationManager) {
        self.coordinator = coordinator
        self.locationManager = locationManager
    }
    
    deinit {
        print("StartViewModel \(#function)")
    }
    
    
    //MARK: -
    
    private func getCity() {
        locationManager.requestPermission { [weak self] cityName in
                guard let self else { return }
                self.coordinator?.switchToNextFlow(cityName: cityName)
                self.position = .allow
                print(position)
        }
    }
}


    //MARK: - IStartViewModel

extension StartViewModel:IStartViewModel {
    func didTabAllowGeo() {
     getCity()
    }
        
    func didTabDoNotAllowGeo() {
        self.coordinator?.switchToNextFlow(cityName: nil)
        self.position = .notAllow
        print(position)
    }
}
