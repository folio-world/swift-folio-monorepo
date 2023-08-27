//
//  PointView.swift
//  MullingFeatureChatInterface
//
//  Created by 송영모 on 2023/08/25.
//

import SwiftUI

import MullingDomain

public struct PointView: View {
    let point: PointEntity
    
    public init(point: PointEntity) {
        self.point = point
    }
    
    public var body: some View {
        Text("\(point.current) P")
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(point.current >= 0 ? .black : .pink)
            )
    }
    
}
