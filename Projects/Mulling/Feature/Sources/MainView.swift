//
//  MainView.swift
//  MullingFeature
//
//  Created by 송영모 on 2023/08/21.
//

import SwiftUI

import MullingFeatureChat
import MullingFeatureChatInterface

struct MainView: View {
    var body: some View {
        ChatView(viewModel: .init())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
