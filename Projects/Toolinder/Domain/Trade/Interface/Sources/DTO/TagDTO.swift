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
    public let id: UUID = UUID()
    public var color: Color = Color.blue
    public var name: String = ""
    
    public init(
        id: UUID = .init(),
        color: Color,
        name: String
    ) {
        self.id = id
        self.color = color
        self.name = name
    }
    
    func toDomain() -> Tag {
        return Tag(
            id: id,
            color: color,
            name: name
        )
    }
}
