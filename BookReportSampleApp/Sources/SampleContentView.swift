//
//  SampleContentView.swift
//  BookReportApp
//
//  Created by 최지석 on 6/10/24.
//

import SwiftUI

public struct SampleContentView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: BookFlipView()) {
                    Text("Page flip")
                }
                NavigationLink(destination: MarkDownEditorView()) {
                    Text("Markdown Editor")
                }
            }
            .navigationTitle("Sample App")
        }
    }
}


struct SampleContentView_Previews: PreviewProvider {
    static var previews: some View {
        SampleContentView()
    }
}

