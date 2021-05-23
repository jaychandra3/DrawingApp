//
//  test.swift
//  Neuro Platform
//
//  Created by Jason Shang on 5/23/21.
//  Copyright © 2021 NDDP. All rights reserved.
//

import SwiftUI

struct test: View {
    @State var ingredients: [Ingredient] = [Ingredient(name: "Salt"),                                             Ingredient(name: "Pepper"),
                                                                                            Ingredient(name: "Chili"),
                                                                                            Ingredient(name: "Milk")]
            
            var body: some View{
                    List{
                            ForEach(0..<ingredients.count){ index in
                                    HStack {
                                            Button(action: {
                                                    ingredients[index].isSelected = ingredients[index].isSelected ? false : true
                                            }) {
                                                    HStack{
                                                            if ingredients[index].isSelected {
                                                                    Image(systemName: "checkmark.circle.fill")
                                                                            .foregroundColor(.green)
                                                                            .animation(.easeIn)
                                                            } else {
                                                                    Image(systemName: "circle")
                                                                            .foregroundColor(.primary)
                                                                            .animation(.easeOut)
                                                            }
                                                            Text(ingredients[index].name)
                                                    }
                                            }.buttonStyle(BorderlessButtonStyle())
                                    }
                            }
                    }
            }
}

struct Ingredient{
    var id = UUID()
    var name: String
    var isSelected: Bool = false
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
