//
//  ImagePicker.swift
//  SwiftUIImagePicker
//
//  Created by Toomas Vahter on 21.11.2020.
//

import SwiftUI
import UIKit

public struct ImagePicker: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIImagePickerController
    public typealias SourceType = UIImagePickerController.SourceType

    public let sourceType: SourceType
    public let completionHandler: (UIImage?) -> Void

    public init(sourceType: ImagePicker.SourceType, completionHandler: @escaping (UIImage?) -> Void) {
        self.sourceType = sourceType
        self.completionHandler = completionHandler
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        viewController.sourceType = sourceType
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    public final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        public let completionHandler: (UIImage?) -> Void
        
        public init(completionHandler: @escaping (UIImage?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image: UIImage? = {
                if let image = info[.editedImage] as? UIImage {
                    return image
                }
                return info[.originalImage] as? UIImage
            }()
            completionHandler(image)
        }

        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completionHandler(nil)
        }
    }
}
