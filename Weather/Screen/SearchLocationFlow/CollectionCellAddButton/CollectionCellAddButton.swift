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
            cityTempMin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cityTempMin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cityTempMax.topAnchor.constraint(equalTo: cityTemp.bottomAnchor, constant: 5),
            cityTempMax.trailingAnchor.constraint(equalTo: cityTempMin.leadingAnchor, constant: 0),
            cityTempMax.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    func configurationCellCollection(with city: City) {
        self.cityLabel.text = city.name
        self.cityTemp.text = String(Float(city.temp ?? 0))
        self.cityTempMin.text = ", Min: \(String(Float(city.tempMin ?? 0)))"
        self.cityTempMax.text = "Max: \(String(Float(city.tempMax ?? 0)))"
        self.cityDescription.text = city.descriptionName
                              
//        self.cityTemp.text = String((Float(selectedCity[1]) ?? 0) - 100.00)
        
    }

        
    
}
