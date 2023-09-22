////
//////import SwiftUI
////import UIKit
////
////final class GeneralViewController: UIViewController {
////
////
////    //MARK: - Properties
////    private let viewModel:IGeneralViewModel
////
////    private lazy var buttonFor10Day:CustomButton = {
////        let button = CustomButton(title: "10 дней",
////                                  titleColor: .black,
////                                  translatesAutoresizingMaskIntoConstraints: false,
////                                  cornerRadius: 0,
////                                  backgroundColor: .systemBackground,
////                                  action: buttonActionFor10rDay)
////        return button
////    }()
////
////    private lazy var buttonFor25Day:CustomButton = {
////        let button = CustomButton(title: "25 дней",
////                                  titleColor: .black,
////                                  translatesAutoresizingMaskIntoConstraints: false,
////                                  cornerRadius: 0,
////                                  backgroundColor: .systemBackground,
////                                  action: buttonActionFor25rDay)
////        return button
////    }()
////
////
////    private lazy var layoutVertical: UICollectionViewFlowLayout = {
////        let layout = UICollectionViewFlowLayout()
////        layout.minimumInteritemSpacing = 5
////        layout.minimumLineSpacing = 5
////        layout.scrollDirection = .vertical
////        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
////        return layout
////    }()
////
////    private lazy var layoutHorizontal: UICollectionViewFlowLayout = {
////        let layout = UICollectionViewFlowLayout()
////        layout.minimumInteritemSpacing = 5
////        layout.minimumLineSpacing = 5
////        layout.scrollDirection = .horizontal
////        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
////        return layout
////    }()
////
////    private lazy var horizontalCollectionView: UICollectionView = {
////        let collectionView = UICollectionView(
////            frame: .zero,
////            collectionViewLayout: layoutHorizontal)
////        collectionView.translatesAutoresizingMaskIntoConstraints = false
////        collectionView.register(GeneralSectionDetailCell.self, forCellWithReuseIdentifier: GeneralSectionDetailCell.idGeneral2)
//////        collectionView.register(GeneralSectionDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2)
////        return collectionView
////    }()
////
////    private lazy var verticalCollectionView: UICollectionView = {
////        let collectionView = UICollectionView(
////            frame: .zero,
////            collectionViewLayout: layoutVertical)
////        collectionView.translatesAutoresizingMaskIntoConstraints = false
////        collectionView.register(GeneralSectionEveryDate.self, forCellWithReuseIdentifier: GeneralSectionEveryDate.idGeneral3)
//////        collectionView.register(GeneralSectionEveryDateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionEveryDateHeader.idGeneralHeader3)
////
////        return collectionView
////    }()
////
////
////    //MARK: - Life Cycle
////    init(viewModel: IGeneralViewModel) {
////        self.viewModel = viewModel
////        super.init(nibName: nil, bundle: nil)
////    }
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        collectionViewLayOut()
////        setupcollectionView()
////        view.backgroundColor = .white
////    }
////
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////
////
////    //MARK: - Method
////
////    private func setupcollectionView() {
////        horizontalCollectionView.dataSource = self
////        horizontalCollectionView.delegate = self
////        verticalCollectionView.dataSource = self
////        verticalCollectionView.delegate = self
////    }
////
////    private func collectionViewLayOut() {
////        view.addSubview(buttonFor10Day)
////        view.addSubview(buttonFor25Day)
////        view.addSubview(horizontalCollectionView)
////        view.addSubview(verticalCollectionView)
////
////        NSLayoutConstraint.activate([
////            buttonFor10Day.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////            buttonFor10Day.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
////
////            horizontalCollectionView.topAnchor.constraint(equalTo: buttonFor10Day.bottomAnchor, constant: 0),
////            horizontalCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
////            horizontalCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
////            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 60),
////
////            buttonFor25Day.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 0),
////            buttonFor25Day.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
////
////
////            verticalCollectionView.topAnchor.constraint(equalTo: buttonFor25Day.bottomAnchor, constant: 0),
////            verticalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
////            verticalCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
////            verticalCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
////        ])
////    }
////}
////
////
////    //MARK: - Exrension
////
////extension GeneralViewController:UICollectionViewDataSource {
////
//////    func numberOfSections(in collectionView: UICollectionView) -> Int {
//////        return 1
//////    }
////
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        if collectionView == horizontalCollectionView {
////
////            return wheatherPhoto2.count
////        } else if collectionView == verticalCollectionView  {
////
////            return wheatherPhoto3.count
////        }
////        return 0
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        if collectionView == horizontalCollectionView  {
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionDetailCell.idGeneral2,
////                                                          for: indexPath) as! GeneralSectionDetailCell
////            let arreyCollection = wheatherPhoto2[indexPath.row]
////            cell.configurationCellCollection(image: arreyCollection)
////            return cell
////        } else if collectionView == verticalCollectionView {
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionEveryDate.idGeneral3,
////                                                          for: indexPath) as! GeneralSectionEveryDate
////            let arreyCollection = wheatherPhoto3[indexPath.row]
////            cell.configurationCellCollection(image: arreyCollection)
////            return cell
////        }
////        return UICollectionViewCell()
////    }
////
////    @objc private func buttonActionFor10rDay() {
////
////    }
////
////    @objc private func buttonActionFor25rDay() {
////
////    }
////
////}
////
////
//////MARK: - Extesion
////
////extension GeneralViewController:UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        if collectionView == horizontalCollectionView {
////            let countItem: CGFloat = 6
////            let accessibleWidth = collectionView.frame.width - 20
////            let widthItem = (accessibleWidth / countItem)
////            return CGSize(width: widthItem, height: 60)
////        } else if collectionView == verticalCollectionView {
////            let countItem: CGFloat = 1
////            let accessibleWidth = collectionView.frame.width - 20
////            let widthItem = (accessibleWidth / countItem)
////            return CGSize(width: widthItem, height: 56)
////        }
////        return CGSize.zero
////    }
////
////}
////
////
////
////
////var wheatherPhoto1: [UIImage] = [
////    UIImage(named: "0")!,
////    UIImage(named: "0")!,
////    UIImage(named: "0")!,
////    UIImage(named: "0")!,
////
////]
////
////var wheatherPhoto2: [UIImage] = [
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////    UIImage(named: "1")!,
////
////]
////
////var wheatherPhoto3: [UIImage] = [
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////    UIImage(named: "2")!,
////]
////
////
////
////
////
//
//
//
//
////import SwiftUI
//import UIKit
//
//final class GeneralViewController: UIViewController {
//
//    
//    //MARK: - Enum
//    enum Section: Int, CaseIterable {
//        case one
//        case two
//        case three
//    }
//    
//    
//    
//    //MARK: - Properties
//    
//    private let viewModel:IGeneralViewModel
//    private var dataSource:UICollectionViewDiffableDataSource<Section, Int>! = nil
//    private var collectionView: UICollectionView! = nil
//    
//    //MARK: - Life Cycle
//    
//    init(viewModel: IGeneralViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .orange
//        setupCollectionView()
//        configureDataSource()
//        reloadData()
//    }
//     
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    //MARK: - Method
//    
//    private func layoutSection(for section: Section, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//        
//        switch section {
//        case .one:
//            return oneSection()
//        case .two:
//            return twoSection()
//        case .three:
//            return threeSection()
//        }
//    }
//    
//    func oneSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalHeight(1))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
//        
//        
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
//                                                     heightDimension: .estimated(88))
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
//        
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//        layoutSection.orthogonalScrollingBehavior = .continuous
//        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 12)
//        
////        let header = createSectionHeader()
////        layoutSection.boundarySupplementaryItems = [header]
//        
//        return layoutSection
//    }
//    
//    func twoSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(86))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .estimated(1))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 0, trailing: 20)
//        
////        let header = createSectionHeader()
////        section.boundarySupplementaryItems = [header]
//        
//        return section
//    }
//    
//    func threeSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(86))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .estimated(1))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 0, trailing: 20)
//        
////        let header = createSectionHeader()
////        section.boundarySupplementaryItems = [header]
//        
//        return section
//    }
//    
//    func setupCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
//        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        collectionView.backgroundColor = .white
//        view.addSubview(collectionView)
//        
//    }
//    
//    private func configureDataSource() {
//        dataSource =  UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView,indexPath,itemIdentifier) -> UICollectionViewCell? in
//            switch Section(rawValue: indexPath.section).self {
//            case .one:
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionNowCell.idGeneral1, for: indexPath) as? GeneralSectionNowCell
//                let arreyCollection = wheatherPhoto1[indexPath.row]
//                cell?.configurationCellCollection(image: arreyCollection)
//                return cell
//            case .two:
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionNowCell.idGeneral1, for: indexPath) as? GeneralSectionNowCell
//                let arreyCollection = wheatherPhoto2[indexPath.row]
//                cell?.configurationCellCollection(image: arreyCollection)
//                return cell
//                
//            case .three:
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionNowCell.idGeneral1, for: indexPath) as? GeneralSectionNowCell
//                let arreyCollection = wheatherPhoto3[indexPath.row]
//                cell?.configurationCellCollection(image: arreyCollection)
//                return cell
//                
//            default: break
//            }
//            fatalError("Cannot create the cell")
//        })
//    }
//    
//    private func createLayout() -> UICollectionViewLayout {
//        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
//            let section = self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
//            return section
//        }
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 16.0
//        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
//        return layout
//    }
//    
//    func reloadData() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//        let sections: [Section] = [.one, .two, .three,]
//        snapshot.appendSections([sections[0]])
//        snapshot.appendItems(Array(arrayLiteral: wheatherPhoto1.count))
//        snapshot.appendSections([sections[1]])
//        snapshot.appendItems(Array(arrayLiteral: wheatherPhoto1.count))
//        snapshot.appendSections([sections[2]])
//        snapshot.appendItems(Array(arrayLiteral: wheatherPhoto1.count))
//
//        dataSource.apply(snapshot, animatingDifferences: false)
//    }
//    
//    private func configureHierarchy() {
//        
//    }
//   
//}
//
//
//
//
//var wheatherPhoto1: [UIImage] = [
//    UIImage(named: "0")!,
//    UIImage(named: "0")!,
//    UIImage(named: "0")!,
//    UIImage(named: "0")!,
//
//]
//
//var wheatherPhoto2: [UIImage] = [
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//    UIImage(named: "1")!,
//
//]
//
//var wheatherPhoto3: [UIImage] = [
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//    UIImage(named: "2")!,
//]
//
//
//
//
//
