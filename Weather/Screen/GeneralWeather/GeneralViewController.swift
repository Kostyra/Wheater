
import UIKit
import SwiftUI

protocol  AddButtonLocationDelegate:AnyObject {
    func didSelectCities(_ city: City)
    
}

final class GeneralViewController: UIViewController {

    //MARK: - Enum
    enum Section: Int, CaseIterable {
        case one
        case two
        case three
    }
    
    enum Cell: Hashable {
        case top(city: City)
        case middle(time: String, image: String, temp: Float)
        case bottom(date: String, descriptions: String ,image: String, tempMin: Float, tempMax: Float)
    }

    //MARK: - Properties
    private var changePropertiesController: ChangePropertiesController?
    private var viewModel:IGeneralViewModel
    
    private lazy var dataSource = configureDataSource()
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>
     var collectionView: UICollectionView! = nil
    private lazy var wheatherEmptyView: WheatherEmpty = {
        let view = WheatherEmpty()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var notInternet: NotInternet = {
        let view = NotInternet()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dt_txtsUI: [String] = []
    private var tempListUI: [Float] = []
    private var cityUI: String?
    private var dt_txtsUIDetail: [String] = []
    private var tempListUIDetail: [Float] = []
    
    private var previousThemeStateTemp: Bool = UserDefaults.standard.bool(forKey: "isTemp")

    //MARK: - Life Cycle
    
    
    init(viewModel: IGeneralViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        buttonItem()
        changeProperties()
        setupWheatherEmptyView()
        binding()
        viewModel.getWeather()
        view.backgroundColor = Palette.viewDinamecColor1
        collectionView.backgroundColor = Palette.viewDinamecColor1
        updateCellsForThemeChange()
        navigationController?.navigationBar.barTintColor = Palette.viewDinamecColor1
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        view.backgroundColor = Palette.viewDinamecColor1
        collectionView.backgroundColor = Palette.viewDinamecColor1
        navigationController?.navigationBar.barTintColor = Palette.viewDinamecColor
        updateCellsForThemeChange()
        let currentThemeStateTemp = UserDefaults.standard.bool(forKey: "isTemp")
          if currentThemeStateTemp != previousThemeStateTemp {
              updateCellsForTempChangeNow()
              previousThemeStateTemp = currentThemeStateTemp
          }
    }
    
    func updateCellsForThemeChange() {
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section)) as? GeneralSectionEveryDate {
                    cell.updateTextColor()
                }
                if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section)) as? GeneralSectionDetailCell {
                    cell.updateTextColor()
                }
                if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section)) as? GeneralSectionNowCell {
                    cell.updateTextColor()
                }
            }
        }
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: Section.two.rawValue)) as? GeneralSectionDetailHeader {
            headerView.updateTextColor()
        }
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: Section.three.rawValue)) as? GeneralSectionEveryDateHeader {
            headerView.updateTextColor()
        }

    }
    
    func updateCellsForTempChangeNow() {
        let isTemp = UserDefaults.standard.bool(forKey: "isTemp")
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section)) as? GeneralSectionNowCell {
                    cell.updateTemperatureForTheme(isTemp: isTemp)
                }
                if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section)) as? GeneralSectionEveryDate {
                    cell.updateTemperatureForTheme(isTemp: isTemp)
                }
                if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section)) as? GeneralSectionDetailCell {
                    cell.updateTemperatureForTheme(isTemp: isTemp)
                }
            }
            
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    func setupWheatherEmptyView() {
        view.addSubview(wheatherEmptyView)
        view.addSubview(notInternet)
        NSLayoutConstraint.activate([
            wheatherEmptyView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            wheatherEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wheatherEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            wheatherEmptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            notInternet.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            notInternet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notInternet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notInternet.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
    }
    
    private func binding() {
        viewModel.stateChanged = { [weak self] state in
            guard let self else { return }
            switch state {
            case .allow(let city):
                let snapshot = self.makeSnapshot(city: city)
                self.dataSource.supplementaryViewProvider = self.makeHeaderProvider()
                self.dataSource.apply(snapshot)
                wheatherEmptyView.isHidden = true
            case .notAllow:
                wheatherEmptyView.isHidden = false
            case .loading:
                ()
            case .notInternet:
                DispatchQueue.main.async {
                    self.notInternet.isHidden = false
                }
            }
        }
    }
    
    private func changeProperties()  {
        let imageSettings = UIImage(systemName: "gearshape")
        let button = UIBarButtonItem(image: imageSettings, style: .plain, target: self, action: #selector(buttonChangeProperties))
        button.tintColor = .blue
        navigationItem.rightBarButtonItems?.insert(button, at: 0)
    }
    
    private func buttonItem()  {
        let imagePlus = UIImage(systemName: "plus")
        let button = UIBarButtonItem(image: imagePlus, style: .done, target: self, action: #selector(buttonAddWheather))
        button.tintColor = .blue
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func buttonAddWheather() {
        viewModel.nextFlow(delegate: self)
    }
    
    @objc func buttonChangeProperties() {
//        viewModel.nextFlowProperties()
        let viewNC = ChangePropertiesController()
        navigationController?.pushViewController(viewNC, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.delegate = self
        collectionView.register(GeneralSectionNowCell.self, forCellWithReuseIdentifier: GeneralSectionNowCell.idGeneral1)
        collectionView.register(GeneralSectionDetailCell.self, forCellWithReuseIdentifier: GeneralSectionDetailCell.idGeneral2)
        collectionView.register(GeneralSectionEveryDate.self, forCellWithReuseIdentifier: GeneralSectionEveryDate.idGeneral3)
        collectionView.register(GeneralSectionDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2)
        collectionView.register(GeneralSectionEveryDateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionEveryDateHeader.idGeneralHeader3)
        view.addSubview(collectionView)
    }

    private func layoutSection(for section: Section, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch section {
        case .one:
            return oneSection()
        case .two:
            return twoSection()
        case .three:
            return threeSection()
        }
    }
    
    private func oneSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    private func twoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 8, trailing: 8)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
                                                     heightDimension: .estimated(88))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 20)
        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]
        return layoutSection
    }

    private func threeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(86))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 0, trailing: 20)
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHEaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHEaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }

    private func configureDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, cell in
            guard self != nil else {
                return UICollectionViewCell()
            }
            switch cell {
            case .top(city: let city):
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionNowCell.idGeneral1, for: indexPath) as? GeneralSectionNowCell  
                cell?.configurationCellCollection(with: city)
                return cell
            case .middle(let time, let image, let temp) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionDetailCell.idGeneral2, for: indexPath) as?
                GeneralSectionDetailCell
                cell?.configurationCellCollection(with: time, with: image, with: temp)
                return cell
            case .bottom(  let date, let descriptions, let image,let tempMin, let tempMax) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionEveryDate.idGeneral3, for: indexPath) as?
                GeneralSectionEveryDate
                cell?.configurationCellCollection(with: date, with: descriptions, with: image, with: tempMin, with: tempMax)
                return cell
            }
        } 
    }
        
    func makeSnapshot(city:City) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.one])
        snapshot.appendItems([.top(city: city)], toSection: .one)
        cityUI = city.name ?? ""
        snapshot.appendSections([.two])
        if let dt_txts = city.dt_txt, let icons = city.icon, let tempList = city.tempList {
            
            var uniqueDates = Set<String>()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "E"
            for (index, dt_txt) in dt_txts.enumerated() {
                if let date = dateFormatter.date(from: dt_txt) {
                    let formattedDate = outputDateFormatter.string(from: date)

                    if uniqueDates.contains(formattedDate) {
                        continue
                    } else {
                        uniqueDates.insert(formattedDate)
                    }

                    if index < icons.count && index < tempList.count {
                        snapshot.appendItems([.middle(time: formattedDate, image: icons[index], temp: tempList[index])], toSection: .two)
                        dt_txtsUI.append(formattedDate)
                        tempListUI.append(tempList[index])
                    }
                }
            }
        }
        snapshot.appendSections([.three])
        if  let dates = city.dt_txtDate, let icons = city.icon, let tempMin = city.tempMinlist, let tempMax = city.tempMaxList , let descriptions = city.descriptionList {
            for (index, dt_txtDate) in dates.enumerated() {
                if index < icons.count && index < tempMin.count && index < tempMax.count && index < descriptions.count {
                    snapshot.appendItems([.bottom(date: dt_txtDate,  descriptions: descriptions[index], image: icons[index], tempMin:tempMin[index], tempMax: tempMax[index])], toSection: .three)
                    dt_txtsUIDetail.append(dt_txtDate)
                    tempListUIDetail.append(tempMax[index])
                }
            }
        }
        return snapshot
    }

    func makeHeaderProvider() -> DataSource.SupplementaryViewProvider {
        return  { collectionView, kind, indexPath in
            switch Section(rawValue: indexPath.section).self {
               case .two:
                   guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2, for: indexPath) as? GeneralSectionDetailHeader else { return nil }
                sectionHeader.updateTextColor()
                   return sectionHeader
               case .three:
                   guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GeneralSectionEveryDateHeader.idGeneralHeader3, for: indexPath) as? GeneralSectionEveryDateHeader else { return nil }
                 sectionHeader.updateTextColor()
                   return sectionHeader
                
               default: break
               }
               fatalError("Cannot create the cell")
           }
        }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section  = Section(rawValue: sectionIndex)
            switch section {
            case .one:
                return self.oneSection()
            case .two:
                return self.twoSection()
            default:
                return self.threeSection()
            }
        }
        return layout
    }
}

extension GeneralViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) 
    {
        let section = Section(rawValue: indexPath.section)
        
        var convertToFarhenheit: Float
        var convertToFarhenheitNum: Float
        if previousThemeStateTemp {
            convertToFarhenheit =  9/5
            convertToFarhenheitNum = 32
        } else {
            convertToFarhenheit = 1
            convertToFarhenheitNum = 0
        }
        
        switch section {
        case .one:
            print(1)
        case .two:
            let swiftUIView = LineChartView(data: tempListUI.map{( $0 * convertToFarhenheit) + convertToFarhenheitNum } , labels: dt_txtsUI, cityOnly: cityUI )
            print(cityUI ?? "")
                 let viewController = UIHostingController(rootView: swiftUIView)
            viewController.view.backgroundColor = Palette.viewDinamecColor1
                 present(viewController, animated: true, completion: nil)
        case .three:
            let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = "E HH"
            let dates = dt_txtsUIDetail.compactMap { dateString in
                dateFormatterInput.date(from: dateString)
            }
            let formattedDates = dates.map { date in
                dateFormatterOutput.string(from: date)
            }
            let swiftUIView = LineChartDetail(data: tempListUIDetail.map{( $0 * convertToFarhenheit) + convertToFarhenheitNum }  , labels: formattedDates, cityOnly: cityUI )
            print(cityUI ?? "")
                 let viewController = UIHostingController(rootView: swiftUIView)
            viewController.view.backgroundColor = Palette.viewDinamecColor1
                 present(viewController, animated: true, completion: nil)
        default:
            break
        }
    }
}

extension GeneralViewController: AddButtonLocationDelegate {
    func didSelectCities(_ city: City) {
        dt_txtsUI = []
        tempListUI = []
        dt_txtsUIDetail = []
        tempListUIDetail = []
        viewModel.didTapCity(city)

    }

}


