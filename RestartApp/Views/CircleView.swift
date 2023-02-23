//
//  CircleView.swift
//  RestartApp
//
//  Created by Mehmet Ergün on 2023-02-23.
//

import SwiftUI

struct CircleView: View {
    
    //MARK: - PROPERTY
    
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State var LineWidth: CGFloat
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: LineWidth)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: LineWidth)
                .frame(width: 260, height: 260, alignment: .center)
        }
            .blur(radius: isAnimating ? 0 : 10)
            .opacity(isAnimating ? 1 : 0)
            .scaleEffect(isAnimating ? 1 : 0.5)
            .animation(.easeOut(duration: 1), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
           

    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all ,edges: .all)
            CircleView(ShapeColor: .white, ShapeOpacity: 0.2, LineWidth: 40)
        }
    }
}
