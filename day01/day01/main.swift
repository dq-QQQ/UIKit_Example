//
//  main.swift
//  day01
//
//  Created by Chan on 2022/08/17.
//
import Foundation

class Deck: NSObject {
	static let allSpades: [Card] = Value.allValues.map({Card(.spade, $0)})
	static let allDiamonds: [Card] = Value.allValues.map({Card(.diamond, $0)})
	static let allHearts: [Card] = Value.allValues.map({Card(.heart, $0)})
	static let allClubs: [Card] = Value.allValues.map({Card(.club, $0)})
	
	static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
	
	static var cards: [Card] = allCards
	static var discards: [Card] = []
	static var outs: [Card] = []
	
	func draw() -> Card? {
		let drawCard = Deck.cards.removeFirst()
		Deck.outs.append(drawCard)
		return drawCard
	}
	
	func fold(c: Card) {
		if let index = Deck.outs.firstIndex(of: c) {
			Deck.discards.append(Deck.outs.remove(at: index))
		}
	}
	
	override var description: String { "(\(Deck.cards.description))" }
}

extension Array {
	mutating func randomTable() {
		for i in self.indices {
			let newIndex = Int(arc4random_uniform(UInt32(self.count - 1)))
			swapAt(newIndex, i)
		}
	}
}

let a = Deck()
let b = Deck()

print(Deck.cards.description)
a.draw()
//print(Deck.cards.description)

print(Deck.outs.description)
b.fold(c: Deck.outs[0])
print(Deck.discards.description)
print(Deck.outs.description)

//print(Deck.description)
//print(Deck.allCards.description)

