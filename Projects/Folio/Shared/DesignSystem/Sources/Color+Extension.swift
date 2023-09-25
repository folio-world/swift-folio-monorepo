//
//  Color+Extension.swift
//  FolioSharedDesignSystem
//
//  Created by 송영모 on 2023/09/18.
//

import SwiftUI

public extension Color {
    static func blackOrWhite(_ isSelected: Bool = false) -> Self {
        return isSelected ? Color(uiColor: .label) : Color(uiColor: .systemBackground)
    }
}
