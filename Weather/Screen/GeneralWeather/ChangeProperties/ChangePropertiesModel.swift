//
//  ChangePropertiesModel.swift
//  Weather
//

//

import Foundation

protocol ChangePropertiesModelProtocol {
    var stateChanged: ((ChangePropertiesModel.State) ->())? { get set }
}

final class ChangePropertiesModel {
    
    enum State {
        case open
    }
    
    
    //MARK: - Properties
    var stateChanged: ((State) ->())?
    
    private weak var coordinator:  IChangePropertiesCoordinator?
    
    
    //MARK: - Life Cycle
    
    init( coordinator: IChangePropertiesCoordinator?) {
        self.coordinator = coordinator
    }
    
}

extension ChangePropertiesModel: ChangePropertiesModelProtocol {

}
