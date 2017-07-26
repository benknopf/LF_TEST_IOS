//
//  RestaurantViewController.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import UIKit
import Stevia

class RestaurantViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var restaurantViewModel: RestaurantViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
        Util.startActivity()
        RestaurantManager.find(by: 6861) { (restaurant, error) in
            Util.stopActivity()
            if let error = error {
                self.handle(error: error)
            }else if let restaurant = restaurant{
                self.restaurantViewModel = RestaurantViewModel(restaurant: restaurant)
                self.collectionView.reloadData()
            }
        }
    }
    
    func render(){
        let cvlayout = UICollectionViewFlowLayout()
        cvlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvlayout.itemSize = CGSize(width: self.view.frame.width, height: 200)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvlayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainPictureCell.self, forCellWithReuseIdentifier: CellType.mainPictureCell.rawValue)
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: CellType.infoCell.rawValue)
        collectionView.register(MapCell.self, forCellWithReuseIdentifier: CellType.mapCell.rawValue)
        collectionView.backgroundColor = .white
        view.sv(
            collectionView
        )
        view.layout(
            0,
            |collectionView|,
            0
        )
    }
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    enum CellType: String {
        case mainPictureCell = "MainPictureCell"
        case infoCell = "InfoCell"
        case mapCell = "MapCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if restaurantViewModel != nil{
            return 3
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case CellType.mainPictureCell.hashValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.mainPictureCell.rawValue, for: indexPath) as! MainPictureCell
            cell.restaurantViewModel = restaurantViewModel
            return cell
        case CellType.infoCell.hashValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.infoCell.rawValue, for: indexPath) as! InfoCell
            cell.restaurantViewModel = restaurantViewModel
            return cell
        case CellType.mapCell.hashValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.mapCell.rawValue, for: indexPath) as! MapCell
            cell.restaurantViewModel = restaurantViewModel
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension RestaurantViewController.CellType {
    var width: Int{
        switch self {
        case .mainPictureCell:
            return 200
        case .infoCell:
            return 200
        case .mapCell:
            return 250
        }
    }
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:Int
        switch indexPath.item {
        case CellType.mainPictureCell.hashValue:
            height = CellType.mainPictureCell.width
        case CellType.infoCell.hashValue:
            height = CellType.infoCell.width
        case CellType.mapCell.hashValue:
            height = CellType.mapCell.width
        default:
            height = 0
        }
        return CGSize(width: self.view.frame.width, height: CGFloat(height))
    }
}
