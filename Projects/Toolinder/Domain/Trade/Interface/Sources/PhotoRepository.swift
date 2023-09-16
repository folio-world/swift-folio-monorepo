//
//  PhotoRepository.swift
//  ToolinderDomainTrade
//
//  Created by 송영모 on 2023/09/16.
//

import SwiftUI
import PhotosUI

public protocol PhotoRepositoryInterface {
    func toData(from photosPickerItem: PhotosPickerItem) async -> Data
}

public class PhotoRepository: PhotoRepositoryInterface {
    public static var shared: PhotoRepositoryInterface = PhotoRepository()
    
    public func toData(from photosPickerItem: PhotosPickerItem) async -> Data {
        return await withCheckedContinuation { continuation in
            photosPickerItem.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let imageData):
                    if let imageData = imageData {
                        continuation.resume(returning: imageData)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
