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
            startPoint: .leading, endPoint: .trailing)
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack {
                HStack {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            vm.bpm -= 1
                            if vm.isPlaying {
                                vm.startMetronome()
                            }
                        }
                    Text("\(vm.bpm) BPM")
                        .font(.system(size: 24))
                        .padding()
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            vm.bpm += 1
                            if vm.isPlaying {
                                vm.startMetronome()
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
