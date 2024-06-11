//
//  BookFlipView.swift
//  BookReportSampleApp
//
//  Created by 최지석 on 6/11/24.
//

import SwiftUI

struct BookFlipView: View {
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                OpenableBookView(config: .init(progress: progress),
                                 front: { size in 
                                    FrontView(size)
                                 },
                                 insideLeft: { size in
                                    LeftView()
                                 },
                                 insideRight: { size in
                                    RightView()
                                 })
                HStack(spacing: 12) {
                    Slider(value: $progress)
                    
                    Button("Toggle") {
                        withAnimation(.snappy(duration: 1)) {
                            progress = (progress == 1.0 ? 0.2 : 1.0)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(10)
                .background(in: .rect(cornerRadius: 10))
                .padding(.top, 50)
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.15))
            .navigationTitle("Page Flip")
        }
    }
    
    @ViewBuilder
    func FrontView(_ size: CGSize) -> some View {
        Image("book1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
    }
    
    @ViewBuilder
    func LeftView() -> some View {
        VStack(spacing: 5) {
            Image("book2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .shadow(color: .black.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
            
            Text("Tamara Bundy")
                .fontWidth(.condensed)
                .fontWeight(.bold)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
                   
    @ViewBuilder
    func RightView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.system(size: 14))
            
            Text("Tamara Bundy's beautifully written debut celebrates the wonder and power of friendship: how it can be found when we least expect in and make any place a home.")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
                                 
                                 
}
                                 

/// Interactive Book Card View
struct OpenableBookView<Front: View, InsideLeft: View, InsideRight: View>: View, Animatable {
    
    var config: Config = .init()
    
    @ViewBuilder var front: (CGSize) -> Front
    @ViewBuilder var insideLeft: (CGSize) -> InsideLeft
    @ViewBuilder var insideRight: (CGSize) -> InsideRight
    
    var animatableData: CGFloat {
        get { return config.progress }
        set { config.progress = newValue }
    }
    
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            /// Limitting Progress between 0 to 1
            let progress = max(min(config.progress, 1), 0)
            let rotation = progress * -180
            let cornerRadius = config.cornerRadius
            let shadowColor = config.shadowColor
            
            ZStack {
                insideRight(size)
                    .frame(width: size.width, height: size.height)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0, 
                            bottomTrailingRadius: cornerRadius,
                            topTrailingRadius: cornerRadius
                        ))
                    .shadow(color: shadowColor.opacity(0.1 * progress), radius: 5, x: 5, y: 0)
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(config.dividerBackground.shadow(.inner(color: shadowColor.opacity(0.15), radius: 2)))
                            .frame(width: 6)
                            .offset(x: -3)
                            .clipped()
                    }
                
                front(size)
                    .frame(width: size.width, height: size.height)
                    /// Disable interaction once it's flipped
                    .allowsHitTesting(-rotation < 90)
                    .overlay {
                        if -rotation > 90 {
                            insideLeft(size)
                                .frame(width: size.width, height: size.height)
                                .scaleEffect(x: -1)
                                .transition(.identity)
                        }
                    }
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: cornerRadius,
                            topTrailingRadius: cornerRadius
                        ))
                    .shadow(color: shadowColor.opacity(0.1), radius: 5, x: 5, y: 0)
                    .rotation3DEffect(
                        .init(degrees: rotation),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .leading,
                        perspective: 0.4
                    )
            }
            .offset(x: (config.width / 2) * progress)
        }
        .frame(width: config.width, height: config.height)
    }
    
    struct Config {
        var width: CGFloat = 150
        var height: CGFloat = 200
        var progress: CGFloat = 0
        var cornerRadius: CGFloat = 10
        var shadowColor: Color = .black
        var dividerBackground: Color = .white
    }
}

#Preview {
    BookFlipView()
}


// MARK: 참고용 코드

//import SwiftUI
//
//struct BookFlipView: View {
//    
//    @State private var progress: CGFloat = 0
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                OpenableBookView(config: .init(progress: progress),
//                                 pages: [
//                                    { size in AnyView(FrontView(size)) },
//                                    { size in AnyView(LeftView()) },
//                                    { size in AnyView(RightView()) }
//                                 ])
//                HStack(spacing: 12) {
//                    Slider(value: $progress, in: 0...2, step: 1)
//                    
//                    Button("Toggle") {
//                        withAnimation(.snappy(duration: 1)) {
//                            progress = (progress == 2.0 ? 0.0 : progress + 1.0)
//                        }
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//                .padding(10)
//                .background(in: .rect(cornerRadius: 10))
//                .padding(.top, 50)
//            }
//            .padding(15)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.gray.opacity(0.15))
//            .navigationTitle("Book View")
//        }
//    }
//    
//    @ViewBuilder
//    func FrontView(_ size: CGSize) -> some View {
//        Image("book1")
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: size.width, height: size.height)
//    }
//    
//    @ViewBuilder
//    func LeftView() -> some View {
//        VStack(spacing: 5) {
//            Image("book2")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//                .shadow(color: .black.opacity(0.15), radius: 10, x: 5, y: 5)
//            
//            Text("Tamara Bundy")
//                .fontWidth(.condensed)
//                .fontWeight(.bold)
//                .padding(.top, 8)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.background)
//    }
//                   
//    @ViewBuilder
//    func RightView() -> some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Description")
//                .font(.system(size: 14))
//            
//            Text("Tamara Bundy's beautifully written debut celebrates the wonder and power of friendship: how it can be found when we least expect it and make any place a home.")
//                .font(.caption)
//                .foregroundStyle(.gray)
//        }
//        .padding(10)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.background)
//    }
//}
//
//struct OpenableBookView<Content: View>: View, Animatable {
//    
//    var config: Config = .init()
//    var pages: [(CGSize) -> Content]
//    
//    var animatableData: CGFloat {
//        get { return config.progress }
//        set { config.progress = newValue }
//    }
//    
//    var body: some View {
//        GeometryReader { geometry in
//            let size = geometry.size
//            let progress = max(min(config.progress, CGFloat(pages.count - 1)), 0)
//            let currentIndex = Int(progress)
//            let nextIndex = min(currentIndex + 1, pages.count - 1)
//            let rotation = (progress - CGFloat(currentIndex)) * -180
//            let cornerRadius = config.cornerRadius
//            let shadowColor = config.shadowColor
//            
//            ZStack {
//                pages[nextIndex](size)
//                    .frame(width: size.width, height: size.height)
//                    .clipShape(
//                        RoundedRectangle(
//                            cornerRadius: cornerRadius,
//                            style: .continuous
//                        )
//                    )
//                    .shadow(color: shadowColor.opacity(0.1 * Double(progress - CGFloat(currentIndex))), radius: 5, x: 5, y: 0)
//                    .overlay(alignment: .leading) {
//                        Rectangle()
//                            .fill(config.dividerBackground.shadow(.inner(color: shadowColor.opacity(0.15), radius: 2)))
//                            .frame(width: 6)
//                            .offset(x: -3)
//                            .clipped()
//                    }
//                
//                pages[currentIndex](size)
//                    .frame(width: size.width, height: size.height)
//                    .allowsHitTesting(rotation > -90)
//                    .overlay {
//                        if rotation <= -90 {
//                            pages[nextIndex](size)
//                                .frame(width: size.width, height: size.height)
//                                .scaleEffect(x: -1)
//                                .transition(.identity)
//                        }
//                    }
//                    .clipShape(
//                        RoundedRectangle(
//                            cornerRadius: cornerRadius,
//                            style: .continuous
//                        )
//                    )
//                    .shadow(color: shadowColor.opacity(0.1), radius: 5, x: 5, y: 0)
//                    .rotation3DEffect(
//                        .degrees(rotation),
//                        axis: (x: 0.0, y: 1.0, z: 0.0),
//                        anchor: .leading,
//                        perspective: 0.4
//                    )
//            }
//            .offset(x: (config.width / 2) * (progress - CGFloat(currentIndex)))
//        }
//        .frame(width: config.width, height: config.height)
//    }
//    
//    struct Config {
//        var width: CGFloat = 150
//        var height: CGFloat = 200
//        var progress: CGFloat = 0
//        var cornerRadius: CGFloat = 10
//        var shadowColor: Color = .black
//        var dividerBackground: Color = .white
//    }
//}
//
//#Preview {
//    BookFlipView()
//}
