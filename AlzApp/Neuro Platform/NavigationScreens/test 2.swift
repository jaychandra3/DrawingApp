//
//  test.swift
//  Neuro Platform
//
//  Created by Jason Shang on 3/24/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct test: View {
    @State private var selection = 0
    var body: some View {
        Picker(selection: $selection, label: Text("Zeige Deteils")) {
            Text("Select").tag(0)
            Text("Male").tag(1)
            Text("Female").tag(2)
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
