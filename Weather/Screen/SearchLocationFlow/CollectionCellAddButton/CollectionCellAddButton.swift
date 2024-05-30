import UIKit

final class CollectionCellAddButton:UICollectionViewCell {
        
   //MARK: - Properties
    static let idAddButton = "CollectionCellAddButton"
    
    private var locationManager = LocationManager()
    private lazy var cityLabel:UILabel = {
       let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityTemp:UILabel = {
       let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityTempMin:UILabel = {
       let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityTempMax:UILabel = {
    let label = UILabel()
     label.textColor = Palette.labelDinamecColor
     label.font = UIFont.systemFont(ofSize: 13)
     label.translatesAutoresizingMaskIntoConstraints = false
     return label
 }()
    
    private lazy var minLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Min:"
        label.textColor = Palette.labelDinamecColor
        return label
    }()
    
    private lazy var maxLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max:"
        label.textColor = Palette.labelDinamecColor
        return label
    }()
    
    private lazy var cityDescription:UILabel = {
    let label = UILabel()
     label.textColor = Palette.labelDinamecColor
     label.font = UIFont.systemFont(ofSize: 13)
     label.translatesAutoresizingMaskIntoConstraints = false
     return label
 }()
    
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = Palette.viewDinamecColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        setupCollectionCell()
        let isTemp = UserDefaults.standard.bool(forKey: "isTemp")
        updateTemperatureForTheme(isTemp: isTemp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupCollectionCell() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(cityTemp)
        contentView.addSubview(cityTempMin)
        contentView.addSubview(cityTempMax)
        contentView.addSubview(cityDescription)
        contentView.addSubview(minLabel)
        contentView.addSubview(maxLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cityDescription.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            cityDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cityDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            cityTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            cityTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cityTemp.heightAnchor.constraint(equalToConstant: 30),
            
            cityTempMin.topAnchor.constraint(equalTo: cityTemp.bottomAnchor, constant: 5),
            cityTempMin.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor, constant: -5),
            cityTempMin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cityTempMax.topAnchor.constraint(equalTo: cityTemp.bottomAnchor, constant: 5),
            cityTempMax.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cityTempMax.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            minLabel.topAnchor.constraint(equalTo: cityTemp.bottomAnchor, constant: 5),
            minLabel.trailingAnchor.constraint(equalTo: cityTempMin.leadingAnchor, constant: 0 ),
            minLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            maxLabel.topAnchor.constraint(equalTo: cityTemp.bottomAnchor, constant: 5),
            maxLabel.trailingAnchor.constraint(equalTo: cityTempMax.leadingAnchor, constant: 0),
            maxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configurationCellCollection(with city: City) {
        self.cityLabel.text = city.name
        self.cityTemp.text = String(Float(city.temp ?? 0))
//        self.cityTempMin.text = (String(Float(city.tempMin)))
//        self.cityTempMax.text = (String(Float(city.tempMax )))
        self.cityDescription.text = city.descriptionName
        if UserDefaults.standard.bool(forKey: "isTemp") == false  {
            self.cityTempMin.text = (String(Float(city.tempMin)))
            self.cityTempMax.text = (String(Float(city.tempMax)))
            self.cityTemp.text = String(Float(city.temp ?? 0))
        } else {
            self.cityTempMin.text = (String(Float(convertToFarhenheit(city.tempMin))))
            self.cityTempMax.text = (String(Float(convertToFarhenheit(city.tempMax))))
            self.cityTemp.text = String(Float(convertToFarhenheit(city.temp ?? 0)))
        }
    }
    
    func updateTemperatureForTheme(isTemp: Bool) {
        guard let temperatureText = cityTempMax.text, let temperature = Float(temperatureText),
              let temperatureTextMin = cityTempMin.text, let temperatureMin = Float(temperatureTextMin)
        else { return }
        let convertedTemperature: Float
        let convertedTemperatureMin: Float
        if isTemp {
            convertedTemperature = convertToFarhenheit(temperature)
            convertedTemperatureMin = convertToFarhenheit(temperatureMin)
        } else {
            convertedTemperature = (temperature - 32) * 5/9
            convertedTemperatureMin = (temperatureMin - 32) * 5/9
        }
        cityTempMax.text = String(round(convertedTemperature))
        cityTempMin.text = String(round(convertedTemperatureMin))
        
    }
    
    func convertToFarhenheit(_ celsiusValue: Float) -> Float {
        return (celsiusValue * 9/5) + 32
    }
    
    
}
