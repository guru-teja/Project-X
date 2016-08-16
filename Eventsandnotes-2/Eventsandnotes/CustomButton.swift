//
//  CustomButton.swift
//  Eventsandnotes
//
//  Created by Ganesh on 8/11/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton  //Sai Pavan
    
{
    @IBInspectable var borderColor: UIColor? = UIColor.clearColor()
        {
        didSet
        {
            layer.borderColor = self.borderColor?.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0
        {
        didSet
        {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect)
    {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width//self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.CGColor
    }
    
    
}
