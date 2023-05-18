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
    func update(with location: [Location])
    func update(with error: String)
}

class LocationViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.center = view.center
        print("view did load")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with location: [Location]) {
        self.label.text = location[0].name
        self.label.isHidden = false
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.label.text = error
            self.label.isHidden = false
        }
    }
    
    
}
