//
//  ARPumpkin.swift
//  The Mask
//
//  Created by Jan Janovec on 10.12.2021.
//

import SwiftUI
import RealityKit
import ARKit

var arPumpkinView: ARView!
var pumpkin: Experience.Pumpkin!


struct ARPumpkin: View {
    @Binding var isViewPresented: Bool
    @State var isHintPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainerPumpkin().edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    GuideButton(isItPresented: $isHintPresented, integer: 1)
                }
                Spacer()
                HStack{
                    Spacer()
                    HStack(spacing: 17.0){
                        Button(action: {takeAPhoto()}){
                            Image("cameraIcon")
                                .resizable()
                                .frame(width: 60.0, height: 60.0)
                                .scaledToFit()
                                .clipShape(Circle())
                        }
                        Button(action:{ self.postPhotoToInstagram()}){
                            Image("instagramIcon")
                                .resizable()
                                .frame(width: 60.0, height: 60.0)
                                .scaledToFit()
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
            }
        }
        
        
    }
    func takeAPhoto(){
        
        arPumpkinView.snapshot(saveToHDR: false){(image) in
            let compressedImage = UIImage(data: (image?.pngData())!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            
        }
    }
    func postPhotoToInstagram() {
        arPumpkinView.snapshot(saveToHDR: false){(image) in
            let compressedImage = UIImage(data: (image?.pngData())!)
            InstagramSharingUtils.shareToInstagramStories(compressedImage!)
            
        }
        
    }
    
}



struct ARViewContainerPumpkin: UIViewRepresentable {
    
    
    class ARDelegateHandler: NSObject, ARSessionDelegate{
        var arViewContainer : ARViewContainerPumpkin
        var isLeftEyeCloseDone: Bool = true
        var isRightEyeCloseDone: Bool = true

        init(_ control: ARViewContainerPumpkin){
            self.arViewContainer=control
            super.init()
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard pumpkin != nil else { return }
            
            var faceAnchor: ARFaceAnchor?
            for anchor in anchors {
                if let a = anchor as? ARFaceAnchor {
                    faceAnchor = a
                }
            }
            
            let blendShapes = faceAnchor?.blendShapes
            let eyeBlinkLeft = blendShapes?[.eyeBlinkLeft]?.floatValue
            let eyeBlinkRight = blendShapes?[.eyeBlinkRight]?.floatValue
            let browInnerUp = blendShapes?[.browInnerUp]?.floatValue
            let browLeft = blendShapes?[.browDownLeft]?.floatValue
            let browRight = blendShapes?[.browDownRight]?.floatValue
            let jawOpen = blendShapes?[.jawOpen]?.floatValue
            
            
            
         
            
            if (self.isLeftEyeCloseDone == true && eyeBlinkLeft! >= Constants.Animations.eyeBlinkLimit) {
                print("Pumpkin left eye closed")
                self.isLeftEyeCloseDone = false
                pumpkin.notifications.closeLeftEye.post()
                pumpkin.actions.closeLeftEyeDone.onAction = {_ in self.isLeftEyeCloseDone = true}
            }
            
            if (self.isRightEyeCloseDone == true && eyeBlinkRight! >= Constants.Animations.eyeBlinkLimit) {
                print("Pumpkin right eye closed")
                self.isRightEyeCloseDone = false
                pumpkin.notifications.closeRightEye.post()
                pumpkin.actions.closeRightEyeDone.onAction = {_ in self.isRightEyeCloseDone = true}
            }
            
        }
        
    }
    
    func makeCoordinator() -> ARDelegateHandler {
        ARDelegateHandler(self)
    }
    
    func makeUIView(context: Context) -> ARView {
        arPumpkinView = ARView(frame: .zero)
        arPumpkinView.session.delegate = context.coordinator
        return arPumpkinView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        pumpkin=nil
        let arConfiguration = ARFaceTrackingConfiguration()
        uiView.session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
        let arAnchor = try! Experience.loadPumpkin()
        uiView.scene.anchors.append(arAnchor)
        pumpkin=arAnchor
    }
    
}

#if DEBUG
struct ARPumpkin_Previews : PreviewProvider {
    static var previews: some View {
        ARPumpkin(isViewPresented: .constant(true))
    }
}
#endif
