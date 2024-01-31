import SwiftUI

struct MetronomeView: View {
    @StateObject private var vm = MetronomeViewModel()
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.orange, Color.yellow]),
            startPoint: .bottomTrailing, endPoint: .topLeading)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            VStack {
                HStack {
                    Text("-10")
                        .font(.system(size: 14, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onHover { inside in
                            if inside {
                                NSCursor.pointingHand.set()
                            } else {
                                NSCursor.arrow.set()
                            }
                        }
                        .onTapGesture {
                            if vm.bpm - 10 > 0 {
                                vm.bpm -= 10
                            }
                            else {
                                vm.bpm = 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                                vm.startMetronome()
                            }
                        }
                    Text("-1")
                        .font(.system(size: 24, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onHover { inside in
                            if inside {
                                NSCursor.pointingHand.set()
                            } else {
                                NSCursor.arrow.set()
                            }
                        }
                        .onTapGesture {
                            if vm.bpm > 1 {
                                vm.bpm -= 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                                vm.startMetronome()
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
                        .onHover { inside in
                            if inside {
                                NSCursor.pointingHand.set()
                            } else {
                                NSCursor.arrow.set()
                            }
                        }
                        .onTapGesture {
                            if vm.bpm < 350 {
                                vm.bpm += 1
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                                vm.startMetronome()
                            }
                        }
                    Text("+10")
                        .font(.system(size: 14, design: .monospaced))
                        .padding(12)
                        .overlay(
                            Circle().stroke(lineWidth: 5)
                        )
                        .clipShape(Circle())
                        .onHover { inside in
                            if inside {
                                NSCursor.pointingHand.set()
                            } else {
                                NSCursor.arrow.set()
                            }
                        }
                        .onTapGesture {
                            if vm.bpm + 10 > 350 {
                                vm.bpm = 350
                            }
                            else {
                                vm.bpm += 10
                            }
                            if vm.isPlaying {
                                vm.stopMetronome()
                                vm.startMetronome()
                            }
                        }
                }
                Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .onHover { inside in
                        if inside {
                            NSCursor.pointingHand.set()
                        } else {
                            NSCursor.arrow.set()
                        }
                    }
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
                Slider(value: $vm.volume)
                    .padding()
                    .frame(width: 300)
                    .tint(.black)
            }
            .foregroundColor(.black)
        }
    }
}

#Preview {
    MetronomeView()
}
