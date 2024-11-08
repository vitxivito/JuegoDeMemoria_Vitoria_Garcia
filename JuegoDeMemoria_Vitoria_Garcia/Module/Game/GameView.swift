//
//  GameView.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 26/7/24.
//

import SwiftUI

struct GameView: View {
  @ObservedObject  var vm: GameViewModel = GameViewModel()
    var body: some View {
        VStack {
            Text("Puntuacion : \(vm.score)")
                .font(.title2)
                .padding()
            
            GuideImage(image: vm.guideImage)
                .scaledToFit()
                .shadow(radius: 5)
                .onTapGesture {
                    vm.addImage()
                    vm.addImage()
                    vm.addImage()
                    vm.addImage()
                    vm.showSequence(index: 0)
                }
            
        
            if vm.canPlay {
                HStack {
                    
                    Button(action: {
                        vm.tapButton(type: .pink)
                    }, label: {
                        Image("1")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                    })
                    
                    Button(action: {
                        vm.tapButton(type: .purple)
                    }, label: {
                        Image("2")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                    }) }
                HStack{
                    Button(action: {
                        vm.tapButton(type: .white)
                    }, label: {
                        Image("3")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    })
                    
                    Button(action: {
                        vm.tapButton(type: .black)
                    }, label: {
                        Image("4")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }) }
            } else {Spacer()}
        }
        .onAppear(perform: {
            vm.gameStart()
        })
        .sheet(isPresented: $vm.showGameOver) {
            GameOverView(vm: GameOverViewModel(name: "", score: vm.score))
                .interactiveDismissDisabled(true)
                .onDisappear{vm.gameStart()}
        }
    }
}

struct GuideImage: View {
    var image: AlbumType?
    var body: some View {
        switch image {
        case .pink:
            Image("1")
                .resizable()
                .scaledToFit()
                .frame( maxWidth:.infinity)
        case .purple:
            Image("2")
                .resizable()
                .scaledToFit()
                .frame( maxWidth:.infinity)
        case .white:
            Image("3")
                .resizable()
                .scaledToFit()
                .frame( maxWidth:.infinity)
        case .black:
            Image("4")
                .resizable()
                .scaledToFit()
                .frame( maxWidth:.infinity)
        case nil:
            Rectangle()
                .foregroundStyle(Color.white)
               
        }
    }
}

#Preview {
    GameView()
}
