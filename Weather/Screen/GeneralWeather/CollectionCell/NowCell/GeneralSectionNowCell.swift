import UIKit

final class GeneralSectionNowCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let idGeneral1 = "GeneralSectionNowCell"
    
    private var locationManager = LocationManager()
    
    private lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Min:"
        return label
    }()
    
    private lazy var maxLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max:"
        return label
    }()
    
    
    private lazy var cityTemp:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityTempMin:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityTempMax:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minLabel,cityTempMin,maxLabel,cityTempMax])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
       return stackView
    }()
    
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
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
        contentView.addSubview(cityLabel)
        contentView.addSubview(cityTemp)
        contentView.addSubview(cityDescription)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
                        
            cityTemp.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            cityTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityTemp.heightAnchor.constraint(equalToConstant: 60),
            
            cityDescription.topAnchor.constraint(equalTo: cityTemp.bottomAnchor, constant: 5),
            cityDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityDescription.heightAnchor.constraint(equalToConstant: 25),
            
            stackView.topAnchor.constraint(equalTo: cityDescription.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    
    private var originalCityTempMax: Float = 0
    func configurationCellCollection(with city: City) {
        self.cityLabel.text = city.name
        if UserDefaults.standard.bool(forKey: "isTemp") == false  {
            self.cityTemp.text = String(Float(city.temp ?? 0))
            self.cityTempMax.text = (String(Float(city.tempMax)))
            self.cityTempMin.text = (String(Float(city.tempMin)))
        } else {
            self.cityTemp.text = String(Float(convertToFarhenheit(city.temp ?? 0)))
            self.cityTempMax.text = (String(Float(convertToFarhenheit(city.tempMax))))
            self.cityTempMin.text = (String(Float(convertToFarhenheit(city.tempMin))))
        }
        self.cityDescription.text = city.descriptionName
        updateTextColor()
    }
    
//    func configurationCellCollection
    
    func updateTextColor() {
        cityLabel.textColor = Palette.labelDinamecColor
        cityTemp.textColor = Palette.labelDinamecColor
        cityTempMax.textColor = Palette.labelDinamecColor
        cityTempMin.textColor = Palette.labelDinamecColor
        cityDescription.textColor = Palette.labelDinamecColor
        minLabel.textColor = Palette.labelDinamecColor
        maxLabel.textColor = Palette.labelDinamecColor
    }

    func updateTemperatureForTheme(isTemp: Bool) {
        guard let temperatureTextMax = cityTempMax.text, let temperatureMax = Float(temperatureTextMax),
              let temperatureTextMin = cityTempMin.text, let temperatureMin = Float(temperatureTextMin),
              let temperatureText = cityTemp.text, let temperature = Float(temperatureText)
        else { return }
        let convertedTemperature: Float
        let convertedTemperatureMin: Float
        let convertedTemperatureMax: Float
        if isTemp {
            convertedTemperature = convertToFarhenheit(temperature)
            convertedTemperatureMin = convertToFarhenheit(temperatureMin)
            convertedTemperatureMax = convertToFarhenheit(temperatureMax)
        } else {
            convertedTemperature = (temperature - 32) * 5/9
            convertedTemperatureMin = (temperatureMin - 32) * 5/9
            convertedTemperatureMax = (temperatureMax - 32) * 5/9
        }
        cityTempMax.text = (String(round(convertedTemperatureMax)))
        cityTempMin.text = String(round(convertedTemperatureMin))
        cityTemp.text = String(round(convertedTemperature))
    }
    
    func convertToFarhenheit(_ celsiusValue: Float) -> Float {
        return (celsiusValue * 9/5) + 32
    }
}

