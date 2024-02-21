//
//  GeneralSectionNowCell.swift
//  Weather
//
//  Created by Юлия Филиппова on 17.08.2023.
//

import UIKit

final class GeneralSectionNowCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let idGeneral1 = "GeneralSectionNowCell"
    
    private var locationManager = LocationManager()
    private var isDarkMode = false
    
    
    private lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private lazy var cityTemp:UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var cityTempMin:UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var cityTempMax:UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var cityDescription: UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityTempMin,cityTempMax])
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
    
    func configurationCellCollection(with city: City) {
        
        self.cityLabel.text = city.name
        self.cityTemp.text = String(Float(city.temp ?? 0))
        self.cityTempMin.text = "Min: \(String(Float(city.tempMin ?? 0)))"
        self.cityTempMax.text = ", Max: \(String(Float(city.tempMax ?? 0)))"
        self.cityDescription.text = city.descriptionName
        

        
    }


}

