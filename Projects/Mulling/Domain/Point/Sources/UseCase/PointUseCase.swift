//
//  PointUseCase.swift
//  MullingDomainPointInterface
//
//  Created by 송영모 on 2023/08/24.
//

import Foundation

import MullingDomainPointInterface
import MullingCore
import MullingShared

public final class PointUseCase: PointUseCaseInterface {
    public static let INIT_POINT = 500
    
    enum UserDefaultsKey: String {
        case point
    }
    
    public func fetch() -> Result<PointEntity, PointError> {
        if let point = UserDefaultsManager.fetch(key: UserDefaultsKey.point.rawValue) as? Int {
            return .success(.init(current: point))
        } else {
            return .failure(.fail)
        }
    }
    
    public func use(point: Int) -> Result<PointEntity, PointError> {
        if case let .success(pointEntity) = fetch() {
            let newPoint = pointEntity.current - point
            UserDefaultsManager.save(key: UserDefaultsKey.point.rawValue, value: newPoint)
            return fetch()
        } else {
            return .failure(.fail)
        }
    }
    
    public func earn(point: Int) -> Result<PointEntity, PointError> {
        if case let .success(pointEntity) = fetch() {
            let newPoint = pointEntity.current + point
            UserDefaultsManager.save(key: UserDefaultsKey.point.rawValue, value: newPoint)
            return fetch()
        } else {
            return .failure(.fail)
        }
    }
    
    public init() {
        if case .failure = fetch() {
            UserDefaultsManager.save(key: UserDefaultsKey.point.rawValue, value: PointUseCase.INIT_POINT)
        }
    }
}
