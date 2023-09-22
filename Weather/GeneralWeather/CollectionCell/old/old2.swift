//
////import SwiftUI
//import UIKit
//
//final class GeneralViewController: UIViewController, UICollectionViewDelegate {
//    
//        //MARK: - Enum
//    enum Section: Int, CaseIterable {
//        case horizontal
//        case vertical
//    }
//    
//
//    //MARK: - Properties
//    private let viewModel:IGeneralViewModel
//
//
//    private lazy var layoutVertical: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
//        return layout
//    }()
//
//    private lazy var layoutHorizontal: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
//        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
//        return layout
//    }()
//
//    private lazy var horizontalCollectionView: UICollectionView = {
//        let collectionView = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: layoutHorizontal)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(GeneralSectionDetailCell.self, forCellWithReuseIdentifier: GeneralSectionDetailCell.idGeneral2)
////        collectionView.register(GeneralSectionDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionDetailHeader.idGeneralHeader2)
//        return collectionView
//    }()
//
//    private lazy var verticalCollectionView: UICollectionView = {
//        let collectionView = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: layoutVertical)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(GeneralSectionEveryDate.self, forCellWithReuseIdentifier: GeneralSectionEveryDate.idGeneral3)
////        collectionView.register(GeneralSectionEveryDateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GeneralSectionEveryDateHeader.idGeneralHeader3)
//
//        return collectionView
//    }()
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
//        horizontalCollectionView.dataSource = self
//        horizontalCollectionView.delegate = self
//        verticalCollectionView.dataSource = self
//        verticalCollectionView.delegate = self
//    }
//
//    private func collectionViewLayOut() {
//        view.addSubview(horizontalCollectionView)
//        view.addSubview(verticalCollectionView)
//
//        NSLayoutConstraint.activate([
//
//            horizontalCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            horizontalCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            horizontalCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 60),
//
//            verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 0),
//            verticalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            verticalCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            verticalCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
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
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == horizontalCollectionView {
//
//              return wheatherPhoto2.count
//          } else if collectionView == verticalCollectionView  {
//
//              return wheatherPhoto3.count
//          }
//          return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
// 
//        
//        if collectionView == horizontalCollectionView  {
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionDetailCell.idGeneral2, for: indexPath) as!
//                                    GeneralSectionDetailCell
//                                    let arreyCollection = wheatherPhoto2[indexPath.row]
//                                    cell.configurationCellCollection(image: arreyCollection)
//                                    return cell
//        } else if collectionView == verticalCollectionView {
//                                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralSectionEveryDate.idGeneral3, for: indexPath) as!
//                                    GeneralSectionEveryDate
//                                    let arreyCollection = wheatherPhoto3[indexPath.row]
//                                    cell.configurationCellCollection(image: arreyCollection)
//                                    return cell
//        }
//        return UICollectionViewCell()
//    }
//    
//}
//
////MARK: - Extesion
//
//extension GeneralViewController:UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == horizontalCollectionView {
//            let countItem: CGFloat = 6
//            let accessibleWidth = collectionView.frame.width - 20
//            let widthItem = (accessibleWidth / countItem)
//            return CGSize(width: widthItem, height: 60)
//        } else if collectionView == verticalCollectionView {
//            let countItem: CGFloat = 1
//            let accessibleWidth = collectionView.frame.width - 20
//            let widthItem = (accessibleWidth / countItem)
//            return CGSize(width: widthItem, height: 56)
//        }
//        return CGSize.zero
//    }
//
//}
//
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
