//
//  MyPageMainView.swift
//  ToolinderFeatureMyPageInterface
//
//  Created by 송영모 on 2023/09/11.
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
            List {
                Section {
                    existingUserPolicyItem(viewStore: viewStore)
                }
                
                Section {
                    if let url = URL(string: "https://tally.so/r/mJpaR4") {
                        Link(destination: url, label: {
                            Label(
                                title: {
                                    Text("Usability Questionnaire")
                                }, icon: {
                                    Image(systemName: "doc.text.image.fill")
                                        .foregroundStyle(.blue)
                                }
                            )
                        })
                    }
                }
            }
            .navigationTitle("MyPage")
        }
    }
    
    private func existingUserPolicyItem(viewStore: ViewStoreOf<MyPageMainStore>) -> some View {
        HStack {
            Label(
                title: {
                    Text("Existing User Policy")
                }, icon: {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(.blue)
                }
            )
            Spacer()
            Button(
                action: {
                    viewStore.send(.existingUserPolicyTapped)
                },
                label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                }
            )
        }
    }
}
