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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(35)
        label.isHidden = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(80)
        label.isHidden = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameLabel)
        view.addSubview(tempLabel)
        view.backgroundColor = .systemPink
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 100, width: 200, height: 50)
        nameLabel.center.x = view.center.x
        tempLabel.frame = CGRect(x: 0, y: 100+nameLabel.frame.size.height, width: 200, height: 100)
        tempLabel.center.x = view.center.x
    }
    
    func update(with weather: Weather) {
        DispatchQueue.main.async {
            print(weather.location.name)
            self.nameLabel.text = weather.location.name
            self.nameLabel.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = "error"
            self.nameLabel.backgroundColor = UIColor.white
            self.nameLabel.isHidden = false
        }
    }
    
    
}
