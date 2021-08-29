//
//  RalphieView.swift
//  Ralphie
//
//  Created by Samuel Vercauteren on 8/28/21.
//

import ScreenSaver

class RalphieView: ScreenSaverView {

    private let ralphie: RalphieIcon
    private let oooh: OoohIcon
    
    override init?(frame: NSRect, isPreview: Bool) {
        let frameSize = CGSize(width: frame.width, height: frame.height)
        self.ralphie = RalphieIcon(frameSize: frameSize)
        self.oooh = OoohIcon(frameSize: frameSize)
        super.init(frame: frame, isPreview: isPreview)
        self.addSubview(oooh.view)
        self.addSubview(ralphie.view)
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: NSRect) {
        // background
        //let background = NSBezierPath(rect: bounds)
        //NSColor.black.setFill()
        //background.fill()
        
        oooh.draw()
        ralphie.draw()
    }

    override func animateOneFrame() {

        super.animateOneFrame()
        let collision = ralphie.updatePosition()
        if(collision) {
            oooh.trigger()
        }
        oooh.updatePosition()
        setNeedsDisplay(bounds)
    }

}
