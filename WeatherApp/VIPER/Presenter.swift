//
//  Presenter.swift
//  WeatherApp
//
//  Created by ZhuMacPro on 5/17/23.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set}
    var view: AnyView? { get set }
    
    // funtion to work with interactor
    func interactorDidFetchLocation(with result: Result<[Location], Error>)
}

class LocationPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor?
    
    var view: AnyView?
    
    func interactorDidFetchLocation(with result: Result<[Location], Error>) {
        switch result {
        case .success(let location):
            view?.update(with: location)
        case .failure:
            view?.update(with: "error")
        }
    }
}
