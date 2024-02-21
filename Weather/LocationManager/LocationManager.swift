
import CoreLocation

final class LocationManager:NSObject, CLLocationManagerDelegate {
    
    
    //MARK: - Properties
    private let locationManager = CLLocationManager()
    
    var cityUpdateHandler: ((String) -> Void)?
    var location: CLLocation = CLLocation()
    
    //MARK: - LyfeCycle
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: - Method
    
    func requestPermission(withCompletion completion: ((String) -> Void)?) {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                print("notDetermined")
            case .restricted, .denied:
                print("Please give your location")
            case .authorizedAlways, .authorizedWhenInUse:
                print("authorizedAlways")
                locationManager.startUpdatingLocation()
            @unknown default:
                fatalError("Error")
            }
        } else {
            fatalError("Oyyps")
        }
        cityUpdateHandler = completion
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways  || status == .authorizedWhenInUse {
            manager.requestLocation()
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location , preferredLocale: Locale(identifier: "en")) { (placemarks, error) in
                if let error = error {
                    print("Ошибка геокодирования: \(error.localizedDescription)")
                    return
                }
                if let placemark = placemarks?.first {
                    if let cityName = placemark.locality {
                        self.cityUpdateHandler?(cityName)
                    }
                }
            }
        }
//        print(location.coordinate.latitude)
        manager.stopUpdatingLocation()
    }
}

