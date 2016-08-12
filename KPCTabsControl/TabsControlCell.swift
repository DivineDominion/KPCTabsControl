//
//  TabsControlCell.swift
//  KPCTabsControl
//
//  Created by Cédric Foellmi on 30/07/16.
//  Licensed under the MIT License (see LICENSE file)
//

import Cocoa

class TabsControlCell: NSCell {
    
    var style: Style! {
        didSet { self.controlView?.needsDisplay = true }
    }
   
    override init(textCell aString: String) {
        super.init(textCell: aString)
        
        self.bordered = true
        self.backgroundStyle = .Light
        self.focusRingType = .None
        self.enabled = false
        self.font = NSFont.systemFontOfSize(13)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

//    func highlight(flag: Bool) {
//        self.highlighted = flag
//        self.controlView?.needsDisplay = true
//    }
    
    override func cellSizeForBounds(aRect: NSRect) -> NSSize {
        return NSMakeSize(36.0, 0.0)
    }
    
    override func drawWithFrame(cellFrame: NSRect, inView controlView: NSView) {

        // TODO can we get rid of this by setting `style` earlier?
        guard style != nil else { return }

        style.drawTabControlBezel(frame: cellFrame)
    }
}