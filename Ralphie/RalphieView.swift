//
//  ralphie.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/28/21.
//

import ScreenSaver

class RalphieView: ScreenSaverView {

    var position: CGPoint
    private var velocity: CGVector
    var image: NSImage?
    var size: CGSize
    
    private var height: CGFloat
    private var width: CGFloat
    
    override init?(frame: NSRect, isPreview: Bool) {
        self.height = frame.height
        self.width = frame.width
        
        self.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let size = min(frame.width, frame.height)
        self.size = CGSize(width: ceil(size / 3), height: ceil(size / 3))
        self.velocity = RalphieView.initialVelocity(size: size)
        self.image = Bundle(for: type(of: self)).image(forResource: "ralphieImage.png")
        super.init(frame: frame, isPreview: isPreview)
    }
    
    static func initialVelocity(size: CGFloat) -> CGVector {
        let desiredVelocityMagnitude: CGFloat = ceil(size / 180)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        let ySign: CGFloat = Bool.random() ? 1 : -1
        return CGVector(dx: desiredVelocityMagnitude * xSign, dy: desiredVelocityMagnitude * ySign)
    }

    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: NSRect) {
        // background
        let background = NSBezierPath(rect: bounds)
        NSColor.black.setFill()
        background.fill()
        
        image?.draw(in: NSRect(x: position.x - size.width / 2,
                                       y: position.y - size.height / 2,
                                       width: size.width,
                                       height: size.height))
        //ralpie.draw()
    }

    override func animateOneFrame() {

        super.animateOneFrame()

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

        setNeedsDisplay(bounds)
    }

}
