//
//  ScoreView.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 7/8/24.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var vm = ScoreViewModel()
    var body: some View {
        VStack{
            ScrollView{
                Text("Ranking")
                    .font(.title)
                    .padding()
                ForEach (vm.scores,id:\.self){score in
                    HStack{
                        Text( score.name)
                        .fontWeight(.bold)
                        Text("\(score.score)")
                            .opacity(0.7)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        
        } .onAppear{
            vm.getAllScores()
        }
    }
}

#Preview {
    ScoreView()
}
