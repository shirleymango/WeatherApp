//
//  Router.swift
//  WeatherApp
//
//  Created by ZhuMacPro on 5/17/23.
//

import Foundation

typealias EntryPoint = AnyView & LocationViewController

protocol AnyRouter {
    static func start() -> AnyRouter
    var entry: EntryPoint? { get }
}

class LocationRouter: AnyRouter {
    var entry: EntryPoint?
    static func start() -> AnyRouter {
        let router = LocationRouter()
        
        var view: AnyView = LocationViewController()
        var presenter: AnyPresenter = LocationPresenter()
        var interactor: AnyInteractor = LocationInteractor()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        router.entry = view as? EntryPoint
        
        return router
    }
}
