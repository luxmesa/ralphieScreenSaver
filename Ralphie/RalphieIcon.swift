//
//  RalphieIcon.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/29/21.
//

import Foundation
import SwiftUI

class RalphieIcon {
    private var position: CGPoint
    private var velocity: CGVector
    private var image: NSImage?
    private var size: CGSize
    
    private var height: CGFloat
    private var width: CGFloat
    
    
    init(frameWidth: CGFloat, frameHeight: CGFloat) {
        self.height = frameHeight
        self.width = frameWidth
        
        self.position = CGPoint(x: frameWidth / 2, y: frameHeight / 2)
        let size = min(frameWidth, frameHeight)
        self.size = CGSize(width: ceil(size / 3), height: ceil(size / 3))
        self.velocity = RalphieIcon.initialVelocity(size: size)
        self.image = Bundle(for: type(of: self)).image(forResource: "ralphieImage.png")
    }
    
    private static func initialVelocity(size: CGFloat) -> CGVector {
        let desiredVelocityMagnitude: CGFloat = ceil(size / 180)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        let ySign: CGFloat = Bool.random() ? 1 : -1
        return CGVector(dx: desiredVelocityMagnitude * xSign, dy: desiredVelocityMagnitude * ySign)
    }
    
    func draw() {
        image?.draw(in: NSRect(x: position.x - size.width / 2,
                                       y: position.y - size.height / 2,
                                       width: size.width,
                                       height: size.height))
    }
    
    func updatePosition() {
        position.x += velocity.dx
        position.y += velocity.dy
        if(position.x - size.width / 2 <= 0) {
            velocity.dx *= -1
            position.x = size.width - position.x
        }
        if(position.x + size.width / 2 >= width) {
            velocity.dx *= -1
            position.x = width * 2 - position.x - size.width
        }
        
        if(position.y - size.height / 2 <= 0) {
            velocity.dy *= -1
            position.y = size.height - position.y
        }
        if(position.y + size.height / 2 >= height) {
            velocity.dy *= -1
            position.y = height * 2 - position.y - size.height
        }
    }
}
