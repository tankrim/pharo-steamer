"
I am a common superclass for objects representing pieces of software avaiable on Steam.

My subclasses represent different types of such software.

I know my id, title, currency (if any), price (if any), discount (if any), and the url at which I can be looked up on Steam; and I know when that data was created.

I also know how to update myself.

Instances of me can be compared; at the moment two instances of me are considered equal if they have the same id.

I collaborate with `SteamData` in creation and updating of myself. 

To create an instance of me, do:

`SteamArtifact newWithId: '10'.`

Example:
```
| sa |
sa := SteamArtifact newWithId: '10'.
sa id. ""'10'""
sa title. ""'Counter-Strike'"" 
sa currency. ""'EUR'""
sa price. ""163""
sa discount. ""80""
sa timestamp. ""2021-12-28T18:49:23.261663+01:00"".
sa url.  ""'https://store.steampowered.com/app/10'""
sa updateYourself. ""The same object with fresh data.""
```

Internal Representation and Key Implementation Points.

    Instance Variables
	discount:		<Integer>
	id:		<String>
	currency:	<String>
	price:		<Integer>
	timestamp:		<DateAndTime>
	title:		<String>
	url:		<String>
"
Class {
	#name : #SteamArtifact,
	#superclass : #Object,
	#instVars : [
		'currency',
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
	     currency: steamData currency;
		  discount: steamData discount;
		  id: steamData id;
		  price: steamData price;
		  timestamp: steamData timestamp;
		  title: steamData title;
		  url: 'https://store.steampowered.com/app/' , aString;
		  yourself
]

{ #category : #comparing }
SteamArtifact >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ id = anObject id
]

{ #category : #accessing }
SteamArtifact >> currency [

	^ currency
]

{ #category : #accessing }
SteamArtifact >> currency: anObject [

	currency := anObject
]

{ #category : #accessing }
SteamArtifact >> discount [

	^ discount
]

{ #category : #accessing }
SteamArtifact >> discount: anObject [

	discount := anObject
]

{ #category : #displaying }
SteamArtifact >> displayPrice [

	| priceForDisplay |
	priceForDisplay := (self price / 100) asFloat printString.
	self currency
		ifNotEmpty: [ ^ self currency , ' ' , priceForDisplay ]
		ifEmpty: [  ^priceForDisplay ]
]

{ #category : #comparing }
SteamArtifact >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ id hash
]

{ #category : #accessing }
SteamArtifact >> id [

	^ id
]

{ #category : #accessing }
SteamArtifact >> id: anObject [

	id := anObject
]

{ #category : #initialization }
SteamArtifact >> initializeFromSteam [

	| steamData |
	steamData := SteamData newWithId: self id.
	self currency: steamData currency.
	self discount: steamData discount.
	self id: steamData id.
	self timestamp: steamData timestamp.
	self title: steamData title.
	self price: steamData price.
	self url: 'https://store.steampowered.com/app/' , self id.
	^ self
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

{ #category : #initialization }
SteamArtifact >> reInitializeFromSteam [

self initializeFromSteam 
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

{ #category : #accessing }
SteamArtifact >> url [

	^ url
]

{ #category : #accessing }
SteamArtifact >> url: anObject [

	url := anObject
]
