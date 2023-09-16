//
//  PhotoClient.swift
//  ToolinderDomainTrade
//
//  Created by 송영모 on 2023/09/16.
//

import Foundation
import SwiftUI
import SwiftData
import PhotosUI

import ComposableArchitecture

public enum PhotoError: Error {
    case unknown
}

public struct PhotoClient {
    public static let photoRepository: PhotoRepositoryInterface = PhotoRepository.shared
    
    public var toDataList: @Sendable ([PhotosPickerItem]) async -> Result<[Data], PhotoError>
    
    public init(
        toDataList: @Sendable @escaping ([PhotosPickerItem]) async -> Result<[Data], PhotoError>
    ) {
        self.toDataList = toDataList
    }
}

extension PhotoClient: TestDependencyKey {
    public static var previewValue: PhotoClient = Self(
        toDataList: { _ in return .failure(.unknown) }
    )
    
    public static var testValue = Self(
        toDataList: unimplemented("\(Self.self).toDataList")
    )
}

public extension DependencyValues {
    var photoClient: PhotoClient {
        get { self[PhotoClient.self] }
        set { self[PhotoClient.self] = newValue }
    }
}

extension PhotoClient: DependencyKey {
    public static var liveValue = PhotoClient(
        toDataList: { photosPickerItems in
            var result: [Data] = []
            for item in photosPickerItems {
                let data = await photoRepository.toData(from: item)
                result.append(data)
            }
            
            return .success(result)
        }
    )
}
