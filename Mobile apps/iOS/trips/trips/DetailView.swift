//
//  DetailView.swift
//  trips
//
//  Created by Jan Janovec on 04.06.2021.
//

import SwiftUI
import UserNotifications

struct DetailView: View {
    var trip: Trip
    
    @State var image: UIImage
    @State var isQRPresented: Bool = false
    @State var notificationOn: Bool = false
    
    var shortFrom: String{
        if let string: String = trip.from{
            let length: Int = trip.from!.count
            let mid: Int = length/2
            return "\(trip.from!.first!)\(trip.from![trip.from!.index(trip.from!.startIndex, offsetBy: mid)])\(trip.from!.last!)"
        }else{
            return ""
        }
    }
    
    var shortDestination: String{
        if let string: String = trip.destination{
            let length: Int = trip.destination!.count
            let mid: Int = length/2
            return "\(trip.destination!.first!)\(trip.destination![trip.destination!.index(trip.from!.startIndex, offsetBy: mid)])\(trip.destination!.last!)"
        }else{
            return ""
        }
    }
    
    var icon: String{
        switch trip.type {
        case "Plane Ticket":
            return "✈️"
        case "Train Ticket":
            return "🚅"
        case "Cruise Ticket":
            return "🛳"
        case "BUS Ticket":
            return "🚌"
        case "Šalina Ticket":
            return "🚋"
        default:
            return ""
        }
    }
    
    
    
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
            VStack{
                CircleView(trip: trip)
                    .padding(.horizontal)
                
                VStack(alignment: .leading){
                    
                    Text("\(trip.destination ?? "No destination")")
                        .font(.title)
                    HStack{
                        Text("From")
                            .font(.subheadline)
                        Spacer()
                        Text("\(trip.from ?? "No start")")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Date")
                            .font(.subheadline)
                        Spacer()
                        Text("\(trip.timestamp!, formatter: itemFormatter)")
                            .font(.subheadline)
                    }
                    
                    HStack{
                        Text("Transportation")
                            .font(.subheadline)
                        Spacer()
                        switch trip.type {
                        case "Plane Ticket":
                            Text("Plane")
                                .font(.subheadline)
                        case "Train Ticket":
                            Text("Train")
                                .font(.subheadline)
                        case "Cruise Ticket":
                            Text("Cruise")
                                .font(.subheadline)
                        case "BUS Ticket":
                            Text("BUS")
                                .font(.subheadline)
                        case "Šalina Ticket":
                            Text("Šalina")
                                .font(.subheadline)
                        default:
                            Text("Unknown vehicle")
                                .font(.subheadline)
                        }
                    }
                    
                    Divider()
                    Text("About the ticket")
                        .font(.subheadline)
                    if trip.descriptionn != ""{
                        Text("\(trip.descriptionn ?? "")")
                    }else{
                        Text("No description")
                    }
                }
                .padding()
                Button(action: {
                    self.isQRPresented = true
                }) {
                    Label("Show QR Code", systemImage: "qrcode")
                }
                .sheet(isPresented: $isQRPresented){
                    QRView(isViewPresented: $isQRPresented, trip: self.trip)
                }
            }
            .navigationTitle(Text("\(icon) \(shortFrom) to \(shortDestination)"))
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    if Date() < trip.timestamp!{
                        
                        Button(action: {
                            notify()
                        }){
                            if self.notificationOn == false{
                                Label("Notify", systemImage: "alarm")
                            }else{
                                Label("Notify", systemImage: "alarm.fill")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isQRPresented){
                QRView(isViewPresented: $isQRPresented, trip: self.trip)
            }
        }else {
            VStack{
                VStack(alignment: .leading){
                    
                    Text("\(trip.destination ?? "No destination")")
                        .font(.title)
                    HStack{
                        Text("From")
                            .font(.subheadline)
                        Spacer()
                        Text("\(trip.from ?? "No start")")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("Date")
                            .font(.subheadline)
                        Spacer()
                        Text("\(trip.timestamp!, formatter: itemFormatter)")
                            .font(.subheadline)
                    }
                    
                    HStack{
                        Text("Transportation")
                            .font(.subheadline)
                        Spacer()
                        switch trip.type {
                        case "Plane Ticket":
                            Text("Plane")
                                .font(.subheadline)
                        case "Train Ticket":
                            Text("Train")
                                .font(.subheadline)
                        case "Cruise Ticket":
                            Text("Cruise")
                                .font(.subheadline)
                        case "BUS Ticket":
                            Text("BUS")
                                .font(.subheadline)
                        case "Šalina Ticket":
                            Text("Šalina")
                                .font(.subheadline)
                        default:
                            Text("Unknown vehicle")
                                .font(.subheadline)
                        }
                    }
                    
                    Divider()
                    Text("About the ticket")
                        .font(.subheadline)
                    if trip.descriptionn != ""{
                        Text("\(trip.descriptionn ?? "")")
                    }else{
                        Text("No description")
                    }
                }
                .padding()
                Button(action: {
                    self.isQRPresented = true
                }) {
                    Label("Show QR Code", systemImage: "qrcode")
                }
                .sheet(isPresented: $isQRPresented){
                    QRView(isViewPresented: $isQRPresented, trip: self.trip)
                }
            }
            
            .navigationTitle(Text("\(icon) \(shortFrom) to \(shortDestination)"))
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    if Date() < trip.timestamp!{
                        
                        Button(action: {
                            notify()
                        }){
                            if self.notificationOn == false{
                                Label("Notify", systemImage: "alarm")
                            }else{
                                Label("Notify", systemImage: "alarm.fill")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isQRPresented){
                QRView(isViewPresented: $isQRPresented, trip: self.trip)
            }
        }
        
        
        
        
        
    }
    
    func notify(){
        if !notificationOn{
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
                succes, error in
                if (succes){
                    let content = UNMutableNotificationContent()
                    
                    switch trip.type {
                    case "Plane Ticket":
                        content.title = "Your plane is leaving in 5 minutes"
                    case "Train Ticket":
                        content.title = "Your train is leaving in 5 minutes"
                    case "Cruise Ticket":
                        content.title = "Your cruise is leaving in 5 minutes"
                    case "BUS Ticket":
                        content.title = "Your BUS is leaving in 5 minutes"
                    case "Šalina Ticket":
                        content.title = "Your šalina is leaving in 5 minutes"
                    default:
                        content.title = "You are leaving in 5 minutes"
                    }
                    
                    content.subtitle = "\(icon) \(trip.from ?? "") to \(trip.destination ?? "")"
                    content.sound = UNNotificationSound.default
                    
                    
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: trip.timestamp!.addingTimeInterval(-5*60)), repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                }
            }
            self.notificationOn = true
            print("Notification on")
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [UUID().uuidString])
            self.notificationOn = false
            print("Notification off")
            
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(trip: Trip())
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
