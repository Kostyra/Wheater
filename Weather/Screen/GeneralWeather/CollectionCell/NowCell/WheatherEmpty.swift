import UIKit

final class WheatherEmpty: UIView {
    
    //MARK: - Properties
    
    private lazy var cityLabelPlus:UILabel = {
        let label = UILabel()
        label.textColor = Palette.labelDinamecColor
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Press plus"
        return label
    }()
    
    //MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCollectionCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionCell() {
        addSubview(cityLabelPlus)
        
        NSLayoutConstraint.activate([
            cityLabelPlus.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 3),
            cityLabelPlus.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            cityLabelPlus.heightAnchor.constraint(equalToConstant: 40),
            ])
    }
}
