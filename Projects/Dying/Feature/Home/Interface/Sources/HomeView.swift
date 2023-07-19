//
//  HomeView.swift
//  DyingFeatureHome
//
//  Created by 송영모 on 2023/07/19.
//

import SwiftUI

public struct HomeView: View {
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("다잉")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("죽음에 대한 완전한 고찰")
                .font(.caption)
                .foregroundColor(.gray)
            
            TimelineView(.periodic(from: .now, by: 1)) { _ in
                Text("\(Date.now.timeIntervalSince1970)")
            }
            
            HStack {
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
