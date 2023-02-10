//
//  NextTrip.swift
//  trips
//
//  Created by Jan Janovec on 21.06.2021.
//

import SwiftUI

struct NextTrip: View {
    var trip: Trip
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
        NavigationLink(destination: DetailView(trip: self.trip)){
            ZStack{
                Image(uiImage: self.image ?? UIImage())
                .resizable()
                .scaledToFit()
                
            }
            
        }
    }
}

struct NextTrip_Previews: PreviewProvider {
    static var previews: some View {
        NextTrip(trip: Trip())
    }
}
