import UIKit

final class StartViewController:UIViewController {
     
    
    //MARK: - Properties
    private let viewModel:IStartViewModel
    
    
    //MARK: - Life Cycle
    init(viewModel: IStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
