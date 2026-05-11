//
//  AnimatedLogoView.swift
//  RefreshAsThreads
//
//  Created by Valeh Amirov on 11.05.26.
//
import SwiftUI

struct AnimatedLogoView: View {
    
    @State private var trimFrom: CGFloat = 0
    @State private var trimTo: CGFloat = 0
    @State private var yellowTrimFrom: CGFloat = 1
    @State private var yellowTrimTo: CGFloat = 1
    
    @State private var opacity: Double = 1
    
    @State private var scrollCanAnimate = true
    @State private var scaleEffect = false
    @State private var processDidDone: Bool = true
    
    let size: CGFloat
    let scrollRatio: CGFloat
    
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        let path = LogoPath().path(
            in: .init(
                origin: .zero,
                size: .init(width: size, height: size)
            )
        )
        ZStack {
            
            path
                .stroke(Color.black.opacity(opacity), lineWidth: size / 15.4)
            path
                .trim(from: yellowTrimFrom, to: yellowTrimTo)
                .stroke(
                    Color.yellow,
                    style: .init(
                        lineWidth: size / 15.4 + 2,
                        lineCap: .butt,
                        lineJoin: .round
                    )
                )
            path
                .trim(from: trimFrom, to: trimTo)
                .stroke(
                    Color.black,
                    style: .init(
                        lineWidth: size / 15.4,
                        lineCap: .butt,
                        lineJoin: .round
                    )
                )
        }
        .scaleEffect(scaleEffect ? 1.2 : 1)
        .animation(.easeInOut(duration: 0.2),
                   value: scaleEffect)
        
        .frame(width: size, height: size)
        .onValueChange(of: scrollRatio) { oldValue, newValue in
            let old = oldValue == 0 ? 0.04 : oldValue
            
            
            guard scrollCanAnimate,
                  processDidDone else {
                processDidDone = newValue == 0
                return
            }
            
            if (newValue / old <= 10 || old > newValue) && old < 1.08 {
                updateTrim(with: newValue)
            } else if old < 1 && 1 < newValue {
                scrollCanAnimate = false
                Task {
                    opacity = 0.3
                    resetAnimation()
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    autoAnimation()
                }
            }
        }
    }
    
    private func updateTrim(with progress: CGFloat) {
        if progress < 1.08 {
            opacity = max(0.3, 1 - progress * 3)
            track(progress: progress)
        } else {
            autoAnimation()
        }
    }
    
    private func track(progress: CGFloat)  {
        withAnimation(.interactiveSpring) {
            trimFrom = 1 - progress - 0.11
            trimTo = 1 - progress
        }
    }
    
    private func autoAnimation() {
        scrollCanAnimate = false
        processDidDone = false

        Task {
            scaleEffect = true
            try await Task.sleep(nanoseconds: 0_200_000_000)
            scaleEffect = false
            
            try await Task.sleep(nanoseconds: 0_300_000_000)
            
            animateReverse()
            
            try await Task.sleep(nanoseconds: 1_300_000_000)
            
            animateFull()
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            animateYellow()
            
            try await Task.sleep(nanoseconds: 2_100_000_000)
            
            resetAnimation()
            scrollCanAnimate = true
        }
    }
    
    private func resetAnimation() {
        
        opacity = 1
        trimTo = 0
        trimFrom = 0
        yellowTrimTo = 1
        yellowTrimFrom = 1
    }
    
    private func animateReverse()  {
        withAnimation(.linear(duration: 1)) {
            trimFrom = 1
            trimTo = 1.1
        }
    }
    
    private func animateFull()  {
        withAnimation(.easeIn(duration: 1)) {
            trimFrom = -0.1
            trimTo = 1
        }
    }
    
    private func animateYellow()  {
        withAnimation(.easeIn(duration: 1)) {
            yellowTrimFrom = 0
            yellowTrimTo = 1
        }
    }
}
