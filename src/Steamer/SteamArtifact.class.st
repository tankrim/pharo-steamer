Class {
	#name : #SteamArtifact,
	#superclass : #Object,
	#instVars : [
		'discount',
		'id',
		'price',
		'timestamp',
		'title',
		'url'
	],
	#category : #Steamer
}

{ #category : #'instance creation' }
SteamArtifact class >> newWithId: aString [

	| steamData type className |
	steamData := SteamData newWithId: aString.
	type := steamData type.
	className := self class environment at: #Steam , type.

	^ className basicNew
		  id: steamData id;
		  title: steamData title;
		  price: steamData price;
		  discount: steamData discount;
		  url: 'https://store.steampowered.com/app/' , aString;
		  timestamp: steamData timestamp;
		  yourself
]

{ #category : #accessing }
SteamArtifact >> discount [

	^ discount
]

{ #category : #accessing }
SteamArtifact >> discount: anObject [

	discount := anObject
]

{ #category : #accessing }
SteamArtifact >> id [

	^ id
]

{ #category : #accessing }
SteamArtifact >> id: anObject [

	id := anObject
]

{ #category : #accessing }
SteamArtifact >> price [

	^ price
]

{ #category : #accessing }
SteamArtifact >> price: anObject [

	price := anObject
]

{ #category : #printing }
SteamArtifact >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' id: ';
		print: self id
]

{ #category : #accessing }
SteamArtifact >> timestamp [

	^ timestamp
]

{ #category : #accessing }
SteamArtifact >> timestamp: anObject [

	timestamp := anObject
]

{ #category : #accessing }
SteamArtifact >> title [

	^ title
]

{ #category : #accessing }
SteamArtifact >> title: anObject [

	title := anObject
]

{ #category : #updating }
SteamArtifact >> updateYourself [

	| steamData |
	steamData := SteamData newWithId: self id.
	self id: steamData id.
	self title: steamData title.
	self price: steamData price.
	self discount: steamData discount.
	self url: 'https://store.steampowered.com/app/' , self id.
	self timestamp: steamData timestamp.
	^ self
]

{ #category : #accessing }
SteamArtifact >> url [

	^ url
]

{ #category : #accessing }
SteamArtifact >> url: anObject [

	url := anObject
]
