//
//  ContentView.swift
//  InventoryLogger
//
//  Created by Hai Long Danny Thi on 2020/11/26.
//

import SwiftUI

struct InventoryItem: Identifiable, Codable {
   var id = UUID()
   let name: String
   let category: String
   let quantity: Int
}

class Inventory: ObservableObject {
   @Published var items: [InventoryItem] {
      didSet {
         let encoder = JSONEncoder()
         if let encodedData = try? encoder.encode(items) {
            UserDefaults.standard.setValue(encodedData, forKey: "InventoryData")
         }
      }
   }
   
   func removeItems(at offsets: IndexSet) {
      self.items.remove(atOffsets: offsets)
   }
   
   init() {
      if let data = UserDefaults.standard.data(forKey: "InventoryData") {
         let decoder = JSONDecoder()
         if let decodedData = try? decoder.decode([InventoryItem].self, from: data) {
            self.items = decodedData
            return
         }
      }
      // Load data
      self.items = []
   }
}

struct ContentView: View {
   @ObservedObject var inventory: Inventory
   @State private var showAddInventory = false
   
   func removeItems(at offsets: IndexSet) {
      self.inventory.removeItems(at: offsets)
   }
   
   var body: some View {
      NavigationView {
         VStack {
            List {
               ForEach(inventory.items) { item in
                  HStack {
                     Text(item.name)
                     Text(item.category)
                     Spacer()
                     Text("\(item.quantity)")
                  }
               }
               .onDelete(perform: removeItems)
            }
         }
            .navigationBarTitle(Text("Inventory"))
            .navigationBarItems(trailing:
               Button(action: { self.showAddInventory = true }) {
                  Image(systemName: "plus")
               }
            )
      }
         .sheet(isPresented: $showAddInventory) {
            AddInventory(inventory: self.inventory)
         }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView(inventory: Inventory())
   }
}
