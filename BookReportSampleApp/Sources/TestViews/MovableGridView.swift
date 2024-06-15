//
//  MovableGridView.swift
//  BookReportSampleApp
//
//  Created by 최지석 on 6/14/24.
//

import Foundation
import SwiftUI

struct MovableGridView: View {
    
    @State var colors: [Color] = [.purple, .black, .indigo, .cyan, .brown, .yellow, .mint, .orange, .red, .green, .gray, .teal, .yellow]
    @State var draggingItem: Color?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    let columns = Array(repeating: GridItem(spacing: 10), count: 3)
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        ForEach(colors, id: \.self) { color in
                            GeometryReader {
                                let size = $0.size
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color.gradient)
                                    .draggable(color) {
                                        // Custom Preview
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.ultraThinMaterial)
                                            .frame(width: 1, height: 1)
                                            .onAppear {
                                                draggingItem = color
                                            }
                                    }
                                    .dropDestination(for: Color.self) { items, location in
                                        draggingItem = nil
                                        return false
                                    } isTargeted: { status in
                                        if let draggingItem, status, draggingItem != color {
                                            if let sourceIndex = colors.firstIndex(of: draggingItem), let destinationIndex = colors.firstIndex(of: color) {
                                                withAnimation(.bouncy) {
                                                    let sourceItem = colors.remove(at: sourceIndex)
                                                    colors.insert(sourceItem, at: destinationIndex)
                                                }
                                            }
                                        }
                                    }
                            }
                            .frame(height: 100)
                        }
                    })
                }
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.15))
            .navigationTitle("Movable Grid")
        }
    }
}


#Preview {
    MovableGridView()
}
