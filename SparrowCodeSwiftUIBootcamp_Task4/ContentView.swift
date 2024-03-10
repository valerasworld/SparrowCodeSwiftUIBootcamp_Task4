//
//  ContentView.swift
//  SparrowCodeSwiftUIBootcamp_Task4
//
//  Created by Валерий Зазулин on 09.03.2024.
//

import SwiftUI

struct NextTrackButtonStyle: ButtonStyle {
    
    @State private var circleAnimation: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(Color.secondary.opacity(circleAnimation ? 0.3 : 0))
            configuration.label
                .padding(12)
        }
        .scaleEffect(circleAnimation ? 0.86 : 1)
        .animation(.easeInOut(duration: 0.22), value: circleAnimation)
        .onChange(of: configuration.isPressed) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: 0.22)) {
                    circleAnimation = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                    circleAnimation = false
                }
            }
        }
    }
}

struct NextTrackButtonWithCircle: View {
    
    @State var performAnimation: Bool = false
    @State var circleAnimation: Bool = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
                GeometryReader { proxy in
                    let width = proxy.size.width / 2
                    let systemName = "play.fill"

                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: systemName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: performAnimation ? width : .zero)
                            .opacity(performAnimation ? 1 : .zero)
                        Image(systemName: systemName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width)
                        Image(systemName: systemName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: performAnimation ? .zero : width)
                            .opacity(performAnimation ? .zero : 1)
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                }
        }
        .buttonStyle(NextTrackButtonStyle())
        .frame(maxWidth: 62)
    }
}

#Preview {
    NextTrackButtonWithCircle()
}
