//
//  Icon.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/29/21.
//

import Foundation

protocol Icon {
    func draw()
    func updatePosition() -> Bool
}

class IconHelper {
    static func calculateImageSize(frameSize: CGSize, imageSize: CGSize, frameScale: CGFloat) -> CGSize{
        let heightSize = ceil(frameSize.height / frameScale)
        let widthSize = ceil(frameSize.width / frameScale)
        let imageScale = max(imageSize.width / widthSize, imageSize.height / heightSize)
        
        return CGSize(width: ceil(imageSize.width / imageScale), height: ceil(imageSize.height / imageScale))
    }
    
    static func calculateSpeed(distance: CGFloat, speedScale: CGFloat) -> CGFloat {
        return ceil(distance / speedScale)
    }
}
