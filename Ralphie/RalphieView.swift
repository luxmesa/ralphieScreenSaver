//
//  RalphieView.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/28/21.
//

import ScreenSaver

class RalphieView: ScreenSaverView {

    private var ralphie: RalphieIcon
    
    override init?(frame: NSRect, isPreview: Bool) {
        self.ralphie = RalphieIcon(frameWidth: frame.width, frameHeight: frame.height)
        super.init(frame: frame, isPreview: isPreview)
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
        
        ralphie.draw()
    }

    override func animateOneFrame() {

        super.animateOneFrame()
        ralphie.updatePosition()
        setNeedsDisplay(bounds)
    }

}
