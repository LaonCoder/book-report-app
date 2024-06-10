//
//  SplashView.swift
//  BookReportSampleApp
//
//  Created by 최지석 on 6/10/24.
//

import SwiftUI

struct SampleSplashView: View {
    @State private var isSplashDisplaying = true
    
    var body: some View {
        Group {
            if isSplashDisplaying {
                VStack {
                    Text("Sample App Splash")
                        .font(.largeTitle)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            isSplashDisplaying = false
                        }
                    }
                }
            } else {
                SampleContentView()
            }
        }
    }
}
