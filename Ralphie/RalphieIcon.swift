//
//  RalphieIcon.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/29/21.
//

import Foundation
import SwiftUI

class RalphieIcon: Icon {
    
    private static let SPEED_SCALE: CGFloat = 180
    private static let FRAME_SCALE: CGFloat = 3
    private static let CORNER_TOLERANCE: CGFloat = 10
    
    private var position: CGPoint
    private var velocity: CGVector
    private var image: NSImage?
    private var imageSize: CGSize
    
    private var frameSize: CGSize
    
    
    init(frameSize: CGSize) {
        self.image = Bundle(for: type(of: self)).image(forResource: "ralphieImage.png")
        self.frameSize = frameSize
        self.imageSize = IconHelper.calculateImageSize(frameSize: frameSize, imageSize: image!.size, frameScale: RalphieIcon.FRAME_SCALE)
        
        self.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        //let tempPosition = min(frameSize.width / 2, frameSize.height / 2)
        //self.position = CGPoint(x: tempPosition + imageSize.width / 2, y: tempPosition + imageSize.height / 2 + RalphieIcon.CORNER_TOLERANCE)
        self.velocity = RalphieIcon.initialVelocity(frameSize: frameSize)
    }
    
    private static func initialVelocity(frameSize: CGSize) -> CGVector {
        let desiredVelocityMagnitude: CGFloat = IconHelper.calculateSpeed(distance: min(frameSize.width, frameSize.height), speedScale: RalphieIcon.SPEED_SCALE)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        let ySign: CGFloat = Bool.random() ? 1 : -1
        //let xSign: CGFloat = Bool.random() ? -1 : -1
        //let ySign: CGFloat = Bool.random() ? -1 : -1
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
        var collision = 0
        if(position.x - imageSize.width / 2 - RalphieIcon.CORNER_TOLERANCE <= 0) {
            if(position.x - imageSize.width / 2 <= 0) {
                velocity.dx *= -1
                position.x = imageSize.width - position.x
            }
            collision += 1
        }
        if(position.x + imageSize.width / 2 + RalphieIcon.CORNER_TOLERANCE >= frameSize.width) {
            if(position.x + imageSize.width / 2 >= frameSize.width) {
                velocity.dx *= -1
                position.x = frameSize.width * 2 - position.x - imageSize.width
            }
            collision += 1
        }
        
        if(position.y - imageSize.height / 2 - RalphieIcon.CORNER_TOLERANCE <= 0) {
            if(position.y - imageSize.height / 2 <= 0) {
                velocity.dy *= -1
                position.y = imageSize.height - position.y
            }
            collision += 1
        }
        if(position.y + imageSize.height / 2 + RalphieIcon.CORNER_TOLERANCE >= frameSize.height) {
            if(position.y + imageSize.height / 2 >= frameSize.height) {
                velocity.dy *= -1
                position.y = frameSize.height * 2 - position.y - imageSize.height
            }
            collision += 1
        }
        return collision >= 2
    }
}
