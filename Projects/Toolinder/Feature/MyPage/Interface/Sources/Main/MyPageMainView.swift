//
//  MyPageMainView.swift
//  ToolinderFeatureMyPageInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI
import StoreKit

import ComposableArchitecture

import ToolinderShared

public struct MyPageMainView: View {
    let store: StoreOf<MyPageMainStore>
    
    public init(store: StoreOf<MyPageMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                Section {
                    removeADView(viewStore: viewStore)
                }
                
                Section {
                    whatIsNewView(viewStore: viewStore)
                    
                    if let url = URL(string: "https://tally.so/r/mJpaR4") {
                        usabilityQuestionnaireView(url: url)
                    }
                }
            }
            .navigationTitle("MyPage")
            .onAppear {
                Task {
                    await self.test()
                }
            }
            .sheet(
                store: self.store.scope(
                    state: \.$removeAD,
                    action: { .removeAD($0) }
                )
            ) {
                RemoveADView(store: $0)
            }
        }
    }
    
    @MainActor
    func test() async {
        do {
            let storeProducts = try await Product.products(for: ["com.tamsadan.toolinder.removead"])
            debugPrint(storeProducts)
        } catch {
            
        }
    }
    
    private func removeADView(viewStore: ViewStoreOf<MyPageMainStore>) -> some View {
        Button(action: {
            viewStore.send(.removeADTapped)
        }, label: {
            Label(
                title: { Text("Remove AD") },
                icon: {
                    Image(systemName: "crown.fill")
                        .foregroundStyle(.yellow)
                }
            )
        })
    }
    
    private func whatIsNewView(viewStore: ViewStoreOf<MyPageMainStore>) -> some View {
        Button(action: {
            viewStore.send(.whatIsNewTapped)
        }, label: {
            Label(
                title: { Text("What's New \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")") },
                icon: {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(.blue)
                }
            )
        })
    }
    
    private func usabilityQuestionnaireView(url: URL) -> some View {
        Link(destination: url, label: {
            Label(title: {
                Text("Usability Questionnaire")
            }, icon: {
                Image(systemName: "doc.text.image.fill")
                    .foregroundStyle(.blue)
            })
        })
    }
}
