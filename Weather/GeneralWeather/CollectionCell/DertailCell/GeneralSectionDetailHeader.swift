import UIKit

final class GeneralSectionDetailHeader:UICollectionReusableView {
    
    
    //MARK: - Properties
    
    static var idGeneralHeader2 =  "GeneralSectionDetailHeader"
    
    

    
    private lazy var buttonFor10Day:CustomButton = {
        let button = CustomButton(title: "Заголовок",
                                  titleColor: .black,
                                  translatesAutoresizingMaskIntoConstraints: false,
                                  cornerRadius: 0,
                                  backgroundColor: .systemBackground,
                                  action: buttonActionFor24Hour)
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        setupHeaderCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupHeaderCell() {
        addSubview(buttonFor10Day)
        
        NSLayoutConstraint.activate([

            
            buttonFor10Day.topAnchor.constraint(equalTo: topAnchor),
            buttonFor10Day.bottomAnchor.constraint(equalTo: bottomAnchor),
//            buttonFor25Day.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonFor10Day.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
    @objc private func buttonActionFor24Hour() {
        let hour24VC = Hour24()
        let hour24NC = UINavigationController(rootViewController: hour24VC)
        hour24NC.modalPresentationStyle = .fullScreen
        hour24NC.modalTransitionStyle = .crossDissolve
        
      
        
    }
    
}
