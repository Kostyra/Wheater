import UIKit

final class GeneralSectionDetailCell: UICollectionViewCell {
    
   //MARK: - Properties
    static let idGeneral2 = "GeneralSectionDetailCell"
    
    
    
    private lazy var wheatherImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var wheatherTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    private lazy var wheatherTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    

    
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        setupCollectionCell()
        updateTextColor()
        let isTemp = UserDefaults.standard.bool(forKey: "isTemp")
        updateTemperatureForTheme(isTemp: isTemp)
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
            wheatherTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            wheatherTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheatherTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            wheatherTime.heightAnchor.constraint(equalToConstant: 10),
            
            wheatherImage.topAnchor.constraint(equalTo: wheatherTime.bottomAnchor),
            wheatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wheatherImage.heightAnchor.constraint(equalToConstant: 40),
            
            wheatherTemp.topAnchor.constraint(equalTo: wheatherImage.bottomAnchor),
            wheatherTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wheatherTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wheatherTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configurationCellCollection(with dt_txt: String, with image: String, with tempList:Float) {
        self.wheatherTime.text = dt_txt
        self.wheatherImage.image = UIImage(named: image)
        if UserDefaults.standard.bool(forKey: "isTemp") == false  {
            self.wheatherTemp.text = String(Float(tempList))
        } else {
            self.wheatherTemp.text = String(Float(convertToFarhenheit(tempList)))
        }
        updateTextColor()
    }
    
    func updateTextColor() {
        wheatherTime.textColor = Palette.labelDinamecColor
        wheatherTemp.textColor = Palette.labelDinamecColor
    }
    
    func updateTemperatureForTheme(isTemp: Bool) {
        guard let temperatureText = wheatherTemp.text, let temperature = Float(temperatureText)
        else { return }
        let convertedTemperature: Float
        let convertedTemperatureMin: Float
        if isTemp {
            convertedTemperature = convertToFarhenheit(temperature)
        } else {
            convertedTemperature = (temperature - 32) * 5/9
        }
        wheatherTemp.text = String(round(convertedTemperature))
    }
    
    func convertToFarhenheit(_ celsiusValue: Float) -> Float {
        return (celsiusValue * 9/5) + 32
    }
}

