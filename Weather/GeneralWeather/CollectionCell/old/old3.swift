//
//
//import UIKit
//
//final class GeneralViewController: UIViewController, UICollectionViewDelegate {
//    
//
//    //MARK: - Properties
//    private let viewModel:IGeneralViewModel
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(GeneralSectionNowCell.self, forCellWithReuseIdentifier: GeneralSectionNowCell.idGeneral1)
//        collectionView.register(GeneralSectionDetailCell.self, forCellWithReuseIdentifier: GeneralSectionDetailCell.idGeneral2)
//        collectionView.register(GeneralSectionEveryDate.self, forCellWithReuseIdentifier: GeneralSectionEveryDate.idGeneral3)
////        collectionView.register(GeneralSectionDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2)
//        return collectionView
//    }()
//
//
//
//    //MARK: - Life Cycle
//    init(viewModel: IGeneralViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionViewLayOut()
//        setupcollectionView()
//        view.backgroundColor = .white
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    //MARK: - Method
//
//    private func setupcollectionView() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//    }
//
//    private func collectionViewLayOut() {
//        view.addSubview(collectionView)
//
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
//        ])
//    }
//}
//
//
//    //MARK: - Exrension
//
//extension GeneralViewController:UICollectionViewDataSource {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return  wheatherPhoto1.count
//        case 1:
//            return wheatherPhoto2.count
//        case 2:
//            return wheatherPhoto3.count
//        default:
//            assertionFailure("no registered section")
//            return 1
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionNowCell.idGeneral1, for: indexPath) as! GeneralSectionNowCell
//            cell.configurationCellCollection(image: wheatherPhoto1[indexPath.row])
//            return cell
//        case 1:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionDetailCell.idGeneral2, for: indexPath) as! GeneralSectionDetailCell
//            cell.configurationCellCollection(image: wheatherPhoto2[indexPath.row])
//            return cell
//        case 2:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionEveryDate.idGeneral3, for: indexPath) as! GeneralSectionEveryDate
//            cell.configurationCellCollection(image: wheatherPhoto3[indexPath.row])
//            return cell
//        default:
//            assertionFailure("no registered section")
//            return UICollectionViewCell()
//        }
//        
//    }
//}
//
//
////MARK: - Extesion
//
//extension GeneralViewController:UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.section {
//        case 0:
//            let countItem: CGFloat = 1
//            let accessibleWidth = collectionView.frame.width - 20
//            let widthItem = (accessibleWidth / countItem)
//            return CGSize(width: widthItem, height: 60)
//        case 1:
//            let countItem: CGFloat = 6
//            let accessibleWidth = collectionView.frame.width - 20
//            let widthItem = (accessibleWidth / countItem)
//            return CGSize(width: widthItem, height: 60)
//        case 2:
//            let countItem: CGFloat = 1
//            let accessibleWidth = collectionView.frame.width - 20
//            let widthItem = (accessibleWidth / countItem)
//            return CGSize(width: widthItem, height: 60)
//        default:
//            assertionFailure("no registered section")
//            return CGSize()
//        }
//    }
//}
//
//
//
//var wheatherPhoto1: [UIImage] = [
//    UIImage(named: "0")!
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
//
//
//
//
//
//
//
