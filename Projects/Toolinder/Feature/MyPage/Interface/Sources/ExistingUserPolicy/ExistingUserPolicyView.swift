//
//  ExistingUserPolicyView.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 2023/09/14.
//

import SwiftUI

import ComposableArchitecture

public struct ExistingUserPolicyView: View {
    let store: StoreOf<ExistingUserPolicyStore>
    
    public init(store: StoreOf<ExistingUserPolicyStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("1 버전을 사용해주신 고마운 사용자분들께")
                            .font(.body)
                            .padding(.bottom, 5)
                        
                        Text("여러분께 아주 죄송한 마음 뿐입니다.")
                            .font(.headline)
                        
                        Text("우선 지금부터 하는 얘기는 기존 사용자들의 데이터를 살리지 못하는 결정을 내리게된 이유를 설명드리려고 합니다. 앱을 업데이트 했는데, 데이터가 모두 사라지는 현상이 있었습니다. 그래서 이를 해결하고자 하였지만, 아주 오래전 작성된 코드(물론 제가 작성했었음)는 문제가 있었고 현재 모두 새로운 것으로 고쳤습니다. 그래서 현재 버전부터는 모든 문제가 해결되었지만, 기존에 발생하고 있던 문제는 심지어 앱을 강제로 꺼지는 버그도 존재했습니다. 이를 해결하는 원인 파악이 어렵고 꽤 많은 곳에서 버그들이 발생하기 때문에 아예 새로 다시 만들자는 판단을 하였습니다.")
                            .font(.caption)
                            .padding(.bottom, 5)
                        
                        Text("더 나은 사용성을 위하여 피드백을 적극적으로 수용하겠습니다.")
                            .font(.headline)
                        
                        Text("앞으로는 유저 여러분의 소중한 피드백을 하나하나씩 반영해 나가겠습니다! 긴 글을 읽어주셔서 감사합니다. 다시 한번 죄송합니다. 마이페이지의 설문을 간단하게 달아놓았습니다. 언제든지 피드백을 주시면 곧바로 반영하겠습니다.")
                            .font(.caption)
                            .padding(.bottom, 5)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Existing User Policy")
        }
    }
}
