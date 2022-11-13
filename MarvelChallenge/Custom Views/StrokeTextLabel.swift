//
//  StrokeTextLabel.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import Foundation
import UIKit

public class StrokeTextLabel: UILabel{
    
    private var mOutlineColor:UIColor?
    private var mOutlineWidth:CGFloat?

    @IBInspectable var outlineColor: UIColor {
        get { return mOutlineColor ?? UIColor.clear }
        set { mOutlineColor = newValue }
    }

    @IBInspectable var outlineWidth: CGFloat{
        get { return mOutlineWidth ?? 0 }
        set { mOutlineWidth = newValue }
    }

    override public func drawText(in rect: CGRect) {
        
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor

        let c = UIGraphicsGetCurrentContext()
        c?.setLineWidth(outlineWidth)
        c?.setLineJoin(.round)
        c?.setTextDrawingMode(.stroke)
        self.textColor = mOutlineColor;
        super.drawText(in:rect)

        c?.setTextDrawingMode(.fill)
        self.textColor = textColor
        self.shadowOffset = CGSize(width: 0, height: 0)
        super.drawText(in:rect)

        self.shadowOffset = shadowOffset
    }
}
