//
//  UserService.swift
//  AirportSearch
//
//  Created by Porfirio on 17/08/24.


import Foundation

protocol AirportManagerDelegate {
    func didUpdateLocation(_ userService: UserService, airport: AirportModel)
    func didFailWithError(error: Error)
}

struct UserService {
    
    var delegate: AirportManagerDelegate?
    
    func ddsss (km: String, latitud: String, longitud: String) {
        
        let headers = [
            "x-rapidapi-key": "608013a6dbmsh140216797632ea0p1d778cjsnc56fe438da86",
            "x-rapidapi-host": "aviation-reference-data.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(latitud)&lon=\(longitud)&radius=\(km)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
//MARK: - SESSION URL
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
            if (error != nil) {
                print(error as Any)
            } else {
                _ = response as? HTTPURLResponse
            }
            
            if let safeData = data {
                
                if let airportData = self.parseJSON(safeData) {
                    self.delegate?.didUpdateLocation(self, airport: airportData)
                }
            }
            if let jsonString = String(data: data!, encoding: .utf8) {
              //  print("Received JSON: \(jsonString)")
                
                if let jsonData = jsonString.data(using: .utf8){
                   // print("Estos son los datos convertidos a Data\(jsonData)")
                }
            }
             
        })

        dataTask.resume()
        
     }
    
    func parseJSON(_ airportModel: Data) -> AirportModel? {
        
       let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Airport.self, from: airportModel)
            
            let alpha2countryCode = decodedData.alpha2countryCode
            let iataCode = decodedData.iataCode
            let icaoCode = decodedData.icaoCode
            let latitude = decodedData.latitude
            let longitude = decodedData.longitude
            let name = decodedData.name
            
            let airport = AirportModel(alpha2countryCode: alpha2countryCode, iataCode: iataCode, icaoCode: icaoCode, latitude: latitude, longitude: longitude, name: name)
            
            return airport
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
      }
 }

