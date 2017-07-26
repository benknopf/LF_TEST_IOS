//
//  MapCell.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import UIKit
import Stevia
import MapKit

class MapCell: UICollectionViewCell {
    
    var restaurantViewModel: RestaurantViewModel!{
        didSet{
            fill()
        }
    }
    
    let mapView = MKMapView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    func render(){
        sv(mapView)
        layout(0,|mapView|,0)
    }
    
    func fill(){
        if restaurantViewModel != nil{
            let coordinate = CLLocationCoordinate2D(latitude: restaurantViewModel.latitude, longitude: restaurantViewModel.longitude)
            let span = MKCoordinateSpanMake(0.0025, 0.0025)
            let region = MKCoordinateRegionMake(coordinate, span)
            mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = restaurantViewModel.name
            mapView.addAnnotation(annotation)
        }
    }
}
