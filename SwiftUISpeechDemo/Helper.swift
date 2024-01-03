//
//  Helper.swift
//  SwiftUISpeechDemo
//
//  Created by Angelos Staboulis on 3/1/24.
//

import Foundation
import Speech
class Helper{
    let speech = SFSpeechRecognizer()
    let speechRequest = SFSpeechURLRecognitionRequest(url: URL(filePath:Bundle.main.path(forResource: "sample", ofType: "mp3")!))
   
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
    func printTextFromAudio() async -> [String]{
        return await withCheckedContinuation { continuation in
            speech?.recognitionTask(with: speechRequest, resultHandler: { result, error in
                    var editorArray:[String] = []
                    editorArray.append(result!.bestTranscription.formattedString)
                    continuation.resume(returning: editorArray)
            })
        }
        
    }
}
