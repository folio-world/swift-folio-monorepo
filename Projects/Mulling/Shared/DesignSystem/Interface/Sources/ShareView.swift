//
//  ShareView.swift
//  MullingSharedDesignSystemInterface
//
//  Created by 송영모 on 2023/08/24.
//

import SwiftUI

public struct SharingView: UIViewControllerRepresentable {
    let content: String
//    let url: URL
    
    public init(content: String) {
        self.content = content
    }
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [content], applicationActivities: nil)
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
