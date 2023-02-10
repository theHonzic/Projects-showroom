//
//  ListView.swift
//  trips
//
//  Created by Jan Janovec on 03.06.2021.
//

import SwiftUI

struct ListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Trip.timestamp, ascending: true), NSSortDescriptor(keyPath: \Trip.created, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Trip>
    
    enum tripState{
        case upcoming, past, none
    }
    
    let state: tripState
    
    @State var showNewTrip: Bool = false
    
    
    var title: String{
        switch state{
        case .upcoming:
            return "Upcoming"
        case .past:
            return "Past"
        case .none:
            return ""
        }
    }
    
    var trips: [Trip]{
        switch state{
        case .upcoming:
            var tripss: [Trip] = []
            for item in items {
                if item.timestamp!>Date() {
                    tripss.append(item)
                }
            }
            return tripss
        case .past:
            var tripss: [Trip] = []
            for item in items {
                if item.timestamp!<Date() {
                    tripss.append(item)
                }
            }
            return tripss
        case .none:
            var tripss: [Trip] = []
            return []
        }
    }
    
    var body: some View {
        NavigationView{
            
            List{
                
                if let tripss: [Trip] = trips{
                    
                    ForEach(trips){
                        tripos in
                        
                        NavigationLink(destination: DetailView(trip: tripos)){
                            
                            ListItem(item: tripos)
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                }else{
                    Text("No data")
                }
            }
            .navigationTitle(Text("\(self.title)"))
            .sheet(isPresented: $showNewTrip, content: {
                NewTripView(isViewPresented: $showNewTrip)
            })
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action: {
                        self.showNewTrip = true
                    }) {
                        Label("Add", systemImage: "plus")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading){
                    EditButton()
                }
            }
        }
        
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(state: .none)
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

