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
                    print("Now you are authorized")
                } else {
                    print("You are not authorized to use this service")
                }
            }
        }
    }
    func printTextFromAudio(completion:@escaping (String)->()) {
        DispatchQueue.main.async{
            self.speech?.recognitionTask(with: self.speechRequest, resultHandler: { result, error in
                    var editor:String
                    editor = result!.bestTranscription.formattedString
                    completion(editor)
            })
        }

        
    }
}
