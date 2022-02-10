//
//  MySubscribitionsCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 23.01.22.
//

import UIKit

class MySubscribitionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNCountryName: UILabel!
    @IBOutlet weak var learnMore: UILabel!
    
    func configure(with items:SearchCollectionViewData){
        cityImage.image = items.image
        cityNCountryName.text = items.header
    }
}
