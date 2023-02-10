//
//  CircleView.swift
//  trips
//
//  Created by Jan Janovec on 19.06.2021.
//

import SwiftUI

struct CircleView: View {
    var trip: Trip
    @Environment(\.colorScheme) var colorScheme
    @State var image: UIImage = UIImage()
    
    
    init(trip: Trip) {
        self.trip = trip
        if let imgBinaryData = trip.image{
            self._image = .init(initialValue: UIImage(data: imgBinaryData) ?? UIImage())
        } else {
            self._image = .init(initialValue: UIImage())
        }
    }
    var body: some View {
        
        if trip.image != nil{
            if colorScheme == .dark{
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 4))
                    .shadow(color: .white, radius: 8)
            } else {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 8)
            }
            
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(trip: Trip())
    }
}
