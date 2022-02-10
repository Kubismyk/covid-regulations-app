//
//  searchCollectionViewCell.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 30.01.22.
//

import UIKit

class searchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    
    func config(data:SearchCollectionViewData){
        self.headerTitle.text = data.header
        self.infoLabel.text = data.information
        self.countryImage.image = data.image
        //self.countryImage.image = data.image
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: .AddToSaves, object: self,userInfo: ["header":self.headerTitle.text!,"infoLabel":self.infoLabel.text!,"image":self.countryImage.image!])
        print("hello2")
    }
}
