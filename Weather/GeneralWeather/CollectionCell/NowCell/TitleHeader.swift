//
//  TitleHeader.swift
//  Weather
//
//  Created by Юлия Филиппова on 01.12.2023.
//

import UIKit

final class TitleHeader:UICollectionReusableView {
    

    private lazy var labelHeader: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title = String() {
        didSet {
            labelHeader.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(labelHeader)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
