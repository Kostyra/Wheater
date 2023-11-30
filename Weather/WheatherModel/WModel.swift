
import Foundation


final class WModel:Codable {
    var cod: String?
    var message: Float?
    var cnt: Float
    var list: [ListWModel]?
    var city: CityModel?
     
}
