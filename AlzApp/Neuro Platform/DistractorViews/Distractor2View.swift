//
//  Distractor2View.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/7/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct Distractor2View: View {
    @State var buttonA1: Bool = false
    @State var buttonB2: Bool = false
    @State var buttonC3: Bool = false
    @State var buttonD4: Bool = false
    @State var buttonE5: Bool = false
    @State var buttonF6: Bool = false
    @State var buttonG7: Bool = false
    @State var buttonH8: Bool = false
    @State var buttonI9: Bool = false
    @State var buttonJ10: Bool = false
    @State var buttonK11: Bool = false
    @State var buttonL12: Bool = false
    @State var buttonM13: Bool = false
    @State var buttonN14: Bool = false
    @State var buttonO15: Bool = false
    @State var buttonP16: Bool = false
    @State var buttonQ17: Bool = false
    @State var buttonR18: Bool = false
    @State var buttonS19: Bool = false
    @State var buttonT20: Bool = false
    @State var buttonU21: Bool = false
    @State var buttonV22: Bool = false
    @State var buttonW23: Bool = false
    @State var buttonX24: Bool = false
    @State var buttonY25: Bool = false
    @State var buttonZ26: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("A1").font(.system(size:30))
                    Toggle("A1", isOn: $buttonA1).labelsHidden()
                }.padding()
                HStack {
                    Text("B2").font(.system(size:30))
                    Toggle("B2", isOn: $buttonB2).labelsHidden()
                }.padding()
                HStack {
                    Text("C3").font(.system(size:30))
                    Toggle("C3", isOn: $buttonC3).labelsHidden()
                }.padding()
                HStack {
                    Text("D4").font(.system(size:30))
                    Toggle("D4", isOn: $buttonD4).labelsHidden()
                }.padding()
                HStack {
                    Text("E5").font(.system(size:30))
                    Toggle("E5", isOn: $buttonE5).labelsHidden()
                }.padding()
                HStack {
                    Text("F6").font(.system(size:30))
                    Toggle("F6", isOn: $buttonF6).labelsHidden()
                }.padding()
            }
            
            VStack {
                HStack {
                    Text("G7").font(.system(size:30))
                    Toggle("G7", isOn: $buttonG7).labelsHidden()
                }.padding()
                HStack {
                    Text("H8").font(.system(size:30))
                    Toggle("H8", isOn: $buttonH8).labelsHidden()
                }.padding()
                HStack {
                    Text("I9").font(.system(size:30))
                    Toggle("I9", isOn: $buttonI9).labelsHidden()
                }.padding()
                HStack {
                    Text("J10").font(.system(size:30))
                    Toggle("J10", isOn: $buttonJ10).labelsHidden()
                }.padding()
                HStack {
                    Text("K11").font(.system(size:30))
                    Toggle("K11", isOn: $buttonK11).labelsHidden()
                }.padding()
                HStack {
                    Text("L12").font(.system(size:30))
                    Toggle("L12", isOn: $buttonL12).labelsHidden()
                }.padding()
            }
                
            VStack {
                HStack {
                    Text("M13").font(.system(size:30))
                    Toggle("M13", isOn: $buttonM13).labelsHidden()
                }.padding()
                HStack {
                    Text("N14").font(.system(size:30))
                    Toggle("N14", isOn: $buttonN14).labelsHidden()
                }.padding()
                HStack {
                    Text("O15").font(.system(size:30))
                    Toggle("O15", isOn: $buttonO15).labelsHidden()
                }.padding()
                HStack {
                    Text("P16").font(.system(size:30))
                    Toggle("P16", isOn: $buttonP16).labelsHidden()
                }.padding()
                HStack {
                    Text("Q17").font(.system(size:30))
                    Toggle("Q17", isOn: $buttonQ17).labelsHidden()
                }.padding()
                HStack {
                    Text("R18").font(.system(size:30))
                    Toggle("R18", isOn: $buttonR18).labelsHidden()
                }.padding()
            }
            VStack {
                HStack {
                    Text("S19").font(.system(size:30))
                    Toggle("S19", isOn: $buttonS19).labelsHidden()
                }.padding()
                HStack {
                    Text("T20").font(.system(size:30))
                    Toggle("T20", isOn: $buttonT20).labelsHidden()
                }.padding()
                HStack {
                    Text("U21").font(.system(size:30))
                    Toggle("U21", isOn: $buttonU21).labelsHidden()
                }.padding()
                HStack {
                    Text("V22").font(.system(size:30))
                    Toggle("V22", isOn: $buttonV22).labelsHidden()
                }.padding()
                HStack {
                    Text("W23").font(.system(size:30))
                    Toggle("W23", isOn: $buttonW23).labelsHidden()
                }.padding()
                HStack {
                    Text("X24").font(.system(size:30))
                    Toggle("X24", isOn: $buttonX24).labelsHidden()
                }.padding()
            }
            VStack {
                HStack {
                    Text("Y25").font(.system(size:30))
                    Toggle("Y25", isOn: $buttonY25).labelsHidden()
                }.padding()
                HStack {
                    Text("Z26").font(.system(size:30))
                    Toggle("Z26", isOn: $buttonZ26).labelsHidden()
                }.padding()
            }
        }
    }
}

struct Distractor2View_Previews: PreviewProvider {
    static var previews: some View {
        Distractor2View()
    }
}
