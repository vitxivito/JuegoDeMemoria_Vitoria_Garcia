//
//  GameOverView.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 25/10/24.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var vm : GameOverViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Game Over")
                .foregroundStyle(Color.pink)
                .bold()
                .font(.system(size: 35))
                
            TextField("name", text:$vm.name)
                .padding()
                .border(Color.pink)
                .padding(.all)
            
            Text("Puntuacion : \(vm.score)")
                .bold()
                .font(.system(size: 20))
            
          
            Button(action: {
                vm.sendScore()
                dismiss()
                
            }, label: {
                Text("Restart")
                    .padding()
                    .frame(maxWidth: .infinity)
                
            }) .buttonStyle(.borderedProminent)
                .tint(Color(.pink))
                .padding(.top)
        } .padding()
    }
}
#Preview {
    GameOverView(vm: GameOverViewModel(name: "", score: 222))
}
