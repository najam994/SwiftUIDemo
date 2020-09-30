//
//  CustomersList.swift
//  OffmadeDemo
//
//  Created by Syed Najam on 25/09/2020.
//

import SwiftUI

struct CustomersList: View {
    @State var isCustomerSelected = false
    
    init() {
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
    }
    
    var body: some View {
        NavigationLink(destination: CustomerDetailsView().environmentObject(CustomerDetailsData(employeeId: "some id"))){
            Text("View Customer Details")
        }
        .accentColor(Color.customAccentColor)
        .navigationBarTitle("Customer List")
    }
}

struct CustomersList_Previews: PreviewProvider {
    static var previews: some View {
        CustomersList()
    }
}
