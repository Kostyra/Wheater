

import Foundation


struct ListWModel:Codable {
    var dt: Float?
    var main: MainWModel?
    var weather: [WheatherModel]?
}
