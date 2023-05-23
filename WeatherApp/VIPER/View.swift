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

class LocationViewController: UIViewController, AnyView, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
                myCell.backgroundColor = UIColor.blue
        return myCell
    }
    
    var presenter: AnyPresenter?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(35)
        label.isHidden = false
        return label
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(80)
        label.isHidden = false
        return label
    }()
    
    let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
           label.numberOfLines = 0
           label.sizeToFit()
           label.textColor = UIColor.white
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       let subtitleLabel: UILabel = {
           let label = UILabel()
        label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
           label.numberOfLines = 0
           label.sizeToFit()
           label.textColor = UIColor.white
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    func setupScrollView(){
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollView)
           scrollView.addSubview(contentView)
           
           scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           
           contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
           contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
           contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    
    func setupViews(){
           contentView.addSubview(titleLabel)
           titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
           titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
           titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
           
           contentView.addSubview(subtitleLabel)
           subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
           subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
           subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
           subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameLabel)
        view.addSubview(tempLabel)
        view.backgroundColor = .systemPink
        setupScrollView()
        setupViews()
        
        // add collection view
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: 60, height: 60)
        var myCollectionView:UICollectionView?
                myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
                myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
                myCollectionView?.backgroundColor = UIColor.white
                
                myCollectionView?.dataSource = self
                myCollectionView?.delegate = self
         
                view.addSubview(myCollectionView ?? UICollectionView())
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
            let temp = NSString(format: "%.0f", weather.current.temp_f) as String
            self.tempLabel.text = temp + "°"
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
