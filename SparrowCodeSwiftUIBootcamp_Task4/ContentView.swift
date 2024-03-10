//
//  ContentView.swift
//  SparrowCodeSwiftUIBootcamp_Task4
//
//  Created by Валерий Зазулин on 09.03.2024.
//

import SwiftUI

struct NextTrackButtonStyle: ButtonStyle {
    
    @Binding var circleAnimation: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(circleAnimation ? 0.3 : 0))
            
            configuration.label
                .padding()
        }
        .scaleEffect(circleAnimation ? 0.86 : 1)
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
            
            if !circleAnimation {
                withAnimation(.bouncy(duration: 0.22)) {
                    circleAnimation = true
                } completion: {
                    withAnimation(.bouncy(duration: 0.22)) {
                        circleAnimation = false
                    }
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
                            .frame(width: performAnimation ? 0.5 : width)
                            .opacity(performAnimation ? .zero : 1)
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                }
        }
        .buttonStyle(NextTrackButtonStyle(circleAnimation: $circleAnimation))
        .frame(maxWidth: 82)
    }
}

#Preview {
    NextTrackButtonWithCircle()
}
