//
//  ListItem.swift
//  trips
//
//  Created by Jan Janovec on 21.06.2021.
//

import SwiftUI

struct ListItem: View {
    var item: Trip
    @State var image: UIImage
    @State var seconds: Int = 0
    @State var minutes: Int = 0
    @State var hours: Int = 0
    @State var days: Int = 0
    @State var weeks: Int = 0
    @State var months: Int = 0
    @State var years: Int = 0
    
    init(item: Trip) {
        self.item = item
        seconds = Int(item.timestamp!.timeIntervalSince(Date()))
        minutes = Int(item.timestamp!.timeIntervalSince(Date()))/60
        hours = (Int(item.timestamp!.timeIntervalSince(Date()))/60)/60
        days = ((Int(item.timestamp!.timeIntervalSince(Date()))/60)/60)/24
        weeks = (((Int(item.timestamp!.timeIntervalSince(Date()))/60)/60)/24)/7
        months = (((Int(item.timestamp!.timeIntervalSince(Date()))/60)/60)/24)/30
        years = (((Int(item.timestamp!.timeIntervalSince(Date()))/60)/60)/24)/365
        
        if let imgBinaryData = item.image{
            self._image = .init(initialValue: UIImage(data: imgBinaryData) ?? UIImage())
        } else {
            self._image = .init(initialValue: UIImage())
        }
    }
    
    var body: some View {
        HStack{
            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
                .shadow(radius: 2)
                .frame(width: 80, height: 50)
            VStack{
                Spacer()
                Text("\(item.from ?? "No title") to \(item.destination ?? "No destination")")
                Spacer()
                HStack{
                    Spacer()
                    Label("\(item.timestamp!, formatter: itemFormatter)", systemImage: "calendar")
                    Spacer()
                    displayTimeToGo(seconds: self.$seconds, minutes: self.$minutes, hours: self.$hours, days: self.$days, weeks: self.$weeks, months: self.$months, years: self.$years)
                }
            }
        }
        
    }
}

struct displayTimeToGo: View {
    @Binding var seconds: Int
    @Binding var minutes: Int
    @Binding var hours: Int
    @Binding var days: Int
    @Binding var weeks: Int
    @Binding var months: Int
    @Binding var years: Int
    
    var body: some View{
        if seconds < 0{
            
        }else{
            if minutes <= 0 {
                Text("in \(seconds)s")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
            } else {
                if seconds > 60{
                    if minutes < 60 {
                        Text("in \(minutes)m")
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    } else{
                        if hours < 24 {
                            Text("in \(hours)h")
                                .font(.caption2)
                                .foregroundColor(Color.gray)
                        } else {
                            if days < 31 {
                                Text("in \(days) days")
                                    .font(.caption2)
                                    .foregroundColor(Color.gray)
                            }else {
                                if months < 12 {
                                    Text("in \(months) months")
                                        .font(.caption2)
                                        .foregroundColor(Color.gray)
                                } else{
                                    Text("in \(years) years")
                                        .font(.caption2)
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(item: Trip())
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
