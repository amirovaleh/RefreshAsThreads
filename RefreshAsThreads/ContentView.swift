//
//  ContentView.swift
//  RefreshAsThreads
//
//  Created by Valeh Amirov on 11.05.26.
//

import SwiftUI

struct ContentView: View {
    @State private var stretch: CGFloat = 0
    private let baseHeight: CGFloat = 60
    
    var body: some View {
        
        ZStack {
            ScrollView {
                GeometryReader { geo in
                    let minY = geo.frame(in: .named("scroll")).minY
                    Color.clear
                        .onValueChange(of: minY) { oldValue, value in
                            Task {
                                stretch = value
                            }
                        }
                }
                .frame(height: 0)
                LazyVStack {
                    ForEach(1...100, id: \.self) {
                        Text("Row \($0)")
                        Divider()
                    }
                }
                .padding(.top, baseHeight)
            }
            .coordinateSpace(name: "scroll")
            .overlay(alignment: .top) {
                HStack {
                    Spacer()
                    AnimatedLogoView(
                        size: min(
                            max(41, 41 + stretch * 0.25),
                            47
                        ),
                        scrollRatio: stretch / 100
                    )
                    Spacer()
                }
                .frame(height: max(baseHeight, baseHeight + stretch))
                .frame(maxWidth: .infinity)
                .background(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
