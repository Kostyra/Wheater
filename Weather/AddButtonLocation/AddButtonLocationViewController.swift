import UIKit

final class AddButtonLocationViewController:UIViewController, UISearchResultsUpdating {

    
    enum Section {
        case main
    }
    //MARK:  - Properties
   
    
    var selectedCities: [[String]] = [] {
        didSet {
            saveSelectedCities()
        }
    }
    
    
    weak var delegate: AddButtonLocationDelegate?
    
    private var timer = Timer()
    private var searchController: UISearchController?
    private var wModel:WModel?
    private let tableView = UITableView()
    
    private var dataSource:UICollectionViewDiffableDataSource<Int, [String]>! = nil
    private var collectionView:UICollectionView! = nil

    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.removeObject(forKey: "idCity")
        loadSelectedCities()
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        view.addSubview(tableView)
        
        configureHierarchy()
        configureDataSource()
        collectionView.delegate = self
        collectionView.reloadData()
        
        view.backgroundColor = .white
        largeTitle()
    }
        

 
//MARK: - Method
    
    private func loadSelectedCities() {
        if let savedCities = UserDefaults.standard.object(forKey: "idCity") as? [[String]] {
            selectedCities = savedCities
        }
    }
    
    private func saveSelectedCities() {
        UserDefaults.standard.set(selectedCities, forKey: "idCity")
    }
    
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
    

    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, [String]>(collectionView: collectionView) {
            (collectionView, indexPath, city) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellAddButton.idAddButton, for: indexPath) as! CollectionCellAddButton
            let city = self.selectedCities[indexPath.row]
            cell.configurationCellCollection(with: city)
            return cell
        }

        
        var snapshot = NSDiffableDataSourceSnapshot<Int, [String]>()
        snapshot.appendSections([0])
        snapshot.appendItems(selectedCities)
        dataSource?.apply(snapshot)
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
         guard let city = searchController.searchBar.text else { return }
         
//         timer.invalidate()
         if !city.isEmpty {
//             timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { [weak self] _ in
                 NetWorkManager.shared.getWeather(city: city) { model in
                     if model != nil {
                         self.wModel = model
                         
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.collectionView.isHidden = true
                            self.tableView.isHidden = false
                        }
                     }
                 }
//             })
         } else {
             wModel = nil
             tableView.reloadData()
         }
    }
}


//MARK: - extension

extension AddButtonLocationViewController:UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wModel != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = wModel?.city?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let selectedCity = wModel?.city?.name else { return }
        guard let selectTemp = (wModel?.list?.first?.main?.temp?.description) else { return }
        guard let selectTempMin = wModel?.list?.first?.main?.temp_min?.description else { return }
        guard let selectTempMax = wModel?.list?.first?.main?.temp_max?.description else { return }
        guard let selectDescription = wModel?.list?.first?.weather?.first?.description?.description else { return }
        
        let newCity = [selectedCity, selectTemp , selectTempMin, selectTempMax, selectDescription]
        if !selectedCities.contains(where: { $0[0]  == selectedCity}) {
            selectedCities.append(newCity)
        } else {
            print("the city already exists")
        }
        //selectedCities.append([selectedCity, selectTemp , selectTempMin, selectTempMax, selectDescription])
        var snapshot = NSDiffableDataSourceSnapshot<Int, [String]>()
            snapshot.appendSections([0])
//        selectedCities.enumerated().forEach { index, city in
//             snapshot.appendItems([city], toSection: 0) }
        snapshot.appendItems(selectedCities)
        dataSource.apply(snapshot)
 
        wModel = nil
//        tableView.reloadData()
        tableView.isHidden = true
        searchController?.searchBar.text = nil
        searchController?.isActive = false
//        collectionView.reloadData()
        collectionView.isHidden = false

    }
}



extension AddButtonLocationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectionLocation = selectedCities[indexPath.row]
//        if let selectedCities = dataSource.itemIdentifier(for: indexPath) {
//            print(selectedCities)
//        }
        delegate?.didSelectCities([selectionLocation])
        print("\(selectionLocation) + 1")
        dismiss(animated: true, completion: nil)
    }
}

