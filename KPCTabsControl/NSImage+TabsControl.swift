//
//  NSImage+KPCTabsControl.swift
//  KPCTabsControl
//
//  Created by Cédric Foellmi on 14/06/16.
//  Copyright © 2016 Cédric Foellmi. All rights reserved.
//

import AppKit

extension NSImage {
    func KPC_imageWithTint(tint: NSColor) -> NSImage {
        var imageRect = NSZeroRect;
        imageRect.size = self.size;
        
        let highlightImage = NSImage(size: imageRect.size)
        
        highlightImage.lockFocus()
        
        self.drawInRect(imageRect, fromRect: NSZeroRect, operation: .CompositeSourceOver, fraction: 1.0)
        
        tint.set()
        NSRectFillUsingOperation(imageRect, .CompositeSourceAtop);
        
        highlightImage.unlockFocus()
        
        return highlightImage;
    }
}