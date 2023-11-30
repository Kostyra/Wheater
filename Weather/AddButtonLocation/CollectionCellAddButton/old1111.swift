//import UIKit
//
//final class AddButtonLocationViewController:UIViewController, UISearchResultsUpdating {
//
//    //MARK:  - Properties
//
//
//    private var timer = Timer()
//    private var searchController: UISearchController?
//    private var wModel:WModel?
//
//    var selectedCities: [String] = []
//    private let tableView = UITableView()
//
//    private lazy var layoutHorizontal: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
//        return layout
//    }()
//
//    private lazy var collectionView: UICollectionView  = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutHorizontal)
//        collectionView.register(CollectionCellAddButton.self, forCellWithReuseIdentifier: CollectionCellAddButton.idAddButton)
//        collectionView.backgroundColor = .cyan
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//
//
//
//
//
//    //MARK: - Life Cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.frame = view.bounds
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.reloadData()
//        view.addSubview(tableView)
//
//
//        setupCollectionView()
//        collectionViewLayOut()
//        collectionView.reloadData()
//
//
//
//        view.backgroundColor = .white
//        largeTitle()
//    }
//
//
//
////MARK: - Method
//
//    private func setupCollectionView() {
//        collectionView.isHidden = true
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//
//    private func collectionViewLayOut() {
//        view.addSubview(collectionView)
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//        ])
//    }
//
//
//    private func largeTitle() {
//        navigationItem.title = "Wheather"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        searchController = UISearchController(searchResultsController: nil)
//        searchController?.searchResultsUpdater = self
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//    }
//
//     func updateSearchResults(for searchController: UISearchController) {
//         guard let city = searchController.searchBar.text else { return }
//         timer.invalidate()
//         if !city.isEmpty {
//             timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self] _ in
//                 NetWorkManager.shared.getWeather(city: city) { model in
//                     if model != nil {
//                        self?.wModel = model
//
//                        DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                            self?.collectionView.isHidden = true
//                            self?.tableView.isHidden = false
//                        }
//                     }
//                 }
//             })
//         } else {
//             wModel = nil
////             searchCity = []
//             tableView.reloadData()
//         }
//    }
//
//}
//
//
////MARK: - extension
//
//extension AddButtonLocationViewController:UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return wModel != nil ? 1 : 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
//        cell.textLabel?.text = wModel?.city?.name
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let selectedCity = wModel?.city?.name else { return }
//        selectedCities.append(selectedCity)
//        UserDefaults.standard.set(selectedCities, forKey: "city")
//        print(selectedCities)
//        wModel = nil
//        tableView.reloadData()
//        tableView.isHidden = true
//        searchController?.searchBar.text = nil
//        searchController?.isActive = false
//
//        collectionView.reloadData()
//        collectionView.isHidden = false
////        searchController?.reloadInputViews()
////        tableView.reloadData()
//    }
//}
//
//
//extension AddButtonLocationViewController:UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return selectedCities.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellAddButton.idAddButton, for: indexPath) as! CollectionCellAddButton
//        let city = selectedCities[indexPath.item]
//            cell.configurationCellCollection(with: city)
//        return cell
//    }
//
//
//}
//
//extension GeneralViewController:UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let countItem: CGFloat = 6
//        let accessibleWidth = collectionView.frame.width - 20
//        let widthItem = (accessibleWidth / countItem)
//        return CGSize(width: widthItem, height: 60)
//
//
//    }
//}
//
