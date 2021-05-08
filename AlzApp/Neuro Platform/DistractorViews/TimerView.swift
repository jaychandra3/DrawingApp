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
    @State var minutes: Int = 0
    @State var seconds: Int = 30
    @State var timerIsStarted: Bool = false
    @State var timerIsPaused: Bool = true

    @State var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("\(minutes):\(seconds)").font(.system(size: 50)).bold()
              if timerIsPaused {
                HStack {
                    Button(action: {
                        self.restartTimer()
                        print("RESTART")
                    }){
                        Text("Restart").font(.system(size:40)).bold()
                    }.padding(.all)
                  Button(action:{
                    self.startTimer()
                    print("START")
                  }){
                    if timerIsStarted {
                        Text("Continue").font(.system(size:40)).bold()
                    } else {
                        Text("Start").font(.system(size:40)).bold()
                    }
                  }.padding(.all)
                }
              } else {
                Button(action:{
                  print("PAUSE")
                  self.stopTimer()
                }){
                  //Image(systemName: "stop.fill").padding(.all)
                    Text("Pause").font(.system(size:40)).bold()
                }
                .padding(.all)
              }
            /*
            if (minutes == 0 && seconds == 0) {
                Button(action: {
                    
                })
            }*/
        }
    }
    
    func startTimer(){
        timerIsPaused = false
        timerIsStarted = true
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
        //self.minutes = self.minutes
        //self.seconds = self.seconds
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer(){
        minutes = 0
        seconds = 30
        timerIsStarted.toggle()
//      hours = 0
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
