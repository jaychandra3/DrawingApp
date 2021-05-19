//
//  Override.swift
//  Neuro Platform
//
//  Created by Nathan on 5/15/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct Override: View {
    @State private var showPopUp = true
    @State private var passedTest = false
    
    var body: some View {
        ZStack {
            if $showPopUp.wrappedValue {
                ZStack {
                    Color.white
                    VStack {
                        if(passedTest == true) {
                            Text("Our algorithm shows that the patient's drawing passed. We recommend they go up one level.")
                            Spacer()
                            Button(action: {
                                self.showPopUp = false
                            }, label: {
                                Text("Go up a level (recommended)")
                            })
                            Spacer()
                            Button(action: {
                                self.showPopUp = false
                            }, label: {
                                Text("Go down a level")
                            })
                        }else{
                            Text("Our algorithm shows that the patient's drawing did not pass. We recommend they go down one level.")
                            Spacer()
                            Button(action: {
                                self.showPopUp = false
                            }, label: {
                                Text("Go up a level")
                            })
                            Spacer()
                            Button(action: {
                                self.showPopUp = false
                            }, label: {
                                Text("Go down a level (recommended)")
                            })
                        }
                    }.padding()
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 20)
            }
        }.padding()
    }
}

struct Override_Previews: PreviewProvider {
    static var previews: some View {
        Override()
    }
}
