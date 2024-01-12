import SwiftUI

struct MetronomeView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.purple, Color.red]),
            startPoint: .bottomTrailing, endPoint: .topLeading)
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack {
                HStack {
                    Text("-10")
                        .font(.system(size: 14, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onTapGesture {
                            if vm.bpm - 10 > 0 {
                                vm.bpm -= 10
                            }
                            else {
                                vm.bpm = 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                    Text("-1")
                        .font(.system(size: 24, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onTapGesture {
                            if vm.bpm > 1 {
                                vm.bpm -= 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                    
                    Text("\(vm.bpm) BPM")
                        .font(.system(size: 24, design: .monospaced))
                        .padding()
                    
                    Text("+1")
                        .font(.system(size: 24, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onTapGesture {
                            if vm.bpm < 350 {
                                vm.bpm += 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                    Text("+10")
                        .font(.system(size: 14, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onTapGesture {
                            if vm.bpm + 10 > 350 {
                                vm.bpm = 350
                            }
                            else {
                                vm.bpm += 10
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                            }
                        }
                }
                Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
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
