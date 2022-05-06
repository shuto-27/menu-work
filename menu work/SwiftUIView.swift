//
//  SwiftUIView.swift
//  menu work
//
//  Created by cmStudent on 2021/10/11.
//

import SwiftUI

struct SwiftUIView: View {
    @State var isMoving = false
    var body: some View {
        NavigationView{
            Text("1.プッシュアップ（腕立て伏せ）\n2.クランチ（腹筋）\n3.プランク（フロントブリッジ）\n4.ヒップリフト\n5.スクワットレッグランジ\n6.リバースエルボープッシュアップ")
                .toolbar {
                    Button(action:{isMoving.toggle()}){
                        Text("timer")
                    }
                    .sheet(isPresented:$isMoving)
                    {
                        Timers()}
                  
            }
                .navigationTitle("メニュー")
        }
        Text("１項目1分　40秒運動 20秒休憩")
       
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
