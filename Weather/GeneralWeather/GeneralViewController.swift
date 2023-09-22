//
//  GeneralViewController.swift
//  Weather
//
//  Created by Юлия Филиппова on 07.08.2023.
//

import UIKit

class GeneralViewController: UIViewController {

    //MARK: - Properties
    private let viewModel:IGeneralViewModel
    
    
    //MARK: - Life Cycle
    init(viewModel: IGeneralViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
