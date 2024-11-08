//
//  GameViewModel.swift
//  JuegoDeMemoria_Vitoria_Garcia
//
//  Created by Vitoria Garcia on 30/7/24.
//
import Combine
import Foundation
import AVFoundation

class GameViewModel : ObservableObject {
    @Published var guideImage : AlbumType?
    @Published var score: Int = 0
    @Published var canPlay = false
    @Published var showGameOver = false
    var sequence : [AlbumType] = []
    private var userTapIndex = 0
    
    
    
    //rutas a sonidos, guardadas en Sounds //
    //audioPlayer libreria de Apple//
    private let soundpinkPath = Bundle.main.path(forResource: "Color1", ofType: "wav")!
    private let soundpurplePath = Bundle.main.path(forResource: "Color2", ofType: "wav")!
    private let soundwhitePath = Bundle.main.path(forResource: "Color3", ofType: "wav")!
    private let soundblackPath = Bundle.main.path(forResource: "Color4", ofType: "wav")!
    private let soundGameOverPath = Bundle.main.path(forResource: "gameOver", ofType: "wav")!
    private var audioPlayer : AVAudioPlayer?
    
    //Crea una img y la añade a la secuencia
    func addImage() {
        //selecciona un case aleatorio desde AlbumType
        let newImage = AlbumType.allCases.randomElement()
        //verifica que no sea nulo
        guard let newImage = newImage else {return}
        // lo añade a la secuencia
        sequence.append(newImage)
        
    }
    
    func showSequence(index: Int) {
        canPlay = false
        userTapIndex = 0
        //el codigo lo ejecutara en 1s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in // permite que el self del futuro sea nulo
            guard let self = self else {return} // paramos la funcion si self es nulo
            if index >= sequence.count {
                // esto pasa cuando hemos enseñado toda la secuencia //
                guideImage = nil
                canPlay = true
            } else {
                // enseñamos la siguiente imagen de la secuencia //
                guideImage = sequence[index]
                playSound(album: guideImage)
                showSequence(index: index + 1)
            }
        }
        
    }
    func tapButton(type: AlbumType) {
        playSound(album: type)
        if sequence[userTapIndex] != type{
            //cuando has escogido mal la imagen
         gameOver()
            return //no sigue ejecutando
        }
        if sequence.count-1 == userTapIndex {
            // este codigo se ejecuta cuando ya hemos recorrido todo el sequence y tenemos que pasar a la siguiente ronda
            nextRound()
        }else {
           userTapIndex += 1
        }
    }
    
    func nextRound(){
        score += 1
        addImage()
        showSequence(index: 0)
    }
    
    func playSound(album: AlbumType?) {
        var url = URL(string: "")
        guard let album = album else {
            url = URL(fileURLWithPath: soundGameOverPath)
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url!)
                audioPlayer?.play()
            }catch{
                print(error.localizedDescription)
                
            }
            return
        }
        
        switch album {
        case .pink:
            url = URL(fileURLWithPath: soundpinkPath)
        case .purple:
            url = URL(fileURLWithPath: soundpurplePath)
        case .white:
            url = URL(fileURLWithPath: soundwhitePath)
        case .black:
            url = URL(fileURLWithPath: soundblackPath)
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.volume = 0.1
            audioPlayer?.play()
        }catch{
            print(error.localizedDescription)
        }
    }
    func gameStart(){
        sequence.removeAll()
        score = 0
        repeat{
        addImage()
        } while sequence.count < 4
        showSequence(index:0)
    }
    func gameOver(){
       canPlay = false
        playSound(album: nil)
        showGameOver = true
    }
}
enum AlbumType: CaseIterable {
    
    case pink
    case purple
    case white
    case black
    
}
