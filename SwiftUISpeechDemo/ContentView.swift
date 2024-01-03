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
    let speech = SFSpeechRecognizer()
    let speechRequest = SFSpeechURLRecognitionRequest(url: URL(filePath:Bundle.main.path(forResource: "sample", ofType: "mp3")!))
    var body: some View {
        VStack {
            TextEditor(text: $editor).colorMultiply(.accentColor)
            Spacer()
            Button {
                speech?.recognitionTask(with: speechRequest, resultHandler: { result, error in
                    editor = result!.bestTranscription.formattedString
                })
            } label: {
                Text("Print Text from Audio")
            }

        }
        .padding()
        .onAppear(perform: {
            requestPermission()
        })
    }
    func requestPermission() {
        SFSpeechRecognizer.requestAuthorization {  authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Good to go!")
                } else {
                    print("Transcription permission was declined.")
                }
            }
        }
    }
}

#Preview {
    ContentView(editor: "")
}
