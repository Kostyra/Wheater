import Foundation



protocol AddButtonLocationModelProtocol {
    func switchToNextFlow()
    func searchCity(city: String)
    var stateChanged: ((AddButtonLocationModel.State) ->())? { get set }
    var city: City? { get set }
    var cities: [City] { get set }
    func didSelect()
    func getCities()
}

final class AddButtonLocationModel {
    
    enum State {
        case loading
        case done(city: City?)
        case error(error: String)
        case loadCity
        case duplicationCity
        case loadCities(cities:[City])
    }

    
    //MARK: - Properties
    var stateChanged: ((State) ->())?
    
    private weak var coordinator: IAddButtonLocationCoordinator?
     var city: City?
     var cities: [City] = []
    
    private var state: State = .loading {
        didSet {
            self.stateChanged?(self.state)
        }
    }
    
    
    //MARK: - Life Cycle
    
    init( coordinator: IAddButtonLocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    
    //MARK: - Properties
    
    private func addUniqueCity(_ city: City) {
        let coreDataHandler = CoreDataHandler.shared
         if !cities.contains(where: { $0.id == city.id }) {
             cities.append(city)
             state = .loadCity
             coreDataHandler.saveCityDataToCoreData(cityData: city)
         } else {
             state = .duplicationCity
         }
     }
    
}



extension AddButtonLocationModel: AddButtonLocationModelProtocol {
    
    func getCities() {
        NetWorkManager.shared.getWeatherForSavedCity { result in
            switch result {
            case .success(let cities):
                DispatchQueue.main.async {
                    self.state = .loadCities(cities: cities)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .error(error: error.localizedDescription)
                }
            }
        }
    }
    
    func switchToNextFlow() {
        }

    func searchCity(city: String) {
        if !city.isEmpty {
            NetWorkManager.shared.getWeather(city: city) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let city):
                    self.city = city
                    DispatchQueue.main.async {
                        self.state = .done(city: city)
                    }
                case .failure(let error):
                    self.state = .error(error: error.localizedDescription)
                }
            }
        } else {
            self.state = .done(city: nil)
        }
    }
    
    func didSelect() {
        guard let city = city else { return }
        addUniqueCity(city)
    }
}

