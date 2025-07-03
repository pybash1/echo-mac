//
//  Network.swift
//  Echo
//
//  Created by Ananjan Mitra on 12/06/25.
//

import AppKit

func addItemToDb(item: String) {
    guard let url = URL(string: (ProcessInfo.processInfo.environment["PROXY_URL"] ?? "") + "/api/trpc/clipboard.addItem?batch=1") else {
        fatalError("the dev put some invalid string as url... pls contact him")
    }
    
    var urlReq = URLRequest(url: url)
    urlReq.httpMethod = "POST"
    urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let reqData = "{ \"0\": { \"json\": { \"item\": \"\(item.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")\", \"device\": \"desktop\" } } }"
    
    print(reqData)
    
    urlReq.httpBody = reqData.data(using: .utf8)

    let postTask = URLSession.shared.dataTask(with: urlReq) { data, res, err in
        if let err = err {
            print("failed to put item in db: ", err)
            return
        }
        
        guard let res = res as? HTTPURLResponse else {
            return
        }
        
        if res.statusCode == 200 {
            guard data != nil else { return }
        } else {
            print("non 200 return code... \(res.statusCode) might mean request was not successful")
        }
    }
    
    postTask.resume()
}

func getLatestItemFromDb(finished: @escaping (String) -> Void) {
    guard let url = URL(string: (ProcessInfo.processInfo.environment["PROXY_URL"] ?? "") + "/api/trpc/clipboard.getLastCopiedItem?batch=1&input={\"0\":{\"json\":{\"device\":\"mobile\"}}}") else {
        fatalError("the dev put some invalid string as url... pls contact him")
    }
    
    var recvdData: String = ""
    
    var urlReq = URLRequest(url: url)
    urlReq.httpMethod = "GET"
    urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let getTask = URLSession.shared.dataTask(with: urlReq) { (data, res, err) in
        if let err = err {
            print("failed to put item in db: ", err)
            return
        }
        
        guard let res = res as? HTTPURLResponse else {
            return
        }
        
        if res.statusCode == 200 {
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let decoded = try JSONDecoder().decode([GetLastCopiedItemResponse].self, from: data)
                    recvdData = decoded[0].result.data.json.item
                    finished(recvdData)
                    return
                } catch let err {
                    print("could not decode: ", err)
                }
            }
        } else {
            print("non 200 return code... \(res.statusCode) might mean request was not successful")
        }
    }
    
    getTask.resume()
}
