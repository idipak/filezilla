//
//  EditCards.swift
//  FileZilla
//
//  Created by Codebucket on 10/11/22.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List{
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                
                Section{
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading){
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar{
                Button("Done", action: done)
            }
            .listStyle(.grouped)
//            .onAppear(perform: loadData)
        }
    }
    
    func done(){
        dismiss()
    }
    
    
    func saveData(){
        if let data = try? JSONEncoder().encode(cards){
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func addCard(){
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    func removeCard(at offset: IndexSet){
        cards.remove(atOffsets: offset)
        saveData()
    }
    
    
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
