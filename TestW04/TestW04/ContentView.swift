//
//  ContentView.swift
//  TestW04
//
//  Created by Christian on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State private var angkaRandom = 0
    @State private var scoreBenar = 0
    @State private var scoreSalah = 0
    @State private var isGameFinished = false
    @State private var showAlert = false

    @State private var negaraTerpilih = Set<String>()

    
    var body: some View {
        ZStack{
            Color.mint
                .ignoresSafeArea()
            VStack{
                Text("Pilih Bendera dari Negara : ")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(asean[angkaRandom])
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        
        HStack{
            Spacer()
            VStack{
                ForEach(0..<5) { number in
                    Button {
                        checkAnswer(number)
                    } label: {
                        
                        Image(asean[number])
                            .resizable()
                            .frame(width:105,height: 65)
                    }
                }
            }
            Spacer()
            VStack{
                ForEach(5..<10) { number in
                    Button {
                        checkAnswer(number)
                    } label: {
                        
                        Image(asean[number])
                            .resizable()
                            .frame(width:105,height: 65)
                    }
                }
            }
            Spacer()
        }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Game telah selesai!"),
                    message: Text("Benar: \(scoreBenar), Salah: \(scoreSalah)\n\nRestart game?"),
                    
                    primaryButton: .default(Text("Yes"), action: {
                        restartGame()
                    }),
                    secondaryButton: .cancel(Text("No"))
                )
            }
    }
    func checkAnswer(_ selectedFlagIndex: Int) {
        let selectedCountry = asean[selectedFlagIndex]
        let correctFlagName = asean[angkaRandom].replacingOccurrences(of: " ", with: "").lowercased()
        
        if selectedCountry.lowercased() == correctFlagName {
            scoreBenar += 1
        } else {
            scoreSalah += 1
        }
        
        negaraTerpilih.insert(asean[angkaRandom])
        
        if negaraTerpilih.count == asean.count {
            isGameFinished = true
            showAlert = true
        } else {
            generateRandomCountry()
        }
    }
    func restartGame() {
        angkaRandom = 0
        scoreBenar = 0
        scoreSalah = 0
        isGameFinished = false
        showAlert = false
        negaraTerpilih.removeAll()

        generateRandomCountry()
    }
    func generateRandomCountry() {
        let remainingCountries = Array(Set(asean).subtracting(negaraTerpilih))
        if let randomCountry = remainingCountries.randomElement() {
            if let index = asean.firstIndex(of: randomCountry) {
                angkaRandom = index
            }
        }
    }
}

#Preview {
    ContentView()
}

