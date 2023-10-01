//
//  TagDTO.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftData
import SwiftUI

public class TagDTO {
    public var id: UUID = UUID()
    public var hex: String = ""
    public var name: String = ""
    
    public init(
        id: UUID = .init(),
        hex: String,
        name: String
    ) {
        self.id = id
        self.hex = hex
        self.name = name
    }
    
    func toDomain() -> Tag {
        return Tag(
            id: id,
            hex: hex,
            name: name
        )
    }
}
