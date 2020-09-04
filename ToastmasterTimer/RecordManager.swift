//
//  RecordItem.swift
//  ToastmasterTimer
//
//  Created by April Yang on 2020/9/4.
//  Copyright © 2020 April Yang. All rights reserved.
//

import Foundation

private let recordListKey = "recordList"
class RecordManager {
    static let instance = RecordManager()
    private var recordList: [RecordItem] = []
    
    var numberOfItem: Int {
        recordList.count
    }
    
    init() {
        let listDic = (UserDefaults.standard.value(forKey: recordListKey) as? [[String: Any]]) ?? []
        let recordFromLocal = listDic.map{RecordItem.fromDic(dic: $0)}
        self.recordList = recordFromLocal
    }
    
    func itemAtIndex(_ index: Int)->RecordItem? {
        if index < numberOfItem && index >= 0 {
            return recordList[index]
        }
        return nil
    }
    
    func addItem(item: RecordItem) {
        self.recordList.append(item)
        saveToLocal()
    }
    
    func removeItem(index: Int) {
        if index < self.recordList.count {
            self.recordList.remove(at: index)
            saveToLocal()
        }
    }
    
    func removeAll() {
        self.recordList.removeAll()
        self.saveToLocal()
    }
    
    func replaceItem(index: Int, with item: RecordItem) {
        recordList.replaceSubrange(index...index, with: [item])
        saveToLocal()
    }
    
    func sharableText() -> String {
        "name\ttotal\tused\n" +
         self.recordList.map{$0.flatText()}.joined(separator: "\n")
    }
    
    func saveToLocal() {
        UserDefaults.standard.set(recordList.map{$0.dictionary()}, forKey: recordListKey)
        UserDefaults.standard.synchronize()
    }
}

struct RecordItem: Codable {
    var name: String = ""
    let totalTime: Int
    let usedTime: Int
    
    func flatText() -> String {
        "\(name)\t\(formatTimeString(second: totalTime))\t\(formatTimeString(second: usedTime))"
    }
    
    func dictionary() -> [String: Any] {
        let dic: [String : Any] = ["name": name, "totalTime": totalTime, "usedTime": usedTime]
        return dic
    }
    
    static func fromDic(dic: [String: Any]) -> RecordItem {
        RecordItem(name: dic["name"] as! String, totalTime: dic["totalTime"] as! Int, usedTime: dic["usedTime"] as! Int)
    }
}
