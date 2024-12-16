//
//  ContentView.swift
//  task-6
//
//  Created by kamaz on 15.12.2024.
//

import SwiftUI


struct ContentView: View {
    let count: Int = 10
    @State private var isVertical = false

    var body: some View {
        BasicVStack(isVertical: isVertical) {
            ForEach(0..<count, id: \.self) { _ in
                TapView(isVertical: $isVertical)
            }
        }
    }
}

struct BasicVStack: Layout {
    let isVertical: Bool

    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache _: inout ()) -> CGSize {
        guard let width = proposal.width, let height = proposal.height else {
            return CGSize(width: 0, height: 0)
        }
        
        return isVertical ? CGSize(width: width, height: height) : CGSize(width: width, height: width / CGFloat(subviews.count))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache _: inout ()) {
        let size = isVertical ? bounds.height / CGFloat(subviews.count) : (bounds.width - 10 * CGFloat(subviews.count - 1)) / CGFloat(subviews.count)
        
        for (index, view) in subviews.enumerated() {
            let x = isVertical ? CGFloat(index) * (bounds.width - size) / CGFloat(subviews.count - 1) : CGFloat(index) * (size + 10)
            let y = isVertical ? bounds.maxY - (CGFloat(index) * (bounds.height - size) / CGFloat(subviews.count - 1) + size) : bounds.midY - size / 2
            
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: size, height: size))
        }
    }
}

#Preview {
    ContentView()
}

struct TapView: View {
    @Binding var isVertical: Bool
    
    private var tapGesture: some Gesture {
        TapGesture()
            .onEnded { _ in
                withAnimation {
                    isVertical.toggle()
                }
            }
        
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.blue)
            .gesture(tapGesture)
    }
}
