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
    func interactorDidFetchLocation(with result: Result<Weather, Error>)
}

class LocationPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getCurrent()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchLocation(with result: Result<Weather, Error>) {
        switch result {
        case .success(let weather):
            print(weather.location.name)
            view?.update(with: weather)
        case .failure:
            view?.update(with: "error")
        }
    }
}
