//
//  UIImageView.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit
import SDWebImage

typealias ImageWithURLBlock = (UIImage?, URL?) -> Void

extension UIImageView {
    
    func setImage(url: String, placeholder: UIImage? = nil, block: ImageWithURLBlock? = nil) {
        guard let string = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: string) else { return }
		sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with: url, placeholderImage: placeholder, options: [.retryFailed, .highPriority]) { image , error, cache, url in
            if let error = error { print(error.localizedDescription) }
            block?(image, url)
        }
    }
    
    func setImage(urlString: String) {
        guard let string = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        if URLCache.shared.cachedResponse(for: request) != nil {
            loadImageFromCache(imageURL: url)
        } else {
            downloadImage(imageURL: url)
        }
    }
    
    private func downloadImage(imageURL: URL) {
        let request = URLRequest(url: imageURL)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let resp = response, let image = UIImage(data: data) else { return }
            URLCache.shared.storeCachedResponse(CachedURLResponse(response: resp, data: data), for: request)
            DispatchQueue.main.async { self.transition(to: image) }
        }.resume()
    }
    
    private func loadImageFromCache(imageURL: URL) {
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = URLCache.shared.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async { self.image = image }
            }
        }
    }
    
    func transition(to image: UIImage?) {
        UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve]) { self.image = image }
    }
    
    func setImage(_ image: UIImage) {
        self.alpha = 0
        self.image = image
        UIView.animate(withDuration: 0.3) { self.alpha = 1 }
    }
    
}


extension UIImage {
    
    convenience init?(url: String) {
        guard let url = URL(string: url), let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
    
}

extension UIImage {
    /// Fix image orientaton to protrait up
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }

        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }

        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }

        var transform: CGAffineTransform = CGAffineTransform.identity

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        ctx.concatenate(transform)

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }

        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
}
