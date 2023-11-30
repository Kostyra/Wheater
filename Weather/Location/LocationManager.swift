

import CoreLocation
//import CoreMotion


final class LocationManager:NSObject, CLLocationManagerDelegate {
    
    
    //MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    //MARK: - LyfeCycle
    
    override init() {
        super.init()
        requestPermission()
        locationManager.delegate = self

        
    }
    
    
    //MARK: - Method
        
    func requestPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
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
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways  || status == .authorizedWhenInUse{
            if let location = locationManager.location {
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                    if let error = error {
                        // Обработка ошибки геокодирования
                        print("Ошибка геокодирования: \(error.localizedDescription)")
                        return
                    }
                    if let placemark = placemarks?.first {
                        if let cityName = placemark.locality {
                            // Сохраняем название города в UserDefaults под ключом "city"
                            UserDefaults.standard.set(cityName, forKey: "city")
                              //чтобы сразу записывалось значение
                            UserDefaults.standard.synchronize()
                            // Имя города доступно в cityName
                            print("Имя города: \(cityName)")
                        }
                    }
                }
            }
        }
    }

  
}
    
