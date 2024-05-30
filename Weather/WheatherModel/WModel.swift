
import Foundation


struct WModel:Codable {
    var cod: String?
    var message: Float?
    var cnt: Float
    var list: [ListWModel]?
    var city: CityModel?
     
}

struct ListWModel:Codable {
    var dt: Float?
    var dt_txt: String?
    var main: MainWModel?
    var weather: [WheatherModel]?
}

struct MainWModel:Codable {
    var temp: Float?
    var temp_min: Float?
    var temp_max: Float?
}

struct CityModel:Codable {
    var id: Int?
    var name: String?
    var country: String?
    var coord: CoordinateCity
}

struct WheatherModel:Codable {
    var main: String?
    var description: String?
    var icon: String?
}

struct CoordinateCity: Codable {
    let lat: Float?
    let lon: Float?
}
