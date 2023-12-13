
import UIKit

final class GeneralSectionEveryDate: UICollectionViewCell {
    
   //MARK: - Properties
    static let idGeneral3 = "GeneralTheeCollectionViewCell"
    
    private lazy var wheaterImage:UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        setupCollectionCell()
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupCollectionCell() {
        contentView.addSubview(wheaterImage)
        
        NSLayoutConstraint.activate([
            wheaterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            wheaterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheaterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wheaterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configurationCellCollection(with city:City) {
        self.wheaterImage.image = UIImage(named: city.icon?.first ?? "50d")
    }
}
