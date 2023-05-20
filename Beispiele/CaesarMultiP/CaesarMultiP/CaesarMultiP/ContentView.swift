//
//  ContentView.swift
//  CaesarMultiP
//
//  Created by Miriam Föller-Nord on 15.12.22.
//

import SwiftUI

struct ContentView: View {
    
    
    
    
    //  mit selectedItem und .tag() kann ich feststellen, welcher Tab ausgewählt ist
    @State private var selectedItem = 1
    var body: some View {
       
        VStack {
            TabView (selection: $selectedItem){
                myCaesarView(tabindex: $selectedItem).tabItem{
                    Image(systemName: "character.book.closed.hi")
                    Text("Enrcypt")
                }
                .tag(1)  // wird benötigt um festzustellen welcher Tab ausgewählt ist
                myCaesarView(tabindex: $selectedItem).tabItem{
                    Image(systemName: "book")
                    Text("Decrypt")
                }
                .tag(2)
                myBruteForceView().tabItem{
                    Image(systemName: "list.bullet")
                    Text("Brute Force")
                
                }
                .tag(3)
            }
        }
        .padding()
         
    }
}

// MARK: - myCaesarView
struct myCaesarView: View {
    // an tabindex wird selectedItem übergeben
    @Binding var tabindex: Int
    @State private var inmessage:String = ""
    @State private var keyTxt:String = ""
    @State private var outmessage:String = ""
    @State private var number:Int = 1

    

    var body: some View {
        let text1="Enter Plain Text (ASCII Characters):"
        let text2="Enter Cipher Text (ASCII Characters):"
        let tabtitle = tabindex == 1 ? "Encrypt" : "Decrypt"
        let texttext = tabindex == 1 ? text1 : text2

        VStack {
            Text(texttext)
                .frame(maxWidth: .infinity, alignment: .leading)
            //MARK: - TextEditor 1
            TextEditor(text: $inmessage)
                .border(Color.gray)
                .font(.title)
                

            HStack{
                Image(systemName: "key.horizontal")
                    .font(.title)
                    .foregroundColor(.blue)
                Picker("",selection: $number) {
                    ForEach(1...25, id: \.self) {
                        Text("\($0)")
                    }
                }.frame(width:80, height:40)
                
                /*
                TextField("Key", text: $keyTxt)
                    .frame(width:120)
                    .textFieldStyle(.roundedBorder)
  */
                
                Button(tabtitle) {
                    if tabindex == 1 {
                        outmessage = encrypt(inmessage, key: number)
                    } else {
                          outmessage = decrypt(inmessage, key: number)
                    }
                }
            }
            //MARK: - TextEditor 2
            TextEditor(text: $outmessage)
                .border(Color.gray)
                .font(.title)
        }
       // .autocorrectionDisabled()
    }
}
//MARK: - Brute Force View
struct myBruteForceView: View {
    @State private var ciphertxt:String=""
    var body: some View {
        Form{
            Text("Enter Cipher Text:")
                .frame(maxWidth: .infinity, alignment: .leading)

            TextEditor(text: $ciphertxt)
                .border(Color.gray)
                .font(.body)
                .frame(height:80)
            List(0..<26) { value in
                        HStack {
                            
                            Text("\(value): \(decrypt(ciphertxt, key: value))")
                        }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
