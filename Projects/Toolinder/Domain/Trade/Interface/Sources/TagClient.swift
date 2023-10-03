//
//  TagClient.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftData

import ComposableArchitecture

public enum TagError: Error {
    case unknown
}

public struct TagClient {
    public static let tagRepository: TagRepositoryInterface = TagRepository()
    
    public var fetchTags: () -> Result<[Tag], TagError>
    public var saveTag: (TagDTO) -> Result<Tag, TagError>
    public var updateTag: (Tag, TagDTO) -> Result<Tag, TagError>
    public var deleteTag: (Tag) -> Result<Tag, TagError>
    
    public var isValidatedSaveTag: (TagDTO) -> Bool
    public var isValidatedUpdateTag: (Tag, TagDTO) -> Bool
    public var isValidatedDeleteTag: (Tag) -> Bool
        
    public init(
        fetchTags: @escaping () -> Result<[Tag], TagError>,
        saveTag: @escaping (TagDTO) -> Result<Tag, TagError>,
        updateTag: @escaping (Tag, TagDTO) -> Result<Tag, TagError>,
        deleteTag: @escaping (Tag) -> Result<Tag, TagError>,
        
        isValidatedSaveTag: @escaping (TagDTO) -> Bool,
        isValidatedUpdateTag: @escaping (Tag, TagDTO) -> Bool,
        isValidatedDeleteTag: @escaping (Tag) -> Bool
    ) {
        self.fetchTags = fetchTags
        self.saveTag = saveTag
        self.updateTag = updateTag
        self.deleteTag = deleteTag
        
        self.isValidatedSaveTag = isValidatedSaveTag
        self.isValidatedUpdateTag = isValidatedUpdateTag
        self.isValidatedDeleteTag = isValidatedDeleteTag
    }
}

extension TagClient: TestDependencyKey {
    public static var previewValue: TagClient = Self(
        fetchTags: { return .failure(.unknown) },
        saveTag: { _ in return .failure(.unknown) },
        updateTag: { _, _ in return .failure(.unknown) },
        deleteTag: { _ in return .failure(.unknown) },
        
        isValidatedSaveTag: { _ in return true },
        isValidatedUpdateTag: { _, _ in return true },
        isValidatedDeleteTag: { _ in return true }
    )
    
    public static var testValue = Self(
        fetchTags: unimplemented("\(Self.self).fetchTags"),
        saveTag: unimplemented("\(Self.self).saveTag"),
        updateTag: unimplemented("\(Self.self).updateTag"),
        deleteTag: unimplemented("\(Self.self).deleteTag"),
        
        isValidatedSaveTag: unimplemented("\(Self.self).isValidatedSaveTag"),
        isValidatedUpdateTag: unimplemented("\(Self.self).isValidatedUpdateTag"),
        isValidatedDeleteTag: unimplemented("\(Self.self).isValidatedDeleteTag")
    )
}

public extension DependencyValues {
    var tagClient: TagClient {
        get { self[TagClient.self] }
        set { self[TagClient.self] = newValue }
    }
}

extension TagClient: DependencyKey {
    public static var liveValue = TagClient(
        fetchTags: { tagRepository.fetchTags(descriptor: .init()) },
        saveTag: { tagRepository.saveTag($0) },
        updateTag: { tagRepository.updateTag($0, new: $1) },
        deleteTag: { tagRepository.deleteTag($0) },
        
        isValidatedSaveTag: { tagRepository.isValidatedSaveTag($0) },
        isValidatedUpdateTag: { tagRepository.isValidatedUpdateTag($0, new: $1) },
        isValidatedDeleteTag: { tagRepository.isValidatedDeleteTag($0) }
    )
}
