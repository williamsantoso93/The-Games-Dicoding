//
//  DetailScreen.swift
//  The Games
//
//  Created by William Santoso on 15/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core

public struct DetailScreen: View {
    @ObservedObject var viewModel: DetailViewModel
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public init(viewModel: DetailViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Group {
            if let game = viewModel.game {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        WebImage(url: URL(string: game.backgroundImage ?? ""))
                            .resizable()
                            .placeholder {
                                Image(systemName: "photo")
                                    .font(.title)
                            }
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0)
                            .frame(height: 225)
                            .clipped()
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(game.name)
                                        .bold()
                                        .font(.title)
                                    if let date = game.releasedDate {
                                        Text(date.dateToStringLong())
                                            .font(.body)
                                            .fontWeight(.medium)
                                    }
                                }
                                Spacer(minLength: 0)
                                VStack(spacing: 10.0) {
                                    Image(systemName: "star.fill")
                                        .imageScale(.large)
                                    Text("\(String(format: "%.2f", game.rating ?? 0))")
                                        .fontWeight(.medium)
                                        .font(.subheadline)
                                }
                            }
                            Text(game.description)
                            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                                if let genres = game.genres {
                                    if !genres.isEmpty {
                                        SectionsDetailView(header: "genres", items: genres)
                                    }
                                }
                                if let platfroms = game.parentPlatforms {
                                    if !platfroms.isEmpty {
                                        PlatfromsDetailView(header: "platfroms", items: platfroms)
                                    }
                                }
                                if let developers = game.developers {
                                    if !developers.isEmpty {
                                        SectionsDetailView(header: "developers", items: developers)
                                    }
                                }
                                if let publishers = game.publishers {
                                    if !publishers.isEmpty {
                                        SectionsDetailView(header: "publishers", items: publishers)
                                    }
                                }
                            }
                        }
                        .padding(16)
                    }
                    .padding(.bottom, 16)
                }
            } else {
                if viewModel.isLoading {
                    VStack(spacing: 16.0) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Text("Loading...")
                    }
                } else {
                    Text(viewModel.message)
                }
            }
        }
        .onAppear {
            viewModel.getIsFavorite()
        }
        .navigationTitle("Detail")
        .navigationBarItems(trailing:
                                Button {
                                    if viewModel.isFavorite {
                                        viewModel.deleteFavorite()
                                    } else {
                                        viewModel.addFavorite()
                                    }
                                } label: {
                                    Image(systemName: "\(viewModel.isFavorite ? "heart.fill" : "heart")")
                                        .font(.title3)
                                }
                                .disabled(viewModel.isLoading)
        )
    }
    
    struct SectionsDetailView: View {
        var header: String
        var items: [Item]
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(header.capitalized)
                    .font(.title3)
                Text(joinedItems(items))
                    .font(.caption)
            }
        }
        
        func joinedItems(_ items: [Item]?) -> String {
            if let items = items {
                if !items.isEmpty {
                    if items.count == 1 {
                        return items.first?.name ?? ""
                    } else {
                        var itemName = [String]()
                        for item in items {
                            itemName.append(item.name ?? "")
                        }
                        return itemName.joined(separator: ", ")
                    }
                }
            }
            return ""
        }
    }
    
    struct PlatfromsDetailView: View {
        var header: String
        var items: [ParentPlatform]
        var joinedItems: String {
            if !items.isEmpty {
                if items.count == 1 {
                    return items.first?.platform.name ?? ""
                } else {
                    var platfromName = [String]()
                    for item in items {
                        platfromName.append(item.platform.name ?? "")
                    }
                    return platfromName.joined(separator: ", ")
                }
            }
            return ""
        }
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(header.capitalized)
                    .font(.title3)
                Text(joinedItems)
                    .font(.caption)
            }
        }
    }
}

