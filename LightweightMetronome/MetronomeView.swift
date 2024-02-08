import SwiftUI

struct MetronomeView: View {
    @StateObject private var vm = MetronomeViewModel()
    @FocusState private var focused: Bool
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.orange, Color.yellow]),
            startPoint: .bottomTrailing, endPoint: .topLeading)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            VStack {
                HStack {
                    Text("-10")
                        .font(.system(size: 16))
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
                                vm.resetBPM()
                            }
                        }
                    Text("-1")
                        .font(.system(size: 26))
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
                                vm.resetBPM()
                            }
                        }
                    
                    Text("\(vm.bpm) BPM")
                        .font(.system(size: 28))
                        .padding()
                    
                    Text("+1")
                        .font(.system(size: 26))
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
                            if vm.bpm < 400 {
                                vm.bpm += 1
                            }
                            if vm.isPlaying {
                                vm.resetBPM()
                            }
                        }
                    Text("+10")
                        .font(.system(size: 16))
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
                            if vm.bpm + 10 > 400 {
                                vm.bpm = 400
                            }
                            else {
                                vm.bpm += 10
                            }
                            if vm.isPlaying {
                                vm.resetBPM()
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
        .focusable()
        .focused($focused)
        .onKeyPress { press in
            switch press.characters {
            case " ":
                DispatchQueue.main.async {
                    vm.isPlaying.toggle()
                    if vm.isPlaying {
                        vm.startMetronome()
                    }
                    else {
                        vm.stopMetronome()
                    }
                }
                return .handled
            case ",":
                DispatchQueue.main.async {
                    if vm.bpm > 1 {
                        vm.bpm -= 1
                    }
                    if vm.isPlaying {
                        vm.resetBPM()
                    }
                }
                return .handled
            case ".":
                DispatchQueue.main.async {
                    if vm.bpm < 400 {
                        vm.bpm += 1
                    }
                    if vm.isPlaying {
                        vm.resetBPM()
                    }
                }
                return .handled
            default:
                return .ignored
            }
        }
        .onAppear {
            focused = true
        }
    }
}

#Preview {
    MetronomeView()
}
