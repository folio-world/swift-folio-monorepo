//
//  ExistingUserPolicyView.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 2023/09/14.
//

import SwiftUI

import ComposableArchitecture

public struct WhatIsNewView: View {
    let store: StoreOf<WhatIsNewStore>
    
    public init(store: StoreOf<WhatIsNewStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("투린더를 사용해주신 고마운 사용자분들께")
                            .font(.body)
                            .padding(.bottom, 5)
                        
                        Text(
"""
유저가 애초에 많은 서비스는 아니었지만, 꾸준히 사용해주시는 10명 정도의 사용자분들께 작성하는 편지라고 생각하시면 감사할 것 같습니다.
우선 먼저 감사하다는 말씀을 드립니다. 댓글도 별로 안달리고 평점도 낮은 앱이지만 작은 관심은 항상 큰 도움이 되었습니다. 그리고 업데이트를 결정한 이유도 모두 꾸준히 사용해주시는 분들이 계셔서라고 할 수 있습니다.

하지만 이 다음부터 하는 이야기는 모두 죄송하다는 말 뿐이어서 저도 속상한 마음으로 작성 중입니다. 기술적으로 투린더의 데이터를 살리지 못하는 버그가 존재했고, 모든 것을 살리기에는 시간적으로 많은 시간이 걸리는 것으로 파악을 하였습니다. 저의 첫번째 앱이기도 하고 그때 당시에 실력이 좋지 못해서 큰 그림을 그리며 설계를 하지 못해서 이렇게 되었습니다. 살리려고 노력을 많이 해봤지만, 아예 구조자체를 바꾸려고 하는 상황이어서 너무 많은 시간과 노력이 필요하다는 결론을 지었습니다. 그곳에 사용하는 시간을 앞으로의 새로운 앱에 집중하고자 하였습니다.

이런 상황은 다시 발생해서는 안된다고 생각합니다. 앞으로는 더욱더 나은 서비스를 만들도록 노력하겠습니다.

긴 글 읽어주셔서 감사합니다.
"""
                        )
                        .font(.caption)
                        .padding(.bottom, 5)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("What's New \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")")
        }
    }
}
