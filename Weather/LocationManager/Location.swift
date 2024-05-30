

import CoreLocation
import CoreMotion


final class LocationManager:NSObject, CLLocationManagerDelegate {
    
    
    //MARK: - Properties
    
    private let locationManager = CLLocationManager()
    private let motionManager = CMMotionActivityManager()
    
    //MARK: - LyfeCycle
    
    override init() {
        super.init()
        configurate()
    }
    
    
    //MARK: - Method
    
    private func configurate() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func requestPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted, .denied:
                print("Please give your location")
            case .authorizedAlways, .authorizedWhenInUse:
                mapView.showsUserLocation = true
                locationManager.delegate = self
            @unknown default:
                fatalError("Error")
            }
        } else {
            fatalError("Oyyps")
        }
    }
    
    
    func start() {
        setActiveMode(true)
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        motionManager.startActivityUpdates(to: .main, withHandler: { [weak self] activity in
            self?.setActiveMode(activity?.cycling ?? false)
        })
    }
    
    func setActiveMode(_ value:Bool) {
        if value {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.distanceFilter = 100
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.distanceFilter = CLLocationDistanceMax
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
// Подумать нужно ли мне это?
//        let userDefaults = UserDefaults.standard
//        let key = "location"
//        let count = userDefaults.integer(forKey: key) + 1
//        userDefaults.set(count, forKey: key)
//        userDefaults.synchronize()
//        print("didUpdateLocations #\(count)")
        
        // Проверяем, есть ли доступные местоположения в массиве locations
        guard let location = locations.last else { return }
        
        // Создаем геокодер
        let geocoder = CLGeocoder()
        // Выполняем обратное геокодирование для получения названия города
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            // Извлекаем первый найденный местоположением адрес (обычно это самый точный результат)
            if let placemarks = placemarks?.first {
                // Извлекаем название города из адреса
                if let city = placemarks.location {
                    // Сохраняем название города в UserDefaults под ключом "city"
                    UserDefaults.standard.set(city, forKey: "city")
                    //чтобы сразу записывалось значение
                    UserDefaults.standard.synchronize()
                    
                    //проверочка
                    print("City: \(city)")
                    
                }
            }
        }
    }
}
    
