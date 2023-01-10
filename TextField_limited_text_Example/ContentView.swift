//
//  ContentView.swift
//  TextField_limited_text_Example
//
//  Created by cano on 2023/01/10.
//

import SwiftUI


class TextManager: ObservableObject{
    
    @Published var text = ""{
        didSet{
            if text.count > 15 && oldValue.count <= 15{
                text = oldValue
            }
        }
    }
}


struct ContentView: View {
    
    @StateObject var manager = TextManager()
    @State var isTapped = false
    
    var body: some View {
        
        VStack{
            
            VStack(alignment: .leading, spacing: 4, content: {
                
                HStack(spacing: 15) {
                    
                    // were going to limit the textfiled length....
                    
                    TextField("", text: $manager.text) { (status) in
                        // it will fire when textfield is clicked...
                        if status{
                            withAnimation(.easeIn){
                                // moving hint to top..
                                isTapped = true
                            }
                        }
                    } onCommit: {
                        // it will fire when return button is pressed...
                        // only if no text typed..
                        if manager.text == "" {
                            withAnimation(.easeOut){
                                isTapped = false
                            }
                        }
                    }
                    
                    // Trailing Icon Or Button...
                    
                    Button(action: {}, label: {
                        Image(systemName: "suit.star")
                            .foregroundColor(.gray)
                    })
                }
                // if tapped...
                .padding(.top,isTapped ? 15 : 0)
                // overlay will avoid clicking the textfiled...
                // so moving it below the textfield..
                .background(
                
                    Text("UserName")
                        .scaleEffect(isTapped ? 0.8 : 1)
                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundColor(isTapped ? .accentColor : .gray)
                    ,alignment: .leading
                )
                .padding(.horizontal)
                
                // Divider Color...
                Rectangle()
                    .fill(isTapped ? Color.accentColor : Color.gray)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(height: 1)
                    .padding(.top,10)
            })
            .padding(.top,12)
            .background(Color.gray.opacity(0.09))
            .cornerRadius(5)
            
            // Displaying Count...
            HStack{
                
                Spacer()
                
                Text("\(manager.text.count)/15")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
                    .padding(.top,4)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
