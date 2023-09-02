//
//  RecordRepository.swift
//  moeum
//
//  Created by 송영모 on 2022/04/06.
//

import Foundation
import RealmSwift

class RecordRepository {

    let instance = try! Realm()

    func getRecordEntity(recordId: Int) {

    }

    func getAllRecordEntity() -> [RecordEntity] {
        return Array(instance.objects(RecordEntity.self))
    }

    func postRecordEntity(recordEntity: RecordEntity) {
        if let object = instance.objects(RecordEntity.self).first(where: {$0.id == recordEntity.id}) {
            if recordEntity.id != -1 {
                try? instance.write {
                    object.tag = recordEntity.tag
                    object.item = recordEntity.item
                    object.type = recordEntity.type
                    object.date = recordEntity.date
                    object.price = recordEntity.price
                    object.count = recordEntity.count
                    object.memo = recordEntity.memo
                }
                return
            }
        }

        var id = 0
        if let lastRecord = instance.objects(RecordEntity.self).last {
            id = lastRecord.id + 1
        }

        recordEntity.id = id
        try? instance.write {
            self.instance.add(recordEntity)
        }
//        print(Realm.Configuration.defaultConfiguration.fileURL!)

    }

    func updateRecordEntity(recordId: Int, recordEntity: RecordEntity) {

    }

    func deleteRecordEntity(recordId: Int) {
        if let object = instance.objects(RecordEntity.self).first(where: {$0.id == recordId}) {
            if recordId != -1 {
                try? instance.write {
                    instance.delete(object)
                }
                return
            }
        }

    }
}
