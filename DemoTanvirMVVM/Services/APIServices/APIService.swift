//
//  APIService.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation
import Combine



// MARK: - Old Way, Without Protocol, Please check APIServiceCombine file for Protocol Oriented Way
// MARK: - Old Way, Now I use protocol oriented way by Combine and Service layer, Please check APIServiceCombine file
class APIService{
    
    private static let session = URLSession.shared
    
    //Combine, Generic API call
    //1. Create the publisher
    //2. Subscribe to publisher on Background Thread
    //3. Recieve on main thread
    //4. trymap (make sure the data is good)
    //5. Decode data into model
    static func getRequestWithCombine<T: Decodable>(ofUrl urlString: String,as type: T.Type,decodedBy decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: urlString) else {
            let error = URLError(.badURL, userInfo: [NSURLErrorKey: urlString])
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> T in
                return try decoder.decode(T.self, from: result.data)
            }
            .eraseToAnyPublisher()
    }
        
    // Async throws iOS 15
    static func getRequestAsync<T:Decodable>(url:String) async throws -> T {
        
        print("debug: ",url)
        guard let url = URL(string: url) else {
            throw NetworkingError.invalidURL
        }

        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let httpResposne = response as? HTTPURLResponse,httpResposne.statusCode == 200 else{
                throw NetworkingError.statusCodeIsNotOkay
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from:data)
                return decodedData
            }catch{
                throw NetworkingError.decodingError(message: error.localizedDescription)
            }
            
        }catch{
            throw NetworkingError.canNotProcessData(message: error.localizedDescription)
        }
    }
    
    //OLD way with completion Handler
    static func getRequest<T:Codable>(urlString:String,completion: @escaping (Result<T,NetworkingError>)->Void){
        
        
        print("debug: urlString ",urlString)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else{
                completion(.failure(.nodataAvailable))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.canNotProcessData(message: error!.localizedDescription)))
                return
            }
            if response.statusCode == 200{
                do{
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(T.self, from: jsonData)
                    completion(.success(responseObject))
                }catch{
                    print("Error \(error)")
                    completion(.failure(.canNotProcessData(message: error.localizedDescription)))
                }
            }else{
                completion(.failure(.statusCodeIsNotOkay))
            }
            
        }
        
        dataTask.resume()
    }
}

enum NetworkingError:Error,LocalizedError{
    case nodataAvailable
    case invalidURL
    case canNotProcessData(message:String)
    case decodingError(message:String)
    case statusCodeIsNotOkay
    
    var errorDescription: String?{
        switch self {
        case .nodataAvailable:
            return NSLocalizedString("No data available", comment: "1")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "2")
        case .canNotProcessData(let message):
            return NSLocalizedString("Can not process data / No internet Connection. \(message)", comment: "3")
        case .decodingError(let message):
            return NSLocalizedString("Decoding error. \(message)", comment: "4")
        case .statusCodeIsNotOkay:
            return NSLocalizedString("Status code is not okay", comment: "5")
        }
    }
}
