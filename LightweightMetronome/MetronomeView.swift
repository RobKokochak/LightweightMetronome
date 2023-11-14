//
//  MetronomeView.swift
//  LightweightMetronome
//
//  Created by Rob Kokochak on 10/27/23.
//

import SwiftUI

struct MetronomeView: View {
    @StateObject private var vm = ViewModel()
        
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.orange, Color.yellow]),
            startPoint: .bottomTrailing, endPoint: .topLeading)
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack {
                HStack {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            if vm.bpm > 1 {
                                vm.bpm -= 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                        .onLongPressGesture(minimumDuration: 0.1) {
                            if vm.bpm > 20 {
                                vm.bpm -= 20
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                    Text("\(vm.bpm) BPM")
                        .font(.system(size: 24))
                        .padding()
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            if vm.bpm < 350 {
                                vm.bpm += 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                        .onLongPressGesture(minimumDuration: 0.1) {
                            if vm.bpm < 331 {
                                vm.bpm += 20
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                }
                Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.isPlaying.toggle()
                        if vm.isPlaying {
                            vm.startMetronome()
                        }
                        else {
                            vm.stopMetronome()
                        }
                    }
                    .padding()
            }
                .foregroundColor(.black)
        )
    }
}

#Preview {
    MetronomeView()
}
