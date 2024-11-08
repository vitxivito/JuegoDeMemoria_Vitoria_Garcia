//
//  GameOverViewModel.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 25/10/24.
//
import Foundation
class GameOverViewModel : ObservableObject{
    @Published var name : String = ""
    @Published var score : Int = 0
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    func sendScore() {
        let scoreOut = ScoreModel(name: name, score: score)
        let json = try? JSONEncoder().encode(scoreOut)
        if let jsonString = String(data: json!, encoding: .utf8) {
                print("JSON String: \(jsonString)")
        }
        Task {
            let data = await ApiClient.request(relativeurl:"scores", method: "POST", jsonData: json)
        }
    }
    
}
