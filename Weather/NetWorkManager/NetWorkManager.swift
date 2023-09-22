

import Foundation


final class NetWorkManager {
    
    //MARK: - Life Cycle
    
    private init() {}
    
    static let shared = NetWorkManager()
    

    //MARK: - Method
    
    func getWeather (city: String , result: @escaping((WModel?) -> ())) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.openweathermap.org"
        urlComponent.path = "data/2.5/forecast"
        urlComponent.queryItems = [URLQueryItem(name: "q", value: city),
                                   URLQueryItem(name: "appid", value: "435a92f7433a18e7f202258beba86e7d")]
        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "Get"
        
        let task = URLSession(configuration: .default)
//        task.dataTask(with: request) { (data, responce, error) in
//            if error == nil {
//                let decoder = JSONDecoder()
//                var decoderWModel:WModel?
//
//                if data != nil {
//                    decoderWModel = try? decoder.decode(WModel.self, from: data!)
//                }
//                result(decoderWModel)
//            } else {
//                print(error as Any)
//            }
//        }.resume()
        task.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   print(error.localizedDescription)
                   result(nil)
                   return
               }
            
            let code = (response as? HTTPURLResponse)?.statusCode
            if code != 200 {
                print("Status \(String(describing: data))")
                result(nil)
                return
            }
               
               guard let data = data else {
                   print("data is nil")
                   result(nil)
                   return
               }
               
               do {
                   let decoder = JSONDecoder()
                   let decoderWModel = try decoder.decode(WModel.self, from: data)
                   result(decoderWModel)
               } catch {
                   print(error.localizedDescription)
                   result(nil)
               }
           }.resume()
        
    }
}
