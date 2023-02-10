//
//  ARViewController.swift
//  The Mask
//
//  Created by Jan Janovec on 12.10.2021.
//

import SwiftUI
import RealityKit
import ARKit

var arView: ARView!


struct ARViewController: View {
    @Binding var isViewPresented: Bool
    @State var whoAmI: String
    @State var isHintPresented: Bool = false
    @State var integer: Int
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer(whoAmI: $whoAmI).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    GuideButton(isItPresented: $isHintPresented, integer: self.integer)
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
        
        arView.snapshot(saveToHDR: false){(image) in
            let compressedImage = UIImage(data: (image?.pngData())!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            
        }
    }
    
    func postPhotoToInstagram() {
        arView.snapshot(saveToHDR: false){(image) in
            let compressedImage = UIImage(data: (image?.pngData())!)
            InstagramSharingUtils.shareToInstagramStories(compressedImage!)
            
        }
        
    }
}



struct ARViewContainer: UIViewRepresentable {
    
    @Binding var whoAmI: String
    
    class ARDelegateHandler: NSObject, ARSessionDelegate{
        var arViewContainer : ARViewContainer
        init(_ control: ARViewContainer){
            self.arViewContainer=control
            super.init()
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            
            var faceAnchor: ARFaceAnchor?
            for anchor in anchors {
                if let a = anchor as? ARFaceAnchor {
                    faceAnchor = a
                }
            }
        }
        
    }
    
    func makeCoordinator() -> ARDelegateHandler {
        ARDelegateHandler(self)
    }
    
    func makeUIView(context: Context) -> ARView {
        
        arView = ARView(frame: .zero)
        arView.session.delegate = context.coordinator
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let arConfiguration = ARFaceTrackingConfiguration()
        uiView.session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
        switch whoAmI {
        case "Witch":
            let arAnchor = try! Experience.loadWitch()
            uiView.scene.anchors.append(arAnchor)
            break
        case "Clown":
            let arAnchor = try! Experience.loadClown()
            uiView.scene.anchors.append(arAnchor)
            break
        case "Pumpkin":
            let arAnchor = try! Experience.loadPumpkin()
            uiView.scene.anchors.append(arAnchor)
            break
        case "Skull":
            let arAnchor = try! Experience.loadSkeleton()
            uiView.scene.anchors.append(arAnchor)
            break
        case "Iron Man":
            let arAnchor = try! Experience.loadIronMan()
            uiView.scene.anchors.append(arAnchor)
            break
        case "Robot":
            let arAnchor = try! Experience.loadRobot()
            uiView.scene.anchors.append(arAnchor)
            break
        default:
            let arAnchor = try! Experience.loadUnknownObject()
            uiView.scene.anchors.append(arAnchor)
            break
        }
        
    }
    
}

#if DEBUG
struct ARViewController_Previews : PreviewProvider {
    static var previews: some View {
        ARViewController(isViewPresented: .constant(true), whoAmI: "", integer: 5)
    }
}
#endif
