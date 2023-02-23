//
//  HomeView.swift
//  RestartApp
//
//  Created by Mehmet Ergün on 2023-02-23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            Spacer()
            Spacer()
//            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            
//            Color(.white)
            
            
            
            //HEADER
            
            ZStack {
//                Circle()
//                    .stroke(Color("ColorBlue").opacity(0.2), lineWidth: 30)
//                    .frame(width: 360, height: 360, alignment: .center)
//                    .offset(y: -140)
                
                CircleView(ShapeColor: Color("ColorBlue"), ShapeOpacity: 0.2, LineWidth: 30)
                    .frame(width: 360, height: 360, alignment: .center)
                    .offset(y: -140)
                    .padding()

                CircleView(ShapeColor: Color("ColorBlue"), ShapeOpacity: 0.2, LineWidth: 60)
                    .frame(width: 220, height: 220, alignment: .center)
                    .offset(y: -140)
                    .padding()

//                CircleView(ShapeColor: Color("ColorBlue"), ShapeOpacity: 0.4, LineWidth: 70)
//                    .frame(width: 120, height: 120, alignment: .center)
//                    .offset(y: -140)
//
//                CircleView(ShapeColor: Color("ColorBlue"), ShapeOpacity: 0.5, LineWidth: 90)
//                    .frame(width: 80, height: 80, alignment: .center)
//                    .offset(y: -140)
                
                CircleView(ShapeColor: Color("ColorBlue"), ShapeOpacity: 0.2, LineWidth: 90)
                    .frame(width: 120, height: 120, alignment: .center)
                    .offset(y: -140)
                    .padding()
                    
//                Circle()
//                    .stroke(Color("ColorBlue").opacity(0.3), lineWidth: 20)
//                    .frame(width: 220, height: 220, alignment: .center)
//                    .offset(y: -140)
////
//                Circle()
//                    .stroke(Color("ColorBlue").opacity(0.4), lineWidth: 10)
//                    .frame(width: 120, height: 120, alignment: .center)
//                    .offset(y: -140)
                
                Image("character-2")
                
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeInOut(duration: 4)
                        .repeatForever()
                        , value: isAnimating)
                
            }//:ZStack

            Spacer()
            
            //CENTER
            
            Text("""
            The time that leads to mastery is dependent on the intensity of our focus.
            """)
            .font(.title3)
            .fontWeight(.light)
//            .foregroundColor()
            .multilineTextAlignment(.center)
            .padding()
            
            
            
            Spacer()
            
            //FOOTER
            
            Button(action: {
                withAnimation {
                    isOnboardingViewActive = true
                    playSound(sound: "success", type: "m4a")
                }
            }) {
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Restart")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                
            }
            .padding(10)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
            Spacer()
           
            
        }//:VSTACK
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
