
import Foundation

struct City: Hashable {
    let dt: [Float]?
    let id: Int?
    let name: String?
    let descriptionName: String?
    let wheather: String?
    let temp: Float?
    let tempMax: Float?
    let tempMin: Float?
    let lat: Float?
    let lon: Float?
    
    let tempList: [Float]?
    let dt_txt:[String]?
    let icon: [String]?
    
    let dt_txtDate:[String]?
    let tempMaxList: [Float]?
    let tempMinlist: [Float]?
    let descriptionList:[String]?
}

struct CityOnly: Hashable {
    let name: String
}
