//
//  HomeView.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 26/7/24.
//

import SwiftUI

struct HomeView: View {
    @State var navigateToGame = false
    @State var navigateToScore = false
    var body: some View {
        NavigationStack
        {
            
            VStack {
                Text("Juego de Memoria")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                Button(action: {
                    navigateToGame = true
                }, label: {
                    Text("Play")
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                }) .buttonStyle(.borderedProminent)
                    .tint(Color.pink)
                
                
                Button(action: {
                    navigateToScore = true
                }, label: {
                    Text("Puntuaciones")
                        .foregroundStyle(Color.pink)
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                }) .buttonStyle(.bordered)
            }
            .padding()
            .navigationDestination(isPresented: $navigateToGame) {
                GameView()
            
            }
            .navigationDestination(isPresented: $navigateToScore) {
                ScoreView()
            }
        }
    }
}

#Preview {
    HomeView()
}
