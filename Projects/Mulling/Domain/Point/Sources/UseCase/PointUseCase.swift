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
    enum UserDefaultsKey: String {
        case point
    }
    
    public func fetch() -> Result<PointEntity, PointError> {
        if let point = UserDefaults.fetch(key: UserDefaultsKey.point.rawValue) as? Int {
            return .success(.init(current: point))
        } else {
            return .failure(.fail)
        }
    }
    
    public func use(point: PointEntity) -> Result<PointEntity, PointError> {
        if case let .success(pointEntity) = fetch() {
            let newPoint = point.current + pointEntity.current
            UserDefaults.save(key: UserDefaultsKey.point.rawValue, value: newPoint)
            return fetch()
        } else {
            return .failure(.fail)
        }
    }
    
    public func earn(point: PointEntity) -> Result<PointEntity, PointError> {
        if case let .success(pointEntity) = fetch() {
            let newPoint = point.current + pointEntity.current
            UserDefaults.save(key: UserDefaultsKey.point.rawValue, value: newPoint)
            return fetch()
        } else {
            return .failure(.fail)
        }
    }
}
