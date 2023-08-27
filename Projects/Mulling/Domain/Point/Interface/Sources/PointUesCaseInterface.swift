//
//  PointUesCaseInterface.swift
//  MullingDomainPointInterface
//
//  Created by 송영모 on 2023/08/24.
//

import Foundation

public protocol PointUseCaseInterface {
    func fetch() -> Result<PointEntity, PointError>
    func use(point: Int) -> Result<PointEntity, PointError>
    func earn(point: Int) -> Result<PointEntity, PointError>
}
