//
//  ImagePicker.swift
//  iTrips
//
//  Created by Jan Janovec on 04.06.2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    @Binding var Selectedimage: UIImage
    @Binding var isPickerPresented: Bool
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
    
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var picker: ImagePicker
    
    init(picker: ImagePicker){
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let selectedImage = info[.originalImage] as? UIImage {
            self.picker.Selectedimage = selectedImage
        }
        self.picker.isPickerPresented = false
    }
}

