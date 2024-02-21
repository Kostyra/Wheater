import UIKit


final class StartViewController:UIViewController {
    
    
    //MARK: - Properties
    private var viewModel: IStartViewModel
    private var viewModelGeneralState: GeneralViewModel.State?
//    private var locationManager: LocationManager = LocationManager()
    
    private lazy var imageStartScreenHumen: UIImageView  = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "changeHumen")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var labelStartInfoAllow: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
                Разрешить приложению  Weather
                использовать данные
                о местоположении вашего устройства
                """
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var labelStartInfoDetail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
                Чтобы получить более точные прогнозы
                погоды во время движения или путешествия
                
                Вы можете изменить свой выбор в любое
                время из меню приложения
                """
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var buttonAllow: CustomButton = {
        let button = CustomButton(title: "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА",
                                  titleColor: .black,
                                  translatesAutoresizingMaskIntoConstraints: false,
                                  cornerRadius: 10,
                                  backgroundColor: UIColor(named: "ColorButtonAllow"),
                                  action: buttonAllowAction)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return button
    }()
    
    private lazy var buttonNotAllow: CustomButton = {
        let button = CustomButton(title: " НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ ",
                                  titleColor: .black,
                                  translatesAutoresizingMaskIntoConstraints: false,
                                  cornerRadius: 10,
                                  backgroundColor: UIColor(named: "ColorButtonNotAllow"),
                                  action: buttonNotAllowAction)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.alpha = 0.8
        return button
    }()
    
    private func setupView() {
        view.addSubview(imageStartScreenHumen)
        view.addSubview(labelStartInfoAllow)
        view.addSubview(labelStartInfoDetail)
        view.addSubview(buttonAllow)
        view.addSubview(buttonNotAllow)
        
        NSLayoutConstraint.activate([
            imageStartScreenHumen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageStartScreenHumen.heightAnchor.constraint(equalToConstant: 200),
            imageStartScreenHumen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageStartScreenHumen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            labelStartInfoAllow.topAnchor.constraint(equalTo: imageStartScreenHumen.bottomAnchor, constant: 50),
            labelStartInfoAllow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelStartInfoAllow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            labelStartInfoDetail.topAnchor.constraint(equalTo: labelStartInfoAllow.bottomAnchor, constant: 60),
            labelStartInfoDetail.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelStartInfoDetail.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonAllow.topAnchor.constraint(equalTo: labelStartInfoDetail.bottomAnchor, constant: 40),
            buttonAllow.heightAnchor.constraint(equalToConstant: 40),
            buttonAllow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonAllow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonNotAllow.topAnchor.constraint(equalTo: buttonAllow.bottomAnchor, constant: 50),
            //            buttonNotAllow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            buttonNotAllow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    
    //MARK: - Life Cycle
    init(viewModel: IStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private Method
    
    @objc private func buttonAllowAction() {
        viewModel.didTabAllowGeo()

    }
    
    @objc private func buttonNotAllowAction() {
        viewModel.didTabDoNotAllowGeo()
    }
    
    
}


