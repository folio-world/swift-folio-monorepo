//
//  ImageItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/16.
//

import SwiftUI

public struct ImageItem: View {
    let imageData: Data
    
    public init(imageData: Data) {
        self.imageData = imageData
    }
    
    public var body: some View {
        VStack {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 48)
            }
        }
        .background(Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
