//
//  LogoPath.swift
//  RefreshAsThreads
//
//  Created by Valeh Amirov on 11.05.26.
//


import SwiftUI

struct LogoPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
            let scaleX = rect.size.width / 400
            let scaleY = rect.size.height / 400

            func point(x: CGFloat,y: CGFloat) -> CGPoint {
                return CGPoint(x: x * scaleX, y: y * scaleY)
            }
        
        path.move(to: point(x: 148.36,y: 144.49))
        
        path.addCurve(
            to: point(x: 201.05,y: 116.77),
            control1: point(x: 160.3,y: 127.22),
            control2: point(x: 174.03,y: 116.77)
        )
        path.addCurve(
            to: point(x: 266.83,y: 194.77),
            control1: point(x: 253.14,y: 116.77),
            control2: point(x: 266.38,y: 150.47)
        )
        path.addCurve(
            to: point(x: 203.03,y: 281.1),
            control1: point(x: 266.83,y: 240.13),
            control2: point(x: 249.8,y: 281.1)
        )
        path.addCurve(
            to: point(x: 148.36, y: 221.75),
            control1: point(x: 159.52,y: 281.1),
            control2: point(x: 139.87, y: 252.48)
        )
        path.addCurve(
            to: point(x: 266.83,y: 194.77),
            control1: point(x: 158.94,y: 183.39),
            control2: point(x: 219.07,y: 178.38)
        )
        path.addCurve(
            to: point(x: 313.98,y: 227.86),
            control1: point(x: 286.12,y: 201.38),
            control2: point(x: 304.54,y: 212.67)
        )
        path.addCurve(
            to: point(x: 203.82,y: 369),
            control1: point(x: 351.13,y: 287.69),
            control2: point(x: 302.77,y: 369)
        )
        path.addCurve(
            to: point(x: 57, y: 199.5),
            control1: point(x: 97.92, y: 369),
            control2: point(x: 57, y: 293.11)
        )
        path.addCurve(
            to: point(x: 203.82,y: 30),
            control1: point(x: 57,y: 105.89),
            control2: point(x: 97.04,y: 30)
        )
        path.addCurve(
            to: point(x: 343, y: 134.58),
            control1: point(x: 284.37, y: 30),
            control2: point(x: 326.94, y: 73.18)
        )
        return path
    }
}