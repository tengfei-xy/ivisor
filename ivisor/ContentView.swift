//
//  ContentView.swift
//  ivisor
//
//  Created by  小小飞同学 on 2023/1/8.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var p = Process()
    @State private var startupProgram:String = "/users/melta/test/gost-darwin-amd64-2.11.4"
    @State private var argument:String = "-L=:8080 -F=socks5://127.0.0.1:57204"
    @State private var state:String = "当前状态："
    @State private var pid:String = "PID:"
    
    var body: some View {
        VStack{
            HStack{
                Text("启动程序")
                TextField("路径",text: $startupProgram)
            }
            
            HStack{
                Text("参数")
                TextField("路径",text: $argument)
            }
            HStack{
                Text(state)
                Text(pid)
            }
            HStack{
                Button("点击运行"){
                    exec(233)
                }
                Button("查看状态",action:checkState)
                Button("结束程序",action:stop)
                Button("标准输出",action:stdout)
            }
        }.padding()
        
        
        
    }
    func exec(_ a : Int){
        p = Process()
        p.executableURL = URL(fileURLWithPath: startupProgram)
        p.currentDirectoryURL = URL(fileURLWithPath: "/users/melta/test")
        p.arguments = argument.components(separatedBy: " ")
        
        
        p.launch()
        checkState()
    }
    
    func checkState() -> Void {
        if p.isRunning {
            state = "当前状态：已经启动"
            pid = "PID:\(p.processIdentifier)"
        }else{
            state = "当前状态：未启动"
            pid = "PID:"
        }
    }
    func stop(){
        p.interrupt()
    }
    func stdout(){
//        p.standardOutput
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
