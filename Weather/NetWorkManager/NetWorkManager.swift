

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
                                    id: decoderWModel.city?.id,
                                   name: decoderWModel.city?.name ?? "Not",
                                   icon: decoderWModel.list?.first?.weather?.first?.icon,
                                   description: decoderWModel.list?.first?.weather?.first?.description,
                                    wheather: decoderWModel.list?.first?.weather?.first?.main,
                                   temp: decoderWModel.list?.first?.main?.temp,
                                   tempMax: decoderWModel.list?.first?.main?.temp_max,
                                   tempMin: decoderWModel.list?.first?.main?.temp_min)

                   completion(.success(city))
               } catch {
                   print(error.localizedDescription)
                   completion(.failure(.somethingWentWrong))
               }
           }.resume()
        
    }
}

