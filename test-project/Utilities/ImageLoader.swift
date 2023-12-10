//
//  ImageLoader.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    
    private let baseRouter = BaseRouter()
    
    private var baseURL: String {
        return baseRouter.imageUploadBaseURL
    }
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    private let imageLoadingQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "ImageLoadingQueue"
        queue.maxConcurrentOperationCount = 5
        
        return queue
    }()
    
    private init() {
        imageCache.countLimit = 1000
    }
    
    @discardableResult
    func loadImage(from url: String?, placeholder: UIImage? = nil, completion: @escaping (UIImage?) -> Void) -> Operation? {
           
           guard let urlString = url,
                 let imageURL = URL(string: baseURL + urlString)
        else {  
               DispatchQueue.main.async {
                   completion(placeholder)
               }
               return nil
           }
           
           let loadImageOperation = BlockOperation {
               [weak self] in
               
               if let cachedImage = self?.imageCache.object(forKey: urlString as NSString) {
                   
                   DispatchQueue.main.async {
                       completion(cachedImage)
                   }
                   
                    return
                }
               
               guard
                let data = try? Data(contentsOf: imageURL),
                let image = UIImage(data: data)
               else {
                   DispatchQueue.main.async {
                       completion(placeholder)
                   }
                   return
               }
               
               self?.imageCache.setObject(image, forKey: urlString as NSString, cost: 1)
               
               DispatchQueue.main.async {
                   completion(image)
               }
           }
           
           imageLoadingQueue.addOperation(loadImageOperation)
           
           return loadImageOperation
    }
}
