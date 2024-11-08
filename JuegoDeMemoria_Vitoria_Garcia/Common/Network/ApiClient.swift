//
//  ApiClient.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 7/11/24.
//

import Foundation

class ApiClient {
    static let baseURL = "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/"
    static let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8"
    
    static func request(relativeurl: String, method: String, jsonData: Data? = nil) async -> Data? {
        let url = URL(string: baseURL + relativeurl)
        if let url {
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("\(apiKey)", forHTTPHeaderField: "apikey")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let jsonData {
                request.httpBody = jsonData
            }
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                return data
            } catch{
                print(error)
                return nil
            }
        }
        return nil
    }
}
