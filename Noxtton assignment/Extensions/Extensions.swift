//
//  Extensions.swift
//  Noxtton assignment
//
//  Created by Levan Charuashvili on 12.01.22.
//
import Foundation
import UIKit

//                   BUTTON EXTENSION BELOW
public extension UIButton {
    func buttonStyle(buttonPositionX: Double, buttonPositionY: Double ,buttonWidth: Double, buttonHeight: Double, buttonTilte: String,backgroundColor: UIColor, titleColor:UIColor) {
        self.setTitle(buttonTilte, for: .normal)
        self.frame = CGRect(x: buttonPositionX, y: buttonPositionY, width: buttonWidth, height: buttonHeight)
        self.backgroundColor = backgroundColor
        self.tintColor = titleColor
        self.layer.masksToBounds = true
   }
    func buttonShadow(shadowColor:UIColor,shadowX:Double,shadowY:Double,shadowOpacity:Float,shadowRadius:CGFloat,cornerRadius:Double){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
    func buttonFontAndSize(fontFamily:String,fontSize:Double){
        self.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
    }
}


//               LABEL EXTENSIONS BELOW
public extension UILabel {
    func FontStyle(fontSize:Int,shadowRadius:CGFloat,shadowOpacity:Float,shadowX:Int,shadowY:Int,fontFamily:String){
        self.font = UIFont(name: fontFamily, size: CGFloat(fontSize))
       self.layer.masksToBounds = false
       self.layer.shadowRadius = shadowRadius
       self.layer.shadowOpacity = shadowOpacity
       self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
    }
}


//              TEXTFIELD EXTENSIONS BELOW


public extension UITextField {
    func addInnerShadow(innerShadowColor:UIColor,innerShadowX:Int,innerShadowY:Int,innerShadowOpacity:Float,innerShadowRadius:CGFloat) {
            // Inner shadow things...
            let innerShadow = CALayer()
            innerShadow.frame = bounds
            let radius = self.layer.cornerRadius
            let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy:2), cornerRadius:radius)
            let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()
            
            path.append(cutout)
            innerShadow.shadowPath = path.cgPath
            innerShadow.masksToBounds = true
            
            // Shadow properties
            innerShadow.shadowColor = innerShadowColor.cgColor
            innerShadow.shadowOffset = CGSize(width: innerShadowX, height: innerShadowY)
            innerShadow.shadowOpacity = innerShadowOpacity
            innerShadow.shadowRadius = innerShadowRadius
            innerShadow.cornerRadius = self.layer.cornerRadius
            layer.addSublayer(innerShadow)
    }
    
    
    func addShadow(ShadowRadius:CGFloat,ShadowColor:UIColor,ShadowOpacity:Float,ShadowX:Int,ShadowY:Int) {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.shadowRadius = ShadowRadius
        self.layer.shadowColor = ShadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: ShadowX, height: ShadowY)
        self.layer.shadowOpacity = ShadowOpacity
        }
    
    func textFieldStyle(CornerRadius:Int,BorderWidth:CGFloat,BorderColor:UIColor,Placeholder:String,FontFamily:String,TextColor:UIColor){
        self.layer.cornerRadius = CGFloat(CornerRadius)
        self.layer.borderWidth = BorderWidth
        self.layer.borderColor = BorderColor.cgColor
        self.attributedPlaceholder = NSAttributedString(
            string: Placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        self.font =  UIFont.init(name: (FontFamily), size: 20.0)
        self.textColor = TextColor
        
    }

    enum Direction {
        case Left
        case Right
    }
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        mainView.addSubview(view)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.85
        //image.withTintColor(.red, renderingMode: .alwaysTemplate)
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)

        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)

        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: -3, width: 0.5, height: 50)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 0.5, height: 50)
            self.rightViewMode = .always
            self.rightView = mainView
        }
    }
}
