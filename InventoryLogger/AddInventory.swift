//
//  AddInventory.swift
//  InventoryLogger
//
//  Created by Hai Long Danny Thi on 2020/11/27.
//

import SwiftUI

struct AddInventory: View {
   @ObservedObject var inventory: Inventory
   
   @State private var name = ""
   @State private var catergory = ""
   @State private var quantity = ""
   
   @Environment(\.presentationMode) var presentionMode
   
   var body: some View {
      NavigationView {
         VStack {
            Form {
               TextField("Name", text: $name)
               TextField("Catergory", text: $catergory)
               TextField("Quantity", text: $quantity)
            }
         }
         .navigationBarTitle(Text("Add Inventory"))
         .navigationBarItems(trailing: Button("Save") {
            if let quantity = Int(self.quantity) {
               let item = InventoryItem(name: self.name, category: self.catergory, quantity: quantity)
               self.inventory.items.append(item)
               self.presentionMode.wrappedValue.dismiss()
            }
         })
      }
   }
}

struct AddInventory_Previews: PreviewProvider {
   static var previews: some View {
      AddInventory(inventory: Inventory())
   }
}
