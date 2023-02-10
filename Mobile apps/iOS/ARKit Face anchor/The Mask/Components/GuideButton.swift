//
//  GuideButton.swift
//  The Mask
//
//  Created by Jan Janovec on 16.12.2021.
//

import Foundation
import SwiftUI

struct GuideButton: View {
    @Binding var isItPresented: Bool
    var integer: Int
    var body: some View {
        Button(action: {self.isItPresented=true}){
            Image("infoIcon")
                .resizable()
                .frame(width: 60.0, height: 60.0)
                .scaledToFit()
                .clipShape(Circle())
        }
        .sheet(isPresented: self.$isItPresented){
            HintSheet(isViewPresented: self.$isItPresented, integer: self.integer)
        }
    }
}
