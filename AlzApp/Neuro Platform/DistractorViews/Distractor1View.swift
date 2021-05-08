//
//  Distractor1View.swift
//  Neuro Platform
//
//  Created by Nathan on 5/7/21.
//  Copyright © 2021 NDDP. All rights reserved.
//
import SwiftUI
struct Distractor1View: View {
    @State var button100: Bool = false
    @State var button93: Bool = false
    @State var button86: Bool = false
    @State var button79: Bool = false
    @State var button72: Bool = false
    @State var button65: Bool = false
    @State var button58: Bool = false
    @State var button51: Bool = false
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                HStack {
                    Text("100").font(.system(size:30))
                    Toggle("100", isOn: $button100).labelsHidden()
                }.padding()
                HStack {
                    Text("93").font(.system(size:30))
                    Toggle("93", isOn: $button93).labelsHidden()
                }.padding()
                HStack {
                    Text("86").font(.system(size:30))
                    Toggle("86", isOn: $button86).labelsHidden()
                }.padding()
                HStack {
                    Text("79").font(.system(size:30))
                    Toggle("79", isOn: $button79).labelsHidden()
                }.padding()
            }.padding()
            VStack(alignment: .trailing) {
                HStack {
                    Text("72").font(.system(size:30))
                    Toggle("72", isOn: $button72).labelsHidden()
                }.padding()
                HStack {
                    Text("65").font(.system(size:30))
                    Toggle("65", isOn: $button65).labelsHidden()
                }.padding()
                HStack {
                    Text("58").font(.system(size:30))
                    Toggle("58", isOn: $button58).labelsHidden()
                }.padding()
                HStack {
                    Text("51").font(.system(size:30))
                    Toggle("51", isOn: $button51).labelsHidden()
                }.padding()
            }.padding()
        }
    }
}

struct Distractor1View_Previews: PreviewProvider {
    static var previews: some View {
        Distractor1View()
    }
}
