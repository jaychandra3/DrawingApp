//
//  TimerView.swift
//  Neuro Platform
//
//  Created by Nicole Yu on 8/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    
//    @State var hours: Int = 0
    @State var minutes: Int = 2
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true

    @State var timer: Timer? = nil
    
    var body: some View {
        VStack {
              Text("\(minutes):\(seconds)")
              if timerIsPaused {
                HStack {
                  Button(action:{
                    print("RESTART")
                  }){
                    Image(systemName: "backward.end.alt")
                      .padding(.all)
                  }
                  .padding(.all)
                  Button(action:{
                    self.startTimer()
                    print("START")
                  }){
                    Image(systemName: "play.fill")
                      .padding(.all)
                  }
                  .padding(.all)
                }
              } else {
                Button(action:{
                  print("STOP")
                  self.stopTimer()
                }){
                  Image(systemName: "stop.fill")
                    .padding(.all)
                }
                .padding(.all)
              }
        }
    }
    
    func startTimer(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
          if self.seconds == 0 {
            if self.minutes == 0 {
                self.seconds = 0
                self.minutes = 0
                self.stopTimer()
            } else {
              self.minutes = self.minutes - 1
              self.seconds = 59
            }
          } else {
            self.seconds = self.seconds - 1
          }
        }
    }
      
    func stopTimer(){
        self.minutes = 2
        self.seconds = 0
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer(){
//      hours = 0
      minutes = 2
      seconds = 0
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
