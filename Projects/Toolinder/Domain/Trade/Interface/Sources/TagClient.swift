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
        
    public init(
        fetchTags: @escaping () -> Result<[Tag], TagError>,
        saveTag: @escaping (TagDTO) -> Result<Tag, TagError>,
        updateTag: @escaping (Tag, TagDTO) -> Result<Tag, TagError>,
        deleteTag: @escaping (Tag) -> Result<Tag, TagError>
    ) {
        self.fetchTags = fetchTags
        self.saveTag = saveTag
        self.updateTag = updateTag
        self.deleteTag = deleteTag
    }
}

extension TagClient: TestDependencyKey {
    public static var previewValue: TagClient = Self(
        fetchTags: { return .failure(.unknown) },
        saveTag: { _ in return .failure(.unknown) },
        updateTag: { _, _ in return .failure(.unknown) },
        deleteTag: { _ in return .failure(.unknown) }
    )
    
    public static var testValue = Self(
        fetchTags: unimplemented("\(Self.self).fetchTags"),
        saveTag: unimplemented("\(Self.self).saveTag"),
        updateTag: unimplemented("\(Self.self).updateTag"),
        deleteTag: unimplemented("\(Self.self).deleteTag")
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
        deleteTag: { tagRepository.deleteTag($0) }
    )
}
