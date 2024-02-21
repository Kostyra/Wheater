import UIKit

final class GeneralSectionDetailCell: UICollectionViewCell {
    
   //MARK: - Properties
    static let idGeneral2 = "GeneralSectionDetailCell"
    
    
    
    private lazy var wheatherImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var wheatherTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Palette.labelDinamecColor
        return label
    }()

    private lazy var wheatherTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Palette.labelDinamecColor
        return label
    }()
    

    
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.backgroundColor = Palette.viewDinamecColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        setupCollectionCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupCollectionCell() {
        contentView.addSubview(wheatherTime)
        contentView.addSubview(wheatherImage)
        contentView.addSubview(wheatherTemp)
        
        NSLayoutConstraint.activate([
            wheatherTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wheatherTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheatherTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wheatherTime.heightAnchor.constraint(equalToConstant: 10),
            
            wheatherImage.topAnchor.constraint(equalTo: wheatherTime.bottomAnchor),
            wheatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            wheatherTime.heightAnchor.constraint(equalToConstant: 15),
            
            wheatherTemp.topAnchor.constraint(equalTo: wheatherImage.bottomAnchor),
            wheatherTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheatherTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wheatherTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configurationCellCollection(with dt_txt: String, with image: String, with tempList:Float) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dt_txt) {
            dateFormatter.dateFormat = "HH"
            let formattedDate = dateFormatter.string(from: date)
            wheatherTime.text = formattedDate
        } else {
            print("Ошибка при разборе даты")
        }
        
        
        self.wheatherImage.image = UIImage(named: image)
        self.wheatherTemp.text = String(Float(tempList ))
        
    }
    
    
}

