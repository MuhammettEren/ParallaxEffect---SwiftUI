//
//  ContentView.swift
//  ParallaxEffect
//
//  Created by Muhammet Eren on 6.02.2025.
//

import SwiftUI
import CoreMotion

struct ParallaxEffectView: View {
    @State private var dragOffset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 350,height: 450)
                        .foregroundColor(Color.black.opacity(0.8))
                        .blur(radius: 3)
                    Image("swift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                     
                }
                .offset(
                    x: dragOffset.width / 20,
                    y: dragOffset.height / 10
                )
                .rotation3DEffect(
                    .degrees(dragOffset.width / 20),
                    axis: (x: 0, y: 1, z: 0)
                )
                .rotation3DEffect(
                    .degrees(-dragOffset.height / 20),
                    axis: (x: 1, y: 0, z: 0)
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            dragOffset = value.translation
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                dragOffset = .zero
                                isDragging = false
                            }
                        }
                )
                .shadow(color: isDragging ? .black.opacity(0.3) : .clear, radius: 10, x: 0, y: 10)
                .frame(width: geometry.size.width,height: geometry.size.height,alignment: .center)
            }
        }
    }
}

#Preview {
    ParallaxEffectView()
}
