//
//  FetcherController.swift
//  flickFunnies
//
//  Created by Batista Tone on 24/05/23.
//

import Foundation


protocol FetcherDelegate {
    func handleSuccess(data: Any)
    func handleError(data: Any)
}

typealias DynamicCodable = AnyObject & Codable


class FetcherController  {
    
    var apiUrl = ""
    
    init(apiUrl: String = "") {
        self.apiUrl = apiUrl
    }
    
    var delegate: FetcherDelegate?
    
    
    func makeRequest<T>(endpoint: String, method: String, params: [String: String], model: T.Type)-> Void where T: Decodable{
        
    
        
        let session = URLSession.shared
        let urlString = URL(string: "\(self.apiUrl)\(endpoint)")
        var request = URLRequest(url: urlString!)
        
        request.httpMethod = method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if(!params.isEmpty){
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
               
            }catch {
                self.delegate?.handleError(data: error.localizedDescription)
            }
        }
        
       
        
        
        let task = session.dataTask(with: request) { [self]
            (data, response, error) in
            
            if let error = error {
                self.delegate?.handleError(data:error.localizedDescription)
                  
                return;
                }


                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode)
                else {
                let data = String(data: data!, encoding: .utf8)
                
                    self.delegate?.handleError(data: data!.replacingOccurrences(of: "\"", with: ""))
                
                    return;
                }


            guard data != nil else {
                self.delegate?.handleError(data:"Error trying to access the database")
                  print("nil Data received from the server")
                  return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    
                   
                    
                    let data = try decoder.decode(model.self, from: data!)
                    
                    
                    self.delegate?.handleSuccess(data: data)
                    
                    
                  } catch  {
                      
                      self.delegate?.handleError(data: error.localizedDescription)
                }
        }
        
        
        task.resume()
     
        
    }
}
