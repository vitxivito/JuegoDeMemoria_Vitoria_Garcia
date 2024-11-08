//
//  ScoreViewModel.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 7/8/24.
//

import Foundation
class ScoreViewModel : ObservableObject{
    @Published var scores : [ScoreModel] = []
    
    func getAllScores() {
        Task {
            guard let data = await ApiClient.request(relativeurl:"scores?select=*", method: "GET") else {return}
            let decoder = JSONDecoder()
            do {
                let dataIn = try decoder.decode([ScoreModel].self, from: data)
                print(dataIn)
                DispatchQueue.main.async {
                    self.scores = dataIn
                }
            } catch {
                print(error)
            }
        }
    }

}
