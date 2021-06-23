//
//  AstronController.swift
//  Astronomy
//
//  Created by 方芸萱 on 2021/6/18.
//

import UIKit

class AstronController{
    static let shared = AstronController()
    let astronURL = URL(string: "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json")!
    let imageCache = NSCache<NSURL, UIImage>()
    
    func fetchAstronData(completion: @escaping ([AstronItem]?) -> Void){
        let task = URLSession.shared.dataTask(with: astronURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let astronitems = try? jsonDecoder.decode([AstronItem].self, from: data){
                print(astronitems[2].title)
                completion(astronitems)
            }else{
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(withURL urlString: String, completion: @escaping (UIImage?) -> Void){
        let url = URL(string: urlString)!
        
        if let image = imageCache.object(forKey: url as NSURL){
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data){
                self.imageCache.setObject(image, forKey: url as NSURL)
                completion(image)
            }else{
                completion(nil)
            }
        }
        task.resume()
    }
}
