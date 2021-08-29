//
//  RalphieIcon.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/29/21.
//

import Foundation
import SwiftUI

class RalphieIcon: Icon {
    
    private static let SPEED_SCALE: CGFloat = 150
    private static let FRAME_SCALE: CGFloat = 3
    
    private var position: CGPoint
    private var velocity: CGVector
    private var image: NSImage?
    private var imageSize: CGSize
    
    private var frameSize: CGSize
    
    
    init(frameSize: CGSize) {
        self.image = Bundle(for: type(of: self)).image(forResource: "ralphieImage.png")
        self.frameSize = frameSize
        
        self.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        self.imageSize = IconHelper.calculateImageSize(frameSize: frameSize, imageSize: image!.size, frameScale: RalphieIcon.FRAME_SCALE)
        self.velocity = RalphieIcon.initialVelocity(frameSize: frameSize)
    }
    
    private static func initialVelocity(frameSize: CGSize) -> CGVector {
        let desiredVelocityMagnitude: CGFloat = IconHelper.calculateSpeed(frameSize: frameSize, speedScale: RalphieIcon.SPEED_SCALE)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        let ySign: CGFloat = Bool.random() ? 1 : -1
        return CGVector(dx: desiredVelocityMagnitude * xSign, dy: desiredVelocityMagnitude * ySign)
    }
    
    func draw() {
        image?.draw(in: NSRect(x: position.x - imageSize.width / 2,
                                       y: position.y - imageSize.height / 2,
                                       width: imageSize.width,
                                       height: imageSize.height))
    }
    
    func updatePosition() -> Bool {
        position.x += velocity.dx
        position.y += velocity.dy
        var collision = false
        if(position.x - imageSize.width / 2 <= 0) {
            velocity.dx *= -1
            position.x = imageSize.width - position.x
            collision = true
        }
        if(position.x + imageSize.width / 2 >= frameSize.width) {
            velocity.dx *= -1
            position.x = frameSize.width * 2 - position.x - imageSize.width
            collision = true
        }
        
        if(position.y - imageSize.height / 2 <= 0) {
            velocity.dy *= -1
            position.y = imageSize.height - position.y
            collision = true
        }
        if(position.y + imageSize.height / 2 >= frameSize.height) {
            velocity.dy *= -1
            position.y = frameSize.height * 2 - position.y - imageSize.height
            collision = true
        }
        return collision
    }
}
