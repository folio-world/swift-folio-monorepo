//
//  PointUesCaseInterface.swift
//  MullingDomainPointInterface
//
//  Created by 송영모 on 2023/08/24.
//

import Foundation

public protocol PointUseCaseInterface {
    func fetch() -> Result<PointEntity, PointError>
    func use(point: PointEntity) -> Result<PointEntity, PointError>
    func earn(point: PointEntity) -> Result<PointEntity, PointError>
}
