//
//  TimerView.swift
//  Neuro Platform
//
//  Created by Nicole Yu on 8/5/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    static var defaultMinutes: Int = 0
    static var defaultSeconds: Int = 30
//    @State var hours: Int = 0
    @State private var minutes: Int = defaultMinutes
    @State private var seconds: Int = defaultSeconds
    @State private var timerIsStarted: Bool = false
    @State private var timerIsPaused: Bool = true
    @State private var timesUp: Bool = false

    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("\(String(format: "%02d", minutes)) : \(String(format: "%02d", seconds))")
                .font(.system(size: 50)).bold()
              if timerIsPaused {
                HStack {
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
                  .alert(isPresented: $timesUp) {
                    Alert(title: Text("Time's Up!"))
                  }
                }
              } else {
                HStack {
                    
                    Button(action: {
                        self.stopTimer()
                        print("RESTART")
                    }){
                        Text("Restart").font(.system(size:40)).bold()
                    }.padding(.all)
                    Button(action:{
                      print("PAUSE")
                      self.pauseTimer()
                    }){
                      //Image(systemName: "stop.fill").padding(.all)
                        Text("Pause").font(.system(size:40)).bold()
                    }
                    .padding(.all)
                }
              }
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
    
    func pauseTimer() {
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
      
    func stopTimer(){
        self.minutes = TimerView.defaultMinutes
        self.seconds = TimerView.defaultSeconds
        timerIsPaused = true
        timerIsStarted = false
        timesUp = true
        timer?.invalidate()
        timer = nil
    }
    
    /* This function doesn't stop the timer but goes back to default value and continues decrement */
    func restartTimer(){
        minutes = TimerView.defaultMinutes
        seconds = TimerView.defaultSeconds
        timerIsStarted.toggle()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
