//
//  Interactor.swift
//  WeatherApp
//
//  Created by ZhuMacPro on 5/17/23.
//

import Foundation

// https://api.weatherapi.com/v1/current.json?key=c5350671db394b61a79205257231705&q=Paris

protocol AnyInteractor {
    // reference presenter
    var presenter: AnyPresenter? { get set }
    // function to interact with API call
    func getCurrent()
}

class LocationInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getCurrent() {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=c5350671db394b61a79205257231705&q=Paris") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let entities = try JSONDecoder().decode([Location].self, from: data)
                self.presenter?.interactorDidFetchLocation(with: .success(entities))
            }
            catch {
                self.presenter?.interactorDidFetchLocation(with: .failure(error))
            }
        }
        task.resume()
    }
}
