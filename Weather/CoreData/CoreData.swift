import CoreData
import Foundation




class CoreDataHandler {
    static let shared = CoreDataHandler()
    // Создание CoreData stack
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CityEntity")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func saveCityDataToCoreData(cityData: City) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", cityData.name!)
        do {
            let existingCity = try context.fetch(fetchRequest).first
            if let existingCity = existingCity {
                print("City \(String(describing: cityData.name)) already exists in Core Data")
                return
            }
            let newCityEntity = CityEntity(context: context)
            newCityEntity.name = cityData.name
            
            try context.save()
            print("City data saved to Core Data")
        } catch {
            print("Failed to save city data to Core Data: \(error)")
        }
    }
    
    func fetchCityEntitiesForCityName() -> [CityEntity]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        do {
            let cityEntities = try context.fetch(fetchRequest)
            return cityEntities
        } catch {
            print("Failed to fetch CityEntity objects: \(error)")
            return nil
        }
    }
    
    func deleteCityEntityFromCoreData(cityName: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", cityName)
        
        do {
            if let cityEntity = try context.fetch(fetchRequest).first {
                context.delete(cityEntity)
                try context.save()
                print("CityEntity \(cityName) deleted from Core Data")
            } else {
                print("CityEntity \(cityName) not found in Core Data")
            }
        } catch {
            print("Failed to delete CityEntity from Core Data: \(error)")
        }
    }
}
