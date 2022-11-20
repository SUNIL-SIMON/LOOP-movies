//
//  RequestHandler.swift
//  LOOP Movies
//
//  Created by SIMON on 16/11/22.
//

import Foundation
class RequestHandler
{
    func makeServerCall(urlString : String, completion : @escaping (Data,Bool) -> Void)
    {
        guard let url = URL(string: urlString) else {return}
        let urlSession = URLSession.shared.dataTask(with: url, completionHandler: {(data,responce,error) in
            if data != nil{
                completion(data!, error == nil)
            }
            else{
                completion(Data(), false)
            }
        })
        urlSession.resume()
    }
}
