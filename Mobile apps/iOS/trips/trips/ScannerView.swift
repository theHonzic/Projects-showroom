//
//  ScannerView.swift
//  trips
//
//  Created by Jan Janovec on 19.06.2021.
//

import SwiftUI
import AVFoundation

struct ScannerView: View {
    var torchState: Bool = false
    @Binding var isViewPresented: Bool
    var body: some View {
        VStack{
        Text("Scanner should be here")
        Button(action: {
            toggleTorch(on: torchState)
        }){
            Label("Torch", systemImage: "bolt.fill")
        }
        }
    }
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch cannot be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(isViewPresented: .constant(true))
    }
}
