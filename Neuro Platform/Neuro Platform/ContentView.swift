//
//  ContentView.swift
//  Neuro Platform
//
//  Created by Jay Chandra on 6/13/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
