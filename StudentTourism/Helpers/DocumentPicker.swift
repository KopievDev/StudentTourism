//
//  DocumentPicker.swift
//  Festa
//
//  Created by Ivan Kopiev on 01.02.2023.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class DocumentPicker: NSObject {
    
    enum Types  {
        case files, audios
        
        var types: [String] {
            switch self {
            case .files: return [
                kUTTypeImage as String,
                kUTTypeSpreadsheet as String,
                kUTTypePresentation as String,
                kUTTypeDatabase as String,
                kUTTypeFolder as String,
                kUTTypeZipArchive as String,
                kUTTypeVideo as String,
                "public.data",
                "public.text",
                "com.apple.iwork.pages.pages"
            ]
            case .audios: return [ kUTTypeAudio as String ]
            }
        }
    }
    typealias URLBlock = (URL?) -> Void
    private var urlCompletion: URLBlock?
    private var picker: UIDocumentPickerViewController?
    
    func present(types: Types = .files, url: URLBlock? = nil ) {
        picker = UIDocumentPickerViewController(documentTypes: types.types, in: .import)
        picker?.delegate = self
        urlCompletion = url
        UIApplication.topViewController()?.present(picker!, animated: true)
    }
    
}

extension DocumentPicker: UIDocumentPickerDelegate,UINavigationControllerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else { return }
        urlCompletion?(myURL)
        controller.dismiss(animated: true)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
