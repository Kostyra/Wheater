
import UIKit

final class GeneralSectionEveryDate: UICollectionViewCell {
    
   //MARK: - Properties
    static let idGeneral3 = "GeneralTheeCollectionViewCell"
    
    private lazy var wheaterImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var wheaterDate: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = Palette.labelDinamecColor
        return label
    }()
    
    private lazy var wheaterMaxTemp: UILabel = {
       let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wheaterMinTemp: UILabel = {
       let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wheatherDescription: UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackViewDateDescription: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0.3
        stack.addArrangedSubview(self.wheaterDate)
        stack.addArrangedSubview(self.wheatherDescription)
        return stack
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
        
        contentView.addSubview(stackViewDateDescription)
        contentView.addSubview(wheaterMinTemp)
        contentView.addSubview(wheaterImage)
        contentView.addSubview(wheaterMaxTemp)
        
//
        NSLayoutConstraint.activate([
            
            stackViewDateDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackViewDateDescription.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewDateDescription.widthAnchor.constraint(equalToConstant: 120),
            
            wheaterMinTemp.leadingAnchor.constraint(equalTo: stackViewDateDescription.trailingAnchor, constant: 35),
            wheaterMinTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            wheaterImage.leadingAnchor.constraint(equalTo: wheaterMinTemp.trailingAnchor, constant: 15),
            wheaterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            wheaterMaxTemp.leadingAnchor.constraint(equalTo: wheaterImage.trailingAnchor, constant: 10),
            wheaterMaxTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configurationCellCollection(with dt_txtDate: String, with descriptions: String, with image: String, with tempMin: Float, with tempMax: Float) {
        self.wheaterImage.image = UIImage(named: image)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dt_txtDate) {
            dateFormatter.dateFormat = "dd:HH"
            let formattedDate = dateFormatter.string(from: date)
            wheaterDate.text = formattedDate
        } else {
            print("Ошибка при разборе даты")
        }
        
        self.wheaterMinTemp.text = String(Float(round(tempMin)))
        self.wheaterMaxTemp.text = String(Float(round(tempMax)))
        self.wheatherDescription.text = descriptions
    }
}
