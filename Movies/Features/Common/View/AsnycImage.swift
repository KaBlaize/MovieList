//
//  AsnycImage.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation
import SwiftUI

struct AsyncImage: View {
    let url: String

    var body: some View {
        SwiftUI.AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.5)
        }
    }
}
