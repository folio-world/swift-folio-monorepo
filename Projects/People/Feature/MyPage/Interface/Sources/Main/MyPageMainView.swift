//
//  MyPageMainView.swift
//  DyingFeatureMyPageInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct MyPageMainView: View {
    let store: StoreOf<MyPageMainStore>
    
    public init(store: StoreOf<MyPageMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    Divider()
                    
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                        
                        VStack {
                            Text("닉네임")
                                .font(.title3)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        })
                    }
                    
                    Divider()
                }
            }
            .padding(.horizontal)
            .navigationTitle("My")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
