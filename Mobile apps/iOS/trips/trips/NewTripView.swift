//
//  NewTripView.swift
//  trips
//
//  Created by Jan Janovec on 03.06.2021.
//

import SwiftUI

struct NewTripView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State var from: String = ""
    @State var destination: String = ""
    @State var date: Date = Date()
    @State var descr: String = ""
    @State var type: String = ""
    @State var image: UIImage = UIImage()
    @State var code: String = "Test Code"
    
    @Binding var isViewPresented: Bool
    @State var isGalleryPresented: Bool = false
    @State var isScannerPresented: Bool = false
    
    var tripTypes: [String] = ["Plane Ticket",
                               "Train Ticket",
                               "Cruise Ticket",
                               "BUS Ticket",
                               "Šalina Ticket",
                               "Something else"]
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("From")){
                    TextField("From", text: $from)
                }
                Section(header: Text("Destination")){
                    TextField("Destination", text: $destination)
                }
                Section(header: Text("Type of ticket")){
                    Picker("Ticket type", selection: $type){
                        ForEach(tripTypes, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section(header: Text("Date")){
                    HStack{
                        Label("", systemImage: "calendar")
                        DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                Section(header: Text("Description")){
                    TextField("Description", text: $descr)
                }/*
                Section(header: Text("QR Code")){
                    Button(action: {
                        self.isScannerPresented = true
                    }) {
                        Label("Scan Code", systemImage: "qrcode.viewfinder")
                    }
                    .sheet(isPresented: $isScannerPresented){
                        ScannerView(isViewPresented: $isScannerPresented)
                    }
                    
                }*/
                Section(header: Text("Image")){
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFill()
                    Button(action: {
                        self.isGalleryPresented = true
                    }){
                        Label("Choose new image", systemImage: "plus")
                    }
                    .sheet(isPresented: $isGalleryPresented){
                        ImagePicker(Selectedimage: $image, isPickerPresented: $isGalleryPresented, sourceType: .photoLibrary)
                    }
                }
            }
            .navigationTitle(Text("Add new trip"))
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action: {
                        self.isViewPresented = false
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action: {
                        if check(){
                            addItem()
                            
                            self.isViewPresented = false
                        }
                    }) {
                        Text("Okay")
                    }
                }
            }
        }
    }
    private func addItem(){
        withAnimation{
            let newTrip = Trip(context: viewContext)
            newTrip.from = self.from
            newTrip.destination = self.destination
            newTrip.descriptionn = self.descr
            newTrip.timestamp = self.date
            newTrip.image = self.image.pngData()
            newTrip.qr = self.code
            newTrip.type = self.type
            
            do{
                try viewContext.save()
                print("saved")
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func check() -> Bool {
        guard self.from != "" else {
            return false
        }
        guard self.destination != "" else {
            return false
        }
        return true
    }
}

struct NewTripView_Previews: PreviewProvider {
    static var previews: some View {
        NewTripView(isViewPresented: .constant(true))
    }
}
