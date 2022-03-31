//
//  RainViewRepresentable.swift
//  
//
//  Created by Stefan Blos on 17.03.22.
//

import SwiftUI

struct RainViewRepresentable: EffectsViewRepresentable {
    
    var proxy: GeometryProxy
    var config: RainConfig
    
    fileprivate var birthRate: Float {
        switch config.intensity {
        case .low:
            return 50
        case .medium:
            return 200
        case .high:
            return 400
        }
    }
    
    fileprivate var lifetime: Float {
        switch config.lifetime {
        case .short:
            return 4
        case .medium:
            return 10
        case .long:
            return 20
        }
    }
    
    fileprivate var velocity: CGFloat {
        switch config.speed {
        case .slow:
            return 50
        case .medium:
            return 250
        case .fast:
            return 400
        }
    }
    
    fileprivate var alphaSpeed: Float {
        switch config.fadeOut {
        case .none:
            return 0
        case .slow:
            return 4
        case .medium:
            return 2
        case .fast:
            return 0.5
        }
    }
    
    fileprivate var spreadRadius: CGFloat {
        switch config.spreadRadius {
        case .low:
            return 1
        case .medium:
            return 6.284
        case .high:
            return 15.0
        }
    }
    
    func createCell(with content: Content) -> CAEmitterCell {
        let cell = CAEmitterCell()
        
        cell.contentsScale = (1 / scale) / content.scale
//        cell.scale = 0.005 / scale
        cell.scaleRange = 0.02
        cell.scaleSpeed = -0.005
        cell.magnificationFilter = CALayerContentsFilter.trilinear.rawValue
        cell.minificationFilter = CALayerContentsFilter.trilinear.rawValue
        cell.minificationFilterBias = -25
        cell.spinRange = 0.1
        cell.velocity = velocity
        cell.velocityRange = 8
        cell.xAcceleration = 50
        switch config.fallDirection {
        case .downwards:
            cell.yAcceleration = 200
        case .upwards:
            cell.yAcceleration = -200
        }
        cell.zAcceleration = 50
        cell.emissionRange = spreadRadius
        cell.birthRate = birthRate
        cell.lifetime = lifetime
        cell.lifetimeRange = 4
        cell.redRange = 0.3
        cell.redSpeed = 0.5
        cell.greenRange = 0.3
        cell.greenSpeed = 0.5
        cell.blueRange = 0.3
        cell.blueSpeed = 0.5
        cell.alphaRange = 0.9
        cell.alphaSpeed = alphaSpeed
        cell.fillMode = .forwards
        
        cell.contents = content.image.cgImage
        if let color = content.color {
            cell.color = color.cgColor
        }
        
        return cell
    }
}
