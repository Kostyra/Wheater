

import UIKit

final class GeneralSectionEveryDateHeader:UICollectionReusableView {
    
    
    //MARK: - Properties
    
    static var idGeneralHeader3 =  "GeneralSectionEvreDateHeader"
    
    
    private lazy var labelEveryDay:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Eжегодный прогноз"
        return label
    }()
    
    private lazy var buttonFor25Day:CustomButton = {
        let button = CustomButton(title: "25 дней",
                                  titleColor: .black,
                                  translatesAutoresizingMaskIntoConstraints: false,
                                  cornerRadius: 0,
                                  backgroundColor: .systemBackground,
                                  action: buttonActionFor25Day)
        return button
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
        addSubview(buttonFor25Day)
        
        NSLayoutConstraint.activate([
            labelEveryDay.topAnchor.constraint(equalTo: topAnchor),
            labelEveryDay.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelEveryDay.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelEveryDay.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buttonFor25Day.topAnchor.constraint(equalTo: topAnchor),
            buttonFor25Day.bottomAnchor.constraint(equalTo: bottomAnchor),
//            buttonFor25Day.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonFor25Day.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
    @objc private func buttonActionFor25Day() {
        
    }
    
}
