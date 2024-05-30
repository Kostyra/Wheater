import UIKit

final class ChangePropertiesController: UIViewController {
    
//    private var viewModel: ChangePropertiesModelProtocol
    
    private lazy var switchTheame: UISwitch = {
        let switchThreame = UISwitch()
        switchThreame.translatesAutoresizingMaskIntoConstraints = false
        switchThreame.addTarget(self, action: #selector(switchThemeChanged), for: .valueChanged)
        return switchThreame
    }()
    
    private lazy var textSwitch: UILabel = {
        let label = UILabel()
        label.text = "Светлая или темная тема"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var switchTemp: UISwitch = {
        let switchThreame = UISwitch()
        switchThreame.translatesAutoresizingMaskIntoConstraints = false
        switchThreame.addTarget(self, action: #selector(switchTempChanged), for: .valueChanged)
        return switchThreame
    }()
    
    private lazy var textSwitchTemp: UILabel = {
        let label = UILabel()
        label.text = "Цельсий или Фаренгейт"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    init(viewModel: ChangePropertiesModelProtocol) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        setupSwitch()
        updateTheme()
    }
        
    private func setupSwitch() {
        view.addSubview(switchTheame)
        view.addSubview(textSwitch)
        view.addSubview(switchTemp)
        view.addSubview(textSwitchTemp)
        NSLayoutConstraint.activate([
            switchTheame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            switchTheame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            switchTheame.heightAnchor.constraint(equalToConstant: 30),
            
            
            textSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textSwitch.leadingAnchor.constraint(equalTo: switchTheame.trailingAnchor, constant: 20),
            textSwitch.heightAnchor.constraint(equalToConstant: 30),
            
            switchTemp.topAnchor.constraint(equalTo: switchTheame.bottomAnchor, constant: 10),
            switchTemp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            switchTemp.heightAnchor.constraint(equalToConstant: 30),
            
            
            textSwitchTemp.topAnchor.constraint(equalTo: switchTheame.bottomAnchor, constant: 10),
            textSwitchTemp.leadingAnchor.constraint(equalTo: switchTemp.trailingAnchor, constant: 20),
            textSwitchTemp.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        switchTheame.isOn = UserDefaults.standard.bool(forKey: "isDarkThemeEnabled")
        switchTemp.isOn = UserDefaults.standard.bool(forKey: "isTemp")
    }
    
    func updateTheme() {
        view.backgroundColor = Palette.viewDinamecColor1
        textSwitch.textColor = Palette.labelDinamecColor
        textSwitchTemp.textColor = Palette.labelDinamecColor
    }
    
    @objc func switchThemeChanged(_ sender: UISwitch) {
        let isDarkThemeEnabled = sender.isOn
        UserDefaults.standard.set(isDarkThemeEnabled, forKey: "isDarkThemeEnabled")
        updateTheme()
    }
    
    @objc func switchTempChanged(_ sender: UISwitch) {
        let isDarkThemeEnabled = sender.isOn
        UserDefaults.standard.set(isDarkThemeEnabled, forKey: "isTemp")
    }
}

