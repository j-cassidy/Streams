//
//  PropFinder.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import Foundation
import Alamofire
import HTMLReader

class PropFinder {
    
    var charts: [Prop]?
    
    func getProps(countrySelection: String, completionHandler: @escaping (NSError?) -> Void) {
        Alamofire.request(spotifyBaseURL + countrySelection + spotifyDayURL).responseString { responseString in
            guard responseString.result.error == nil else {
                completionHandler(responseString.result.error! as NSError)
                return
                
            }
            guard let htmlAsString = responseString.result.value else {
                let error = NSError(domain: "StringSerializationFailed", code: 6004, userInfo: nil )
                completionHandler(error)
                return
            }
            let doc = HTMLDocument(string: htmlAsString)
            
            let chartsTable = doc.firstNode(matchingSelector: "tbody")
            
            guard let tableContents = chartsTable else {
                let error = NSError(domain: "DataSerializationError", code: 6004, userInfo: nil )
                completionHandler(error)
                return
            }
            
            self.charts = []
            for row in tableContents.children {
                if let rowElement = row as? HTMLElement {
                    if let newChart = self.parseHTML(rowElement: rowElement) {
                        self.charts?.append(newChart)
                    }
                }
            }
            completionHandler(nil)
        }
    }
    
    private func parseHTML(rowElement: HTMLElement) -> Prop? {
        
        var trackName: String?
        var artistName: String?
        var streams: Int?
        var position: Int?
        
        
        if let positionColumn = rowElement.firstNode(matchingSelector: "td.chart-table-position") {
            let text = positionColumn.textContent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: ",", with: "")
            position = Int(text)
            
            print(text)
            
        }
        
        
        if let trackColumn = rowElement.firstNode(matchingSelector: "td.chart-table-track") {
            
            if let trackNode = trackColumn.firstNode(matchingSelector: "strong") {
                trackName = trackNode.textContent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "\n", with: "")
                
                print(trackName ?? "N/A")
            }
            
            if let artistNode = trackColumn.firstNode(matchingSelector: "span") {
                artistName = artistNode.textContent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "by ", with: "")
                
                print(artistName ?? "N/A")
            }
            
        }
        
        if let streamsColumn = rowElement.firstNode(matchingSelector: "td.chart-table-streams") {
            let text = streamsColumn.textContent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: ",", with: "")
            streams = Int(text)
            print(text)
        }
        
        return Prop(trackName: trackName ?? "Unknown Track", artistName: artistName ?? "Unknown Artist", position: position ?? 0, streams: streams ?? 0)
    }
    
}
