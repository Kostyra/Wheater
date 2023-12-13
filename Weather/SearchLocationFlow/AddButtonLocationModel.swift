import Foundation



protocol AddButtonLocationModelProtocol {
    func switchToNextFlow()
    func searchCity(city: String)
    var stateChanged: ((AddButtonLocationModel.State) ->())? { get set }
    var city: City? { get set }
    var cities: [City] { get set }
}

final class AddButtonLocationModel {
    
    enum State {
        case loading
        case done(city: City?)
        case error(error: String)
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
}

extension AddButtonLocationModel: AddButtonLocationModelProtocol {
    func switchToNextFlow() {
        
    }
    
    func searchCity(city: String) {
        if !city.isEmpty {
//             timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { [weak self] _ in
            NetWorkManager.shared.getWeather(city: city) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let city):
                    self.city = city
                    print(city)
                    
                    DispatchQueue.main.async {
                        self.state = .done(city: city)
                    }
                case .failure(let error):
                    state = .error(error: error.localizedDescription)
                }

            }
        } else {
            state = .done(city: nil)
        }
    }
    
    
}
