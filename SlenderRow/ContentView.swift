//
//  ContentView.swift
//  SlenderRow
//
//  Created by Nikita Koruts on 16.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isHorizontal = true
    
    var body: some View {
        layout {
            ForEach(0..<7) { index in
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.blue)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding(.horizontal)
        .onTapGesture {
            withAnimation {
                isHorizontal.toggle()
            }
        }
    }
    
    private var layout: AnyLayout {
        return isHorizontal ? AnyLayout(HStackLayout()) : AnyLayout(DiagonalLayout())
    }
}

struct DiagonalLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let count = subviews.count
        let subviewHeight = bounds.height / CGFloat(count)
        
        let step = (bounds.width - subviewHeight) / CGFloat(count - 1)
        
        for (index, view) in subviews.enumerated() {
            view.place(
                at: .init(
                    x: CGFloat(index) * step + bounds.minX,
                    y: (bounds.maxY - subviewHeight) - (subviewHeight * CGFloat(index))),
                proposal: .init(
                    width: subviewHeight,
                    height: subviewHeight))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
