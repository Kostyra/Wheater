
import UIKit

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
        case middle(image: String)
        case bottom(city: City)
    }



    //MARK: - Properties

    private let viewModel:IGeneralViewModel
    private lazy var dataSource = configureDataSource()
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>
    private var collectionView: UICollectionView! = nil
    

    //MARK: - Life Cycle

    init(viewModel: IGeneralViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupCollectionView()
        buttonItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Method
    
    
    
    private func buttonItem()  {
        let imagePlus = UIImage(systemName: "plus")
        let button = UIBarButtonItem(image: imagePlus, style: .done, target: self, action: #selector(buttonAddWheather))
        button.tintColor = .blue
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func buttonAddWheather() {
        viewModel.nextFlow()
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.register(GeneralSectionNowCell.self, forCellWithReuseIdentifier: GeneralSectionNowCell.idGeneral1)
        collectionView.register(GeneralSectionDetailCell.self, forCellWithReuseIdentifier: GeneralSectionDetailCell.idGeneral2)
        collectionView.register(GeneralSectionEveryDate.self, forCellWithReuseIdentifier: GeneralSectionEveryDate.idGeneral3)
        collectionView.register(GeneralSectionDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2)
        collectionView.register(GeneralSectionEveryDateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionEveryDateHeader.idGeneralHeader3)
//        collectionView.register(TitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeader")
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
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)


        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
                                                     heightDimension: .estimated(88))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 12)

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
            guard let self = self else {
                return UICollectionViewCell()
            }
            switch cell {
                
            case .top(city: let city):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionNowCell.idGeneral1, for: indexPath) as? GeneralSectionNowCell  else {
                    return UICollectionViewCell()
                    
                }
                cell.configurationCellCollection(with: city)
                return cell
            case .middle( let image) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionDetailCell.idGeneral2, for: indexPath) as?
                GeneralSectionDetailCell
                cell?.configurationCellCollection(with: image)
                return cell
            case .bottom(city: let city):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionEveryDate.idGeneral3, for: indexPath) as?
                GeneralSectionEveryDate
                cell?.configurationCellCollection(with: city)
                return cell
            }
        } 
    }
    
    func makeSnapshot(city:City) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.one])
        snapshot.appendItems([.top(city: city)], toSection: .one)
        snapshot.appendSections([.two])
        if let icons = city.icon  {
            icons.forEach { icon in
                snapshot.appendItems([.middle(image: icon)], toSection: .two)
            }
        }
        snapshot.appendSections([.three])
        snapshot.appendItems([.bottom(city: city)], toSection: .three)
        return snapshot
    }

    
    func makeHeaderProvider() -> DataSource.SupplementaryViewProvider {
        return  { collectionView, kind, indexPath in
            switch Section(rawValue: indexPath.section).self {
               case .two:
                   guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2, for: indexPath) as? GeneralSectionDetailHeader else { return nil }
                   return sectionHeader
               case .three:
                   guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GeneralSectionEveryDateHeader.idGeneralHeader3, for: indexPath) as? GeneralSectionEveryDateHeader else { return nil }
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



    private func configureHierarchy() {

    }

}

extension GeneralViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .one:
            print(1)
        case .two:
            let hourNC = Hour24()
            navigationController?.pushViewController(hourNC, animated: true)
        case .three:
            let inDetailNc = InDetailWheatherEveryDate()
            navigationController?.pushViewController(inDetailNc, animated: true)
//            inDetailNc.selectedItem = wheatherPhoto3[indexPath.row]
//            present(inDetailNc, animated: true, completion: nil)
        default:
            break
        }

    }
}

extension GeneralViewController: AddButtonLocationDelegate {
    func didSelectCities(_ city: City) {
        let snapshot = makeSnapshot(city: city)
        dataSource.supplementaryViewProvider = makeHeaderProvider()
        dataSource.apply(snapshot)
    }
}




