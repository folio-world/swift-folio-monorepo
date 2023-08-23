//
//  ChatCompletionModelType.swift
//  MullingDomainGPT
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

public enum ChatCompletionModelType: String, Codable {
    case gpt_4 = "gpt-4"
    case gpt_4_0613 = "gpt-4-0613"
    case gpt_4_32k = "gpt-4-32k"
    case gpt_4_32k_0613 = "gpt-4-32k-0613"
    case gpt_3_5_turbo = "gpt-3.5-turbo"
    case gpt_3_5_turbo_0613 = "gpt-3.5-turbo-0613"
    case gpt_3_5_turbo_16k = "gpt-3.5-turbo-16k"
    case gpt_3_5_turbo_16k_0613 = "gpt-3.5-turbo-16k-0613"
}
