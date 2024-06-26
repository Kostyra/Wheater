
import Network
import Foundation

protocol IGeneralViewModel {
    var stateChanged: ((GeneralViewModel.State) -> ())? {get set}
    func nextFlow(delegate: AddButtonLocationDelegate)
    func nextFlowProperties()
    func getWeather()
    func didTapCity(_ city: City)
}

final class GeneralViewModel {
    
    
    //MARK: - Enum
    
    enum State {
        case allow(city: City)
        case notAllow
        case loading
        case notInternet
    }
    
    
    //MARK: - Properties
    var position:StartViewModel.StatePosition?
    var stateChanged: ((State) ->())?
    let cityName: String?
    
    private weak var coordinator: IGeneralWeatherCoordinator?
    private var state: State = .loading {
        didSet {
            self.stateChanged?(self.state)
        }
    }
    
    
    //MARK: - Life Cycle
    
    init( coordinator: IGeneralWeatherCoordinator?, cityName: String?) {
        self.coordinator = coordinator
        self.cityName = cityName
    }
    
    deinit {
        print("StartViewmodel \(#function)")
    }
    
}
    //MARK: - extension

extension GeneralViewModel:IGeneralViewModel {
    func nextFlow(delegate: AddButtonLocationDelegate) {
        coordinator?.switchToNextFlow(delegate: delegate)
    }
    
    func nextFlowProperties() {
        coordinator?.switchToNextFlowProperties()
    }
    
    func getWeather() {
        guard let cityName = cityName else {
            state = .notAllow
            return
        }
        

        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NetWorkManager.shared.getWeather(city: cityName) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let cityData):
                        CoreDataHandler.shared.saveCityDataToCoreData(cityData: cityData)
                        self.state = .allow(city: cityData)

                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            } else {
                self.state = .notInternet
                print("not internet")
                
            }
        }
        
        monitor.start(queue: DispatchQueue.global())
    }
    
    func didTapCity(_ city: City) {
        state = .allow(city: city)
        
    }
}
