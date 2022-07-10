//
//  LogoView.swift
//  Leagues
//
//  Created by Nick on 09.07.2022.
//

import SwiftUI

struct LogoView: View {
    @ObservedObject var image: Remote<UIImage>
    
    init(_ url: URL) {
        image = Remote(url: url, transform: { UIImage(data: $0) })
    }
    
    var imageOrPlaceholder: Image {
        image.value.map(Image.init) ?? Image(systemName: "photo")
    }

    var body: some View {
        if let image = image.value.map(Image.init) {
            image.resizable()
        } else {
            ProgressView().onAppear { image.load() }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(URL(string: "https://a.espncdn.com/i/leaguelogos/soccer/500/1.png")!)
    }
}
