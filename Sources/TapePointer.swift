//
//  TapePointer.swift
//  PrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 23/02/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit
import Darwin

class TapePointer: SKNode {
    
    let style: TapeIndicatorStyleType
    private let valueLabel: SKLabelNode
    private let legendKeyLabelNode: SKLabelNode?
    private let legendValueLabelNode: SKLabelNode?
    
    var value: Int {
        didSet {
            valueLabel.text = style.labelForValue(value)
        }
    }
    
    init(initialValue: Int, style: TapeIndicatorStyleType) {
        self.value = initialValue
        self.style = style
        valueLabel = SKLabelNode(text: style.labelForValue(value))
        if let legend = style.legend {
            legendKeyLabelNode = SKLabelNode(text: legend.key)
            legendValueLabelNode = SKLabelNode(text: legend.value)
        } else {
            legendKeyLabelNode = nil
            legendValueLabelNode = nil
        }
        
        super.init()
        
        addChild(buildBackgroundShape())
        styleLabelNode()
        addChild(valueLabel)
        if let node = legendKeyLabelNode {
            addChild(node)
        }
        if let node = legendValueLabelNode {
            addChild(node)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleLabelNode() {
        valueLabel.fontName = style.font.family
        valueLabel.fontSize = style.font.size
        valueLabel.fontColor = style.markerTextColor

        legendKeyLabelNode?.fontName = style.font.family
        legendKeyLabelNode?.fontSize = round(style.font.size * CGFloat(0.5))
        legendKeyLabelNode?.fontColor = style.markerTextColor.colorWithAlphaComponent(0.7)

        legendValueLabelNode?.fontName = style.font.family
        legendValueLabelNode?.fontSize = round(style.font.size * CGFloat(0.5))
        legendValueLabelNode?.fontColor = style.markerTextColor.colorWithAlphaComponent(0.7)

        switch style.markerJustification {
        case .Top:
            valueLabel.horizontalAlignmentMode = .Center
            valueLabel.verticalAlignmentMode = .Top
            valueLabel.position = CGPoint(x: 0, y: style.size.height/2 - CGFloat(style.markerTextOffset))
        case .Bottom:
            valueLabel.horizontalAlignmentMode = .Center
            valueLabel.verticalAlignmentMode = .Bottom
            valueLabel.position = CGPoint(x: 0, y: CGFloat(style.markerTextOffset) - style.size.height/2)
        case .Left:
            valueLabel.horizontalAlignmentMode = .Left
            valueLabel.verticalAlignmentMode = .Center
            valueLabel.position = CGPoint(
                x: CGFloat(style.markerTextOffset) - style.size.width/2,
                y: 0)
            
            legendKeyLabelNode?.horizontalAlignmentMode = .Left
            legendKeyLabelNode?.verticalAlignmentMode = .Top
            legendKeyLabelNode?.position = CGPoint(
                x: CGFloat(style.markerTextOffset) - style.size.width/2,
                y: backgroundShapeDimensions().thirdWidth)
            
            legendValueLabelNode?.horizontalAlignmentMode = .Left
            legendValueLabelNode?.verticalAlignmentMode = .Bottom
            legendValueLabelNode?.position = CGPoint(
                x: CGFloat(style.markerTextOffset) - style.size.width/2,
                y: -backgroundShapeDimensions().thirdWidth)
        case .Right:
            valueLabel.horizontalAlignmentMode = .Right
            valueLabel.verticalAlignmentMode = .Center
            valueLabel.position = CGPoint(
                x: style.size.width/2 - CGFloat(style.markerTextOffset),
                y: 0)

            legendKeyLabelNode?.horizontalAlignmentMode = .Right
            legendKeyLabelNode?.verticalAlignmentMode = .Top
            legendKeyLabelNode?.position = CGPoint(
                x: style.size.width/2 - CGFloat(style.markerTextOffset),
                y: backgroundShapeDimensions().thirdWidth)
            
            legendValueLabelNode?.horizontalAlignmentMode = .Right
            legendValueLabelNode?.verticalAlignmentMode = .Bottom
            legendValueLabelNode?.position = CGPoint(
                x: style.size.width/2 - CGFloat(style.markerTextOffset),
                y: -backgroundShapeDimensions().thirdWidth)
        }
    }
    
    private func buildBackgroundShape() -> SKShapeNode {
        let dimensions = backgroundShapeDimensions()
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, dimensions.thirdWidth, dimensions.thirdWidth)
        CGPathAddLineToPoint(path, nil, dimensions.width, dimensions.thirdWidth)
        CGPathAddLineToPoint(path, nil, dimensions.width, -dimensions.thirdWidth)
        CGPathAddLineToPoint(path, nil, dimensions.thirdWidth, -dimensions.thirdWidth)
        CGPathCloseSubpath(path)
        
        let translateTransform, rotateTransform: CGAffineTransform

        switch style.markerJustification {
        case .Top:
            translateTransform = CGAffineTransformMakeTranslation(-dimensions.halfWidth, 0)
            rotateTransform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        case .Bottom:
            translateTransform = CGAffineTransformMakeTranslation(-dimensions.halfWidth, 0)
            rotateTransform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        case .Left:
            translateTransform = CGAffineTransformMakeTranslation(-dimensions.halfWidth, 0)
            rotateTransform = CGAffineTransformIdentity
        case .Right:
            translateTransform = CGAffineTransformMakeTranslation(-dimensions.halfWidth, 0)
            rotateTransform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        
        var transform = CGAffineTransformConcat(translateTransform, rotateTransform)
        let transformedPath = withUnsafeMutablePointer(&transform) {
            CGPathCreateMutableCopyByTransformingPath(path, $0)
        }
        
        let shape = SKShapeNode(path: transformedPath!)
        shape.fillColor = style.pointerBackgroundColor
        shape.strokeColor = SKColor.whiteColor()
        return shape
    }
    
    private func backgroundShapeDimensions() -> (width: CGFloat, halfWidth: CGFloat, thirdWidth: CGFloat) {
        let width, halfWidth, thirdWidth: CGFloat
        
        switch style.markerJustification {
        case .Top, .Bottom:
            width = CGFloat(style.size.height)
            halfWidth = width / 2
            thirdWidth = width / 3
        case .Left, .Right:
            width = style.size.width
            halfWidth = width / 2
            thirdWidth = width / 3
        }

        return (width, halfWidth, thirdWidth)
    }
}
