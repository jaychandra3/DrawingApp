//
//  BreakView.swift
//  Neuro Platform
//
//  Created by Jason Shang on 11/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct BreakView: View {
    //@State private var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var timeRemaining: Int
//    @Binding var isCountdownDone: Bool
//    @Binding var showPopup: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(Capsule().fill(Color.black).opacity(0.75))
            Spacer()
        }.onReceive(timer) { time in
            if (timeRemaining > 0) {
                timeRemaining -= 1
            }
//            if self.timeRemaining > 0 {
//                self.timeRemaining -= 1
//                showPopup = true
//            } else if self.timeRemaining == 0 {
//                showPopup = false
//                isCountdownDone = true
//            }
        }
    }
}

//struct BreakView_Previews: PreviewProvider {
//    @State static var countdownDone = true
//    @State static var showPopup = true
//    static var previews: some View {
//        BreakView(isCountdownDone: $countdownDone, showPopup: $showPopup)
//    }
//}
