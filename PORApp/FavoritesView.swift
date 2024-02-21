//
//  RecordsView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI


struct Favorites : Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var content : String
    
    
    static func json(records : [Favorites]) -> String {
        do {
            let data = try JSONEncoder().encode(records)
            let string = String(data: data, encoding: .utf8)
            return string ?? "[]"
        } catch _ {
            
        }
        return "[]"
    }
    
    static func get(string : String) -> [Favorites]{
        do {
            if let data = string.data(using: .utf8) {
                let records = try JSONDecoder().decode([Favorites].self, from: data)
                return records
            }
        } catch _ {
            
        }
        return []
    }
}

struct FavoritesView: View {
    
    @AppStorage("records") var recordJSON : String = ""
    @State var records : [Favorites] = []
    @State var title : String = ""
    @State var content : String = ""
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Rating", text: $title).textFieldStyle(.roundedBorder)
                    TextField("Address", text: $content).textFieldStyle(.roundedBorder)
                    Button(action: {
                        records.append(Favorites(title: title, content: content))
                        title = ""
                        content = ""
                        save()
                    }, label: {
                        Text("Add")
                    }).padding()
                }.padding()
                List {
                    
                    ForEach(records) {
                        record in
                        VStack (alignment: .leading){
                            Text("\(record.title)")
                                .font(.headline)
                            Text("\(record.content)")
                        }.padding(5)
                    }.onDelete(perform: { indexSet in
                        records.remove(atOffsets: indexSet)
                        save()
                    })
                }
                .listStyle(.grouped)
                .navigationTitle("Favorite Stations")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            self.records = Favorites.get(string: recordJSON)
        }
    }
    
    func save() {
        self.recordJSON = Favorites.json(records: self.records)
    }
}

struct RecordsView_Preview : PreviewProvider {
    static var previews: some View {
        FavoritesView(records: [])
    }
}
