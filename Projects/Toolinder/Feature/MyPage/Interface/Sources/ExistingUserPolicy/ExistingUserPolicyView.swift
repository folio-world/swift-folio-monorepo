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
                        
                        Text("우선 지금부터 하는 얘기는 기존 사용자들의 데이터를 살리지 못하는 결정을 내리게된 이유를 설명드리려고 합니다. 앱을 업데이트 했는데, 데이터가 모두 사라지는 현상이 있었습니다. 그래서 이를 해결하고자 하였지만, 아주 오래전 작성된 코드(물론 제가 작성했었음)는 문제가 있었고 현재 모두 새로운 것으로 고쳤습니다. 그래서 현재 버전부터는 모든 문제가 해결되었지만, 기존에 발생하고 있던 문제는 심지어 앱을 강제로 꺼지는 버그도 존재했습니다. 이를 해결하는 원인 파악이 어렵고 꽤 많은 곳에서 버그들이 발생하기 때문에 아예 새로 다시 만들자는 판단을 하였습니다. ")
                            .font(.caption)
                            .padding(.bottom, 5)
                        
                        Text("여러분께 보상을 제공하겠습니다.")
                            .font(.headline)
                        
                        Text("기존의 앱을 사용하던 사용자분들에게 어떻게 하면 다른 방식으로 고민을 하기 시작했고, 어쩌면 서비스 측면에서 이또한 하나의 방법이라고 생각했습니다. 모른척 넘어가기보다는 잘못한 것을 사과드리고 보상을 제공하는 방식을 선택하였습니다. 그래서 아래의 ID 값을 저에게 보내주시면, 다음버전부터 광고가 제거된 버전과 앞으로의 유료 결제 도입시에 모든 비용을 0원으로 해드리는 정책을 가져가도록 하겠습니다. 10월 말까지 이 페이지가 열려있으며, 저는 해당 ID를 앱스토어커넥트 측에 비교하여 실제 기존 유저였는지 체크를 하고 그 후에 보상을 진행하겠습니다.")
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
