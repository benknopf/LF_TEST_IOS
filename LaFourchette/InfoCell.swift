//
//  InfoCell.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import UIKit
import Stevia

class InfoCell: UICollectionViewCell {
    
    var restaurantViewModel: RestaurantViewModel!{
        didSet{
            fill()
        }
    }
    
    var titleLabel = UILabel()
    var addressLabel = UILabel()
    var rateLabel = UILabel()
    var countRateLabel = UILabel()
    var cardPrice = UILabel()
    var cardPriceContainer = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    func fill(){
        if restaurantViewModel != nil {
            titleLabel.text = restaurantViewModel.name
            addressLabel.text = restaurantViewModel.completeAddress
            rateLabel.attributedText = formattedRate()
            countRateLabel.text = restaurantViewModel.rateCount
            cardPrice.attributedText = formattedPrice()
        }
    }
    
    func formattedRate() -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        var attributes:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: 22)!]
        let boldRate = NSMutableAttributedString(string: restaurantViewModel.rate, attributes: attributes)
        formattedString.append(boldRate)
        attributes = [NSFontAttributeName : UIFont(name: "Avenir-Medium", size: 12)!]
        let onTen = NSMutableAttributedString(string:"/10", attributes: attributes)
        formattedString.append(onTen)
        return formattedString
    }
    
    func formattedPrice() -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        var attributes:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: 14)!]
        let avergarePrice = NSMutableAttributedString(string: "Prix moyen", attributes: attributes)
        let cardPrice = NSMutableAttributedString(string: restaurantViewModel.cardPrice, attributes: attributes)
        attributes = [NSFontAttributeName : UIFont(name: "Avenir-Medium", size: 14)!]
        let aLaCarte = NSMutableAttributedString(string:" à la carte de ce restaurant : ", attributes: attributes)
        formattedString.append(avergarePrice)
        formattedString.append(aLaCarte)
        formattedString.append(cardPrice)
        return formattedString
    }
    
    func render(){
        
        sv(
            titleLabel,
            addressLabel,
            rateLabel,
            countRateLabel,
            cardPriceContainer.sv(
                cardPrice
            )
        )
        
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 22)
        addressLabel.style{
            $0.font = UIFont(name: "Avenir-Book", size: 13)
            $0.textColor = .lightGray
        }
        rateLabel.style{
            $0.textAlignment = .center
            //$0.font = UIFont(name: "Avenir-Heavy", size: 22)
        }
        countRateLabel.style{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Avenir-Book", size: 13)
            $0.textColor = .lightGray
        }
        cardPrice.textAlignment = .center
        cardPriceContainer.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        layout(
            10,
            |-20-titleLabel-20-|,
            0,
            |-20-addressLabel-20-|,
            5,
            |-20-rateLabel-20-|,
            -5,
            |-20-countRateLabel-20-|,
            10,
            |cardPriceContainer|,
            0
        )
        
        layout(
            20,
            |-20-cardPrice-20-|,
            20
        )
    }
}
