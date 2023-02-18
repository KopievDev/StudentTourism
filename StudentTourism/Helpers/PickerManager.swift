//
//  PickerManager.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

/**
 * PickerManager: by Kopiev
 *
 *  Обертка над UIImagePickerController, возвращает изображение через замыкание  в форматах: UIImage?, Data?
 */
final class PickerManager: NSObject, UINavigationControllerDelegate {
    typealias ImageBlock = (UIImage?) -> Void
    typealias DataBlock = (Data?) -> Void
    typealias URLBlock = (URL?) -> Void

    private var imageCompletion: ImageBlock?
    private var dataCompletion: DataBlock?
    private var urlCompletion: URLBlock?
    private var smallUrlCompletion: URLBlock?

    private let picker =  UIImagePickerController()
    private var image: UIImage?
    private var imageUrl: URL?
    
    override init() {
        super.init()
        picker.delegate = self
    }
    
    /**
     Презентует UIImagePickerController
     
     - parameter type: фото из галереи или камера  (Default: .camera)
     */
    func present(type: UIImagePickerController.SourceType = .camera) {
        picker.sourceType = type
        UIApplication.topViewController()?.present(picker, animated: true)
    }
    
    func present(type: UIImagePickerController.SourceType = .camera, image: ImageBlock? = nil ) {
        picker.sourceType = type
        imageCompletion = image
        UIApplication.topViewController()?.present(picker, animated: true)
    }
    
    // MARK: - Binding
    func getImage(_ image: ImageBlock? = nil) { imageCompletion = image }
    func getData(_ data: DataBlock? = nil) { dataCompletion = data }
    func getImageUrl(_ url: URLBlock? = nil) { urlCompletion = url }
    func getSmallImageUrl(_ url: URLBlock? = nil) { smallUrlCompletion = url }
}

extension PickerManager: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage { self.image = image }
        if let url = info[.imageURL] as? URL { imageUrl = url }
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.imageCompletion?(self.image)
            self.urlCompletion?(self.imageUrl)
            self.dataCompletion?(self.image?.jpegData(compressionQuality: 0.6))
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
