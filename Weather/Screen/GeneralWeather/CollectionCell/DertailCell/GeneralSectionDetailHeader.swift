import UIKit

final class GeneralSectionDetailHeader:UICollectionReusableView {
    
    
    //MARK: - Properties
    
    static var idGeneralHeader2 =  "GeneralSectionDetailHeader"
    
    
    private lazy var buttonFor10Day:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Кратко о погоде на 5 дней"
        label.textColor = Palette.labelDinamecColor
        return label
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHeaderCell()
        updateTextColor()
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
            buttonFor10Day.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
//    @objc private func buttonActionFor24Hour() {
//        let hour24VC = Hour24()
//        let hour24NC = UINavigationController(rootViewController: hour24VC)
//        hour24NC.modalPresentationStyle = .fullScreen
//        hour24NC.modalTransitionStyle = .crossDissolve
//    }
    
    func updateTextColor() {
        buttonFor10Day.textColor = Palette.labelDinamecColor
    }
    
}
