import UIKit

final class AddButtonLocationViewController:UIViewController, UISearchResultsUpdating {

    
    //MARK:  - Properties

    weak var delegate: AddButtonLocationDelegate?
    
    private var timer = Timer()
    private var searchController: UISearchController?
    private var wModel:WModel?
    private var city: City?
    private var cities: [City] = []
    private let tableView = UITableView()
    
    
    private lazy var dataSource = makeDataSource()
    private var collectionView:UICollectionView! = nil

    typealias DataSource = UICollectionViewDiffableDataSource<Int, City>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, City>
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "idCity")
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        view.addSubview(tableView)
        
        configureHierarchy()
        collectionView.delegate = self
        collectionView.reloadData()
        
        view.backgroundColor = .white
        largeTitle()
    }
        

 
//MARK: - Method
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellAddButton.idAddButton, for: indexPath) as! CollectionCellAddButton
            let city = self.cities[indexPath.row]
            cell.configurationCellCollection(with: city)
            return cell
        }
    }
    
    private func makeSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(cities, toSection: 0)
        return snapshot
    }
    
//    private func loadSelectedCities() {
//        if let savedCities = UserDefaults.standard.object(forKey: "idCity") as? [[String]] {
//            selectedCities = savedCities
//        }
//    }
//
//    private func saveSelectedCities() {
//        UserDefaults.standard.set(selectedCities, forKey: "idCity")
//    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CollectionCellAddButton.self, forCellWithReuseIdentifier: CollectionCellAddButton.idAddButton)
        view.addSubview(collectionView)
    }
    
   
    private func largeTitle() {
        navigationItem.title = "Wheather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
     func updateSearchResults(for searchController: UISearchController) {
         guard let searchText = searchController.searchBar.text else { return }
         
//         timer.invalidate()
         if !searchText.isEmpty {
//             timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { [weak self] _ in
             NetWorkManager.shared.getWeather(city: searchText) { [weak self] result in
                 guard let self = self else { return }
                 switch result {
                 case .success(let city):
                     self.city = city
//                     self.addUniqueCity(city)
                     print(city)
                     
                     DispatchQueue.main.async {
                         self.tableView.reloadData()
                         self.collectionView.isHidden = true
                         self.tableView.isHidden = false
                     }
                 case .failure(let error):
                     print(error.localizedDescription)
                 }

             }
         } else {
             city = nil
             self.collectionView.isHidden = false
            self.tableView.isHidden = true
             tableView.reloadData()
         }
    }
    
    private func addUniqueCity(_ id: City) {
        if !cities.contains(where: { $0.id == city?.id }) {
            cities.append(city!)
        } else {
            print("City already exists")
        }
    }

}



//MARK: - extension

extension AddButtonLocationViewController:UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return city != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = city?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addUniqueCity(city!)
        let snapshot = makeSnapshot()
        dataSource.apply(snapshot)
        city = nil
        searchController?.searchBar.text = nil
        searchController?.isActive = false
        tableView.isHidden = true
        collectionView.isHidden = false

    }
}



extension AddButtonLocationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectionLocation = cities[indexPath.row]
        delegate?.didSelectCities(selectionLocation)
        print("\(selectionLocation) + delegate")
        dismiss(animated: true, completion: nil)
    }
}

