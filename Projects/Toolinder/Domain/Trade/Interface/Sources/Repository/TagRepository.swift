//
//  TagRepository.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftData

public protocol TagRepositoryInterface {
    func fetchTags(descriptor: FetchDescriptor<Tag>) -> Result<[Tag], TagError>
    func saveTag(_ tag: TagDTO) -> Result<Tag, TagError>
    func updateTag(_ tag: Tag, new newTag: TagDTO) -> Result<Tag, TagError>
    func deleteTag(_ tag: Tag) -> Result<Tag, TagError>
    
    func isValidatedSaveTag(_ tag: TagDTO) -> Bool
    func isValidatedUpdateTag(_ tag: Tag, new newTag: TagDTO) -> Bool
    func isValidatedDeleteTag(_ tag: Tag) -> Bool
}

public class TagRepository: TagRepositoryInterface {
    private var context: ModelContext? = StorageContainer.shared.context
    
    public init() { }
    
    public func fetchTags(descriptor: FetchDescriptor<Tag>) -> Result<[Tag], TagError> {
        if let tags = try? context?.fetch(descriptor) {
            return .success(tags)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func saveTag(_ tag: TagDTO) -> Result<Tag, TagError> {
        if isValidatedSaveTag(tag) {
            let tag = tag.toDomain()
            context?.insert(tag)
            return .success(tag)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func updateTag(_ tag: Tag, new newTag: TagDTO) -> Result<Tag, TagError> {
        if isValidatedUpdateTrade(tag, new: newTag) {
            let tag = tag
            tag.color = newTag.color
            tag.name = newTag.name
            return .success(tag)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func deleteTag(_ tag: Tag) -> Result<Tag, TagError> {
        if isValidatedDeleteTag(tag) {
            context?.delete(tag)
            return .success(tag)
        } else {
            return .failure(.unknown)
        }
    }
    
    public func isValidatedSaveTag(_ tag: TagDTO) -> Bool {
        return true
    }
    
    public func isValidatedUpdateTag(_ tag: Tag, new newTag: TagDTO) -> Bool {
        return true
    }
    
    public func isValidatedDeleteTag(_ tag: Tag) -> Bool {
        return true
    }
}
