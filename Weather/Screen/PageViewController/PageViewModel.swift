

import Foundation

protocol IPageViewModel {
    var stateChanged: ((PageViewModel.State) -> ())? {get set}
    func nextFlow(delegate: AddButtonLocationDelegate)
    func getWeather()
    func didTapCity(_ city: City)
}

final class PageViewModel {
    
    
    //MARK: - Enum
    
    enum State {
        case allow(city: City)
        case notAllow
        case loading
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
    
    //MARK: - Method
    
    
}


    //MARK: - IStartViewModel

extension PageViewModel: IPageViewModel {
    func nextFlow(delegate: AddButtonLocationDelegate) {
        coordinator?.switchToNextFlow(delegate: delegate)
    }
    
    func getWeather() {
        guard let cityName else {
            state = .notAllow
            return
        }
        NetWorkManager.shared.getWeather(city: cityName) { [weak self] result in
            guard let self =  self else { return }
            switch result {
            case .success(let cityData):
                CoreDataHandler.shared.saveCityDataToCoreData(cityData: cityData)
                self.state = .allow(city: cityData)
               
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func didTapCity(_ city: City) {
        state = .allow(city: city)
        
    }
    
}
