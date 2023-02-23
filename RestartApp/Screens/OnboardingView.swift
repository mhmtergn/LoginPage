//
//  OnboardingView.swift
//  RestartApp
//
//  Created by Mehmet Ergün on 2023-02-23.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - PROPERTY
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffSet: CGFloat = 0
    @State private var buttonText: String = "Get Started"
    @State private var isAnimating: Bool = false
    @State private var imageOffSet: CGSize = .zero
    @State private var headerText: String = "Share"
    @State private var indicatorOpacity: Double = 1.0
    
    let hapticFeedBack = UINotificationFeedbackGenerator()
    
    //MARK: - BODY
    
    var body: some View {
        ZStack {
            
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {

                //MARK: - HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(headerText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(headerText)
                    
                    Text("""
                            It's not how much we give but how much love we put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                }//:Header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 1 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
                //MARK: - CENTER
                
                ZStack {
                    
//                    ZStack {
                        CircleView(ShapeColor: .white, ShapeOpacity: 0.2, LineWidth: 40)
                            .frame(width: 280, height: 280, alignment: .center)
                            .offset(x: imageOffSet.width * -1)
                            .blur(radius: abs(imageOffSet.width / 5))
                            .animation(.easeOut(duration: 1), value: imageOffSet)
                        CircleView(ShapeColor: .white, ShapeOpacity: 0.1, LineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                            .offset(x: imageOffSet.width * -1)
                            .blur(radius: abs(imageOffSet.width / 5))
                            .animation(.easeOut(duration: 1), value: imageOffSet)
//                    }
                    
                    
                    
                   //:Zstack
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffSet.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffSet.width / 20)))
                        .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                if abs(imageOffSet.width) <= 150 {
                                    imageOffSet = gesture.translation
                                    
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 0
                                        headerText = "Give"
                                    }
                                    
                                }
                            })
                            .onEnded({ _ in
                                imageOffSet = .zero
                                
                                
                                withAnimation(.linear(duration: 0.25)) {
                                    indicatorOpacity = 1
                                    headerText = "Share"
                                }
                                
                            })
                        )
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                        
                }//:Center
                .overlay(Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                
                
                Spacer()
                
                //MARK: - FOOTER
                
                ZStack {
                    
                    // Parts of the custom button
                    
                    //1.Background(Static)
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    //2.Call-to-Action(Static)
                    
                    Text(buttonText)
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(buttonText)
                        .offset(x: 20)
                    
                    //3.Capsule(Dynamic Width)
                    
                    
                    HStack {
                        Capsule()
                        .fill(Color("ColorRed"))
                            .frame(width: buttonOffSet + 80)
                        
                        Spacer()
                    }

                        //4.Circle(Draggable)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color("ColorRed"))
                                
                                Circle()
                                    .fill(.black.opacity(0.15))
                                    .padding(8)
                                
                                Circle()
                                    .fill(.black.opacity(0.18))
                                    .padding(20)
                                
                                Image(systemName: "chevron.right.2")
                                    .font(.system(size: 24, weight: .bold))
                  
                            }
                            .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffSet)
                        .gesture(DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.width > 0 && buttonOffSet <= buttonWidth - 80 {
                                    buttonOffSet = gesture.translation.width
                                    buttonText = "Moving Next Page"
                                    
                                }
                            }
                            .onEnded { _ in
                                
                                withAnimation(Animation.easeOut(duration: 0.4)) {
                                    if buttonOffSet > buttonWidth / 2 {
                                        playSound(sound: "chimeup", type: "mp3")
                                        hapticFeedBack.notificationOccurred(.success)
                                        buttonOffSet = buttonWidth - 80
                                        isOnboardingViewActive = false
                                        
                                    }else {
                                        buttonOffSet = 0
                                        hapticFeedBack.notificationOccurred(.warning)
                                        buttonText = "Get Started"  
                                    }
                                }
                                
                                
                            }
                        )//:Gesture
                            
                            Spacer()
                        
                    }//:HStack
   
                }//:Footer
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VSTACK
        }//: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
