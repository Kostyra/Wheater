import UIKit

final class AddButtonLocationViewController:UIViewController, UISearchResultsUpdating {

    
    //MARK:  - Properties

    weak var delegate: AddButtonLocationDelegate?
    
    private var searchController: UISearchController?
    private let tableView = UITableView()
    private var viewModel:AddButtonLocationModelProtocol
    
    private lazy var dataSource = makeDataSource()
    private var collectionView:UICollectionView! = nil

    typealias DataSource = UICollectionViewDiffableDataSource<Int, City>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, City>
    
    
    //MARK: - Life Cycle
    
    init(viewModel: AddButtonLocationModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        bindingModel()
    }
    
    
        

 
//MARK: - Method
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellAddButton.idAddButton, for: indexPath) as! CollectionCellAddButton
            let city = self.viewModel.cities[indexPath.row]
            cell.configurationCellCollection(with: city)
            return cell
        }
    }
    
    private func makeSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.cities, toSection: 0)
        return snapshot
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
         viewModel.searchCity(city: searchText)
    }
    
//    private func addUniqueCity(_ id: City) {
//        if !cities.contains(where: { $0.id == city?.id }) {
//            cities.append(city!)
//        } else {
//            print("City already exists")
//        }
//    }
    private func bindingModel() {
        viewModel.stateChanged = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                ()
            case .done(let city):
                guard city != nil  else {
                    self.collectionView.isHidden = false
                    self.tableView.isHidden = true
                    self.tableView.reloadData()
                    return
                }
                let snapshot = self.makeSnapshot()
                dataSource.apply(snapshot)
                self.tableView.reloadData()
                self.collectionView.isHidden = true
                self.tableView.isHidden = false
            case .error(let error):
                print(error)
            }
        }
    }
}



//MARK: - extension

extension AddButtonLocationViewController:UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.city != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = viewModel.city?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.addUniqueCity(city!)
        let snapshot = makeSnapshot()
        dataSource.apply(snapshot)
//        viewModel.city = nil
        searchController?.searchBar.text = nil
        searchController?.isActive = false
        tableView.isHidden = true
        collectionView.isHidden = false

    }
}



extension AddButtonLocationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectionLocation = viewModel.cities[indexPath.row]
        delegate?.didSelectCities(selectionLocation)
        print("\(selectionLocation) + delegate")
        dismiss(animated: true, completion: nil)
    }
}

