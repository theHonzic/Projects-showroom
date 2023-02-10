//
//  CircleView.swift
//  The Mask
//
//  Created by Jan Janovec on 10.12.2021.
//

import SwiftUI

struct CircleView: View {
    @Environment(\.colorScheme) var colorScheme
    var image: String
    var body: some View {
        if colorScheme == .dark{
            Image("\(image)")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .shadow(color: .white, radius: 8)
        } else {
            Image("\(image)")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 8)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(image: "witch")
    }
}
