//
//  MarkDownEditor.swift
//  BookReportSampleApp
//
//  Created by 최지석 on 6/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct MarkDownEditorView: View {
    @State private var markdownText: String = """
    **Bold** 1. Ordered list
    """
    @State private var isDocumentPickerPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $markdownText)
                    .padding()
                    .border(Color.gray, width: 1)
                
                Button(action: {
                    isDocumentPickerPresented = true
                }) {
                    Text("Export Markdown")
                }
                .padding()
                .fileExporter(
                    isPresented: $isDocumentPickerPresented,
                    document: MarkdownDocument(content: markdownText),
                    contentType: .plainText,
                    defaultFilename: "example.txt"
                ) { result in
                    switch result {
                    case .success(let url):
                        print("Markdown file exported to \(url)")
                    case .failure(let error):
                        print("Failed to export file: \(error.localizedDescription)")
                    }
                }
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.15))
            .navigationTitle("Page Flip")
        }
    }
}

struct MarkdownDocument: FileDocument {
    var content: String

    static var readableContentTypes: [UTType] { [.plainText] }

    init(content: String) {
        self.content = content
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents,
           let content = String(data: data, encoding: .utf8) {
            self.content = content
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(content.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

#Preview {
    MarkDownEditorView()
}
