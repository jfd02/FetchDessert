//
//  RemoteImageView.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit
import Combine

class RemoteImageView: UIImageView {
    func load(url: URL, completion: @escaping (_ image: UIImage) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                    }
                }
            }
        }
    }
}
