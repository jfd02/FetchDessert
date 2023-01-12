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
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.transition(with: self,
                              duration:0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.image = image },
                              completion: nil)
                completion(image)
            }
        }
    }
}
