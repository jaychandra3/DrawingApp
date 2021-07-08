//
//  AboutAppView.swift
//  Neuro Platform
//
//  Created by user175482 on 12/28/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import SwiftUI

// Barebones AboutAppView : TODO
struct AboutAppView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Image("gami_logo").resizable().aspectRatio(contentMode: .fit).frame(width:UIScreen.screenWidth/2).padding()
                Text("About the App")
                    .textStyle(TitleTextStyle()).padding()
                Text("[Analysis Platform] is a mobile neurodegenerative disease screening platform developed by a team of students and faculty from the Global Alliance for Medical Innovation (GAMI).\n\nHere at GAMI, we are deeply concerned by the severe shortage of healthcare resources the world is facing. Those who are most in need of help are often ignored by the major players in the medical space. GAMI aims to leverage the technical expertise and passion of students around the world as well as the invaluable experience of healthcare professionals to develop impactful technologies, policies, and programs and make healthcare accessible to all.").textStyle(BodyTextStyle()).padding()
                Text("Our team represents a diverse group of undergraduate and graduate students from different academic backgrounds (computer science, statistics, engineering, neuroscience, and biology) from multiple universities in the US and abroad (Duke University, Harvard University, Singapore University of Technology & Design). The team advisors from Harvard School of Engineering and Applied Sciences and from Harvard Medical School Teaching Hospitals bring expertise in the mathematical analysis of physical phenomena such as handwriting, gait, and eye movement and clinical knowledge in neurodegenerative disease treatment. Special thanks to Dr. Mahadevan, Dr. Press, Dr. Lim, and Dr. Shaughnessy for their extensive feedback and support on the project!")
                    .textStyle(BodyTextStyle()).padding()
                
                HStack {
                    Image("harvard_logo").resizable().scaledToFit().padding()
                    Image("duke_logo").resizable().scaledToFit().padding()
                    Image("sutd_logo").resizable().scaledToFit().padding()
                    Image("bidmc_logo").resizable().scaledToFit().padding()
                }.padding()
            }.padding()
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
