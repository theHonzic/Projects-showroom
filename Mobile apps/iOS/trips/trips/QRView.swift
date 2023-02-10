//
//  QRView.swift
//  iTrips
//
//  Created by Jan Janovec on 05.06.2021.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    
    @Binding var isViewPresented: Bool
    
    let contextos = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var trip: Trip? = nil
    var body: some View {
        NavigationView{
            VStack{
                
                if trip?.qr != nil{
                    Text("\(trip?.from ?? "No from value") to \(trip?.destination ?? "No destination")")
                } else {
                    Text("Something went wrong")
                }
                
                if let code = trip?.qr{
                    Image(uiImage: getQRCode(text: code))
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                        .border(Color.black, width: 2)
                }
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action: {
                        self.isViewPresented = false
                        
                    }) {
                        Text("Cancel")
                    }
                }
                
            }
        }
        
    }
    func getQRCode(text: String) -> UIImage {
        
        let data = Data(text.utf8) //filtr by to nepřečetl, nutná konverze
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrImage = filter.outputImage {
            if let qrCGImage = contextos.createCGImage(qrImage, from: qrImage.extent){
                return UIImage(cgImage: qrCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}



struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView(isViewPresented: .constant(true), trip: Trip())
    }
}
