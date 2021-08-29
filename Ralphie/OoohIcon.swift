//
//  OoohIcon.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/29/21.
//

import Foundation
import SwiftUI

class OoohIcon: Icon {
    var view: NSView
    
    private static let SPEED_SCALE: CGFloat = 200
    private static let FRAME_SCALE: CGFloat = 5
    
    private let image: NSImage?
    private var position: CGFloat
    private let frameSize: CGSize
    private let imageSize: CGSize
    private let speed: CGFloat
    
    init(frameSize: CGSize) {
        self.frameSize = frameSize
        
        self.image = Bundle(for: type(of: self)).image(forResource: "ooohImage.png")
        self.view = NSImageView(image: self.image!)
        self.imageSize = IconHelper.calculateImageSize(frameSize: frameSize, imageSize: image!.size, frameScale: OoohIcon.FRAME_SCALE)
        self.position = 0 - ceil(imageSize.width / 2)
        self.speed = IconHelper.calculateSpeed(distance: frameSize.width, speedScale: OoohIcon.SPEED_SCALE)
    }
    
    func trigger() {
        if(position < 0 - ceil(imageSize.width / 2)) {
            position = frameSize.width + ceil(imageSize.width / 2)
        }
    }
    
    func draw() {
        if(position >= 0 - ceil(imageSize.width / 2)) {
            let rect = NSRect(x: position - imageSize.width / 2,
                              y: 0,
                              width: imageSize.width,
                              height: imageSize.height)
            view.frame = rect
        }
    }
    
    func updatePosition() -> Bool {
        if(position >= 0 - ceil(imageSize.width / 2)) {
            position -= speed
        }
        return false
    }
    
    
}
