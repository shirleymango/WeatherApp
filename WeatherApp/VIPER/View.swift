//
//  View.swift
//  WeatherApp
//
//  Created by ZhuMacPro on 5/17/23.
//

import Foundation
import UIKit

protocol AnyView {
    // reference presenter
    var presenter: AnyPresenter? { get set }
    // function to update view - with data or with error
    func update(with weather: Weather)
    func update(with error: String)
}

class LocationViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.center = view.center
        view.backgroundColor = .systemPink
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with weather: Weather) {
        DispatchQueue.main.async {
            print(weather.location.name)
            self.label.text = weather.location.name
            self.label.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.label.text = "error"
            self.label.backgroundColor = UIColor.white
            self.label.isHidden = false
        }
    }
    
    
}
