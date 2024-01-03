//
//  ContentView.swift
//  SwiftUISpeechDemo
//
//  Created by Angelos Staboulis on 3/1/24.
//

import SwiftUI
import Speech
struct ContentView: View {
    @State var editor:String
    var helper = Helper()
    var body: some View {
        VStack {
            TextEditor(text: $editor).colorMultiply(.accentColor)
            Spacer()
            Button {
                Task{
                    helper.printTextFromAudio(completion:
                    { value in
                            editor = value
                        
                    })
                }
            } label: {
                Text("Print Text from Audio")
            }

        }
        .padding()
        .onAppear(perform: {
            helper.requestPermission()
        })
    }

}

#Preview {
    ContentView(editor: "")
}
