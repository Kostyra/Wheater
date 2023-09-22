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
    
    private lazy var wheaterImage:UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCollectionCell()
        contentView.backgroundColor = .blue
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
            wheaterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configurationCellCollection(image:UIImage) {
        self.wheaterImage.image = image
    }
}

