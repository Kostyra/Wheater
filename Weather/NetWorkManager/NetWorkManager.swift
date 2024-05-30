

import Foundation

enum NetworkError: Error {
    case noInternet
    case noData
    case somethingWentWrong
}


final class NetWorkManager {
    
    //MARK: - Life Cycle
    
    private init() {}
    static let shared = NetWorkManager()
    private let celsius: Float = 273.15
    
    //MARK: - Method
    
    func getWeather (city: String, completion: @escaping(Result<City, NetworkError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.openweathermap.org"
        urlComponent.path = "/data/2.5/forecast"
        urlComponent.queryItems = [URLQueryItem(name: "q", value: city),
                                   URLQueryItem(name: "appid", value: "435a92f7433a18e7f202258beba86e7d")]
        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "Get"
        
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.noInternet))
                return
            }
            
            let code = (response as? HTTPURLResponse)?.statusCode
            if code != 200 {
                print("Status \(String(describing: data))")
                completion(.failure(.noInternet))
                return
            }
            
            guard let data = data else {
                print("data is nil")
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderWModel = try decoder.decode(WModel.self, from: data)
                let city = City(
                    dt: decoderWModel.list?.compactMap {$0.dt},
                    id: decoderWModel.city?.id,
                    name: decoderWModel.city?.name ?? "Not",
                    descriptionName: decoderWModel.list?.first?.weather?.first?.description,
                    wheather: decoderWModel.list?.first?.weather?.first?.main,
                    temp: round((decoderWModel.list?.first?.main?.temp)! - self.celsius),
                    tempMax: round((decoderWModel.list?.first?.main?.temp_max)! - self.celsius),
                    tempMin: round((decoderWModel.list?.first?.main?.temp_min)! - self.celsius),
                    lat: decoderWModel.city?.coord.lat,
                    lon: decoderWModel.city?.coord.lon,
                    tempList: decoderWModel.list?.compactMap { round(($0.main?.temp)! - self.celsius)},
                    dt_txt: decoderWModel.list?.compactMap { $0.dt_txt},
                    icon: decoderWModel.list?.compactMap { $0.weather?.first?.icon },
                    dt_txtDate: decoderWModel.list?.compactMap { $0.dt_txt },
                    tempMaxList: decoderWModel.list?.compactMap { round(($0.main?.temp_max)! - self.celsius)},
                    tempMinlist: decoderWModel.list?.compactMap { round(($0.main?.temp_min)! - self.celsius)},
                    descriptionList: decoderWModel.list?.compactMap {$0.weather?.first?.description}
                )
                completion(.success(city))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.somethingWentWrong))
            }
        }.resume()
        
    }
}

extension NetWorkManager {
    func getWeatherForSavedCity(completion: @escaping(Result<[City], NetworkError>) -> Void) {
        if let savedCities = CoreDataHandler.shared.fetchCityEntitiesForCityName() {
            guard savedCities.count > 0 else {
                completion(.failure(.noData))
                return
            }
            var cities:[City] = []
            let group = DispatchGroup()
            savedCities.forEach { cityEntity in
                group.enter()
                guard let name = cityEntity.name else { return }
                getWeather(city: name) { result in
                    switch result {
                    case .success(let city):
                        cities.append(city)
                        group.leave()
                    case .failure(let error):
                        print(error.localizedDescription)
                        group.leave()
                    }
                }
            }
            group.notify(queue: .global()) {
                completion(.success(cities))
            }
        } else {
            completion(.failure(.somethingWentWrong))
        }
    }
}
