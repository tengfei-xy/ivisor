//
//  dealData.swift
//  ivisor
//
//  Created by  小小飞同学 on 2023/1/8.
//

import Foundation
// 定义programDataModel结构体,数据来自内部的programData文件
var programData: [programDataModel] = load("programData.json")


// 所以 <T: Decodable> 只接受符合Decodable协议的参数。
// 在您的函数中，它接受filename哪个是一种String类型，并确认Decodable协议。
// 假设String用一个不符合Decodable协议的类型替换，那么这个函数将不起作用并抛出错误。
func load<T: Decodable>(_ filename: String) -> T {
    
    let data: Data

    // 读取来自programData的文件,如果找不到直接退出
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    

    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


func read(){
    for item in programData {
        print("启动进程: \(item.startupProgram)")
        print("启动参数: \(item.startupArgs)")
    }
}
