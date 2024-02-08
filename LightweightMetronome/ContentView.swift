//
//  ContentView.swift
//  LightweightMetronome
//
//  Created by Rob Kokochak on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MetronomeView()
            .frame(
                minWidth: 450,
                idealWidth: 500,
                maxWidth: .infinity,
                minHeight: 300,
                idealHeight: 350,
                maxHeight: .infinity
            )
    }
}

#Preview {
    ContentView()
}
