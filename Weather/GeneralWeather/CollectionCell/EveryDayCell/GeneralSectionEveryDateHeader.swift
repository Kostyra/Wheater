

import UIKit

final class GeneralSectionEveryDateHeader:UICollectionReusableView {
    
    
    //MARK: - Properties
    
    static var idGeneralHeader3 =  "GeneralSectionEveryDateHeader"
    
    
    private lazy var labelEveryDay:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Eжегодный прогноз на 5 дней"
        label.textColor = Palette.labelDinamecColor
        return label
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHeaderCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupHeaderCell() {
        addSubview(labelEveryDay)
        
        NSLayoutConstraint.activate([
            labelEveryDay.topAnchor.constraint(equalTo: topAnchor),
            labelEveryDay.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelEveryDay.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
    @objc private func buttonActionFor25Day() {
        
    }
    
}
