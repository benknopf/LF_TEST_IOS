//
//  MainPictureCell.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import UIKit
import Stevia

class MainPictureCell: UICollectionViewCell {
    
    var restaurantViewModel: RestaurantViewModel!{
        didSet{
            fill()
        }
    }
    
    let imageView = UIImageView()
    let pictureCountImageView = UIImageView(image: UIImage(named: "picture_count"))
    let pictureCountLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    func render(){
        pictureCountLabel.style{ label in
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont(name: "Avenir-Medium", size: 10)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        sv(
            imageView.sv(
                pictureCountImageView.sv(
                    pictureCountLabel
                )
            )
        )
        layout(0,|imageView|,0)
        pictureCountImageView.left(10)
        pictureCountImageView.bottom(5)
        pictureCountLabel.top(2)
        pictureCountLabel.left(2)
        pictureCountLabel.right(12)
        pictureCountLabel.bottom(13)
    }
    
    func fill(){
        if restaurantViewModel != nil {
            pictureCountLabel.text = "\(restaurantViewModel.pictureCount)"
            if let imageUrl = restaurantViewModel?.mainPictureUrl{
                _ = ImageManager.load(url: imageUrl){ image in
                    self.imageView.image = image
                }
            }
        }
    }
}
