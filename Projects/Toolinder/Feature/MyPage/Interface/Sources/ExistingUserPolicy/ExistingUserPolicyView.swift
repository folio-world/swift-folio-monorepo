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
                        
                        Text("우선 지금부터 하는 얘기는 기존 사용자들의 데이터를 살리지 못하는 결정을 내리게된 이유를 설명드리려고 합니다.")
                            .font(.caption)
                            .padding(.bottom, 5)
                        
                        Text("보상을 제공해야 한다면")
                            .font(.headline)
                        
                        Text("우선 지금부터 하는 얘기는 기존 사용자들의 데이터를 살리지 못하는 결정을 내리게된 이유를 설명드리려고 합니다.")
                            .font(.caption)
                            .padding(.bottom, 5)
                        
                        Text("어쩌면 지금까지 앱은 사용성을 테스트하는 데모의 기간이라고 생각이 들었습니다. 지내다보니, 저의 앱들 중에 살아남은 몇 안개는 앱들의 하나였습니다. 하지만 1년 전에 제가 이 앱을 만들때의 코드들은 새로 앱을 업데이트 하기엔 부족한 실력이었고 정확히 말하면 확장을 고려한 설계를 해두지 않아서 모든 코드를 새로 갈아 엎어야 하는 상황이었습니다. 그래서 iOS 17 버전을 타겟으로 한 새로운 앱을 만들기로 결정했습니다. WWDC에서 발표한 SwiftData라는 라이브러리를 사용한 데이터 저장방식을 고려하기 시작했고, 모든 것을 처음부터 다시 만들기 시작했습니다. 하지만 저는 1명이고 앞으로도 이 앱은 소규모적으로 제가 혼자 담당해서 개발을 해나갈 생각입니다. 피드백을 주고 받고 앱을 업데이트 하는 과정은 꽤나 뿌듯해서 입니다.")
                            
                        Text("둘째, 호환이 어려운 문제")
                            .font(.headline)
                        
                        Text("과거에 사용한 데이터 저장방식은 iOS 17 버전의 앱에서는 호환이 어려움을 파악했습니다. 또한 예전의 데이터들을 살렸을때 현재의 버전과 맞지 않고, 이를 해결하는 과정 또한 복잡하고 100% 버그가 없도록 동작하기 어렵다는 판단을 하였습니다. 하지만, 이런 생각을 해봤습니다. 아, 이 앱은 업데이트 할때마다 데이터가 삭제되는구나. 불안감이 들겠다는 생각을 하였습니다. 그래서 이번 버전부터는 데이터를 모두 살리는 방식으로 업데이트를 약속하겠습니다.")
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
