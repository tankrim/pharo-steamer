Class {
	#name : #SteamData,
	#superclass : #Object,
	#instVars : [
		'id',
		'data',
		'json',
		'timestamp'
	],
	#category : #Steamer
}

{ #category : #accessing }
SteamData class >> baseUrl [

^ 'https://store.steampowered.com/api/appdetails?appids='
]

{ #category : #'instance creation' }
SteamData class >> newWithId: aString [

	^ self basicNew
		  setId: aString;
		  updateYourself;
		  yourself
]

{ #category : #accessing }
SteamData >> data [
	^ data
]

{ #category : #accessing }
SteamData >> discount [

	^ self priceData at: 'discount_percent'
]

{ #category : #private }
SteamData >> fetchJson [

	^ ZnClient new
		  enforceAcceptContentType: true;
		  accept: ZnMimeType applicationJson;
		  get: self url
]

{ #category : #private }
SteamData >> fetchYourself [

	| fetchedJson |
	fetchedJson := self fetchJson .
	fetchedJson isWellFormedSteamJson ifFalse: [ 
		MalformedSteamJson signalWith: fetchedJson ].
	fetchedJson isRecognizedSteamJson ifFalse: [ 
		UnrecognizedSteamId signalWith: self id ].
	json := fetchedJson
]

{ #category : #accessing }
SteamData >> id [
	^ id
]

{ #category : #accessing }
SteamData >> json [

	^ json
]

{ #category : #private }
SteamData >> parseYourself [

	| initial parsedJson |
	initial := (STON fromString: self json) at: self id.
	parsedJson := initial at: 'data'.
	data := parsedJson
]

{ #category : #accessing }
SteamData >> price [

	^ self priceData at: 'final'
]

{ #category : #accessing }
SteamData >> priceData [

	^ data at: 'price_overview' ifAbsent: (Dictionary newFrom:
			   { 'initial'->0. 'currency'->nil. 'discount_percent'->0. 'final'->0 })
]

{ #category : #initialization }
SteamData >> setId: aString [

	| steamId |
	steamId := SteamId newFromString: aString.
	steamId isWellFormed ifFalse: [ MalformedSteamId signalWith: aString ].
	id := steamId identifier
]

{ #category : #accessing }
SteamData >> timestamp [

	^ timestamp
]

{ #category : #accessing }
SteamData >> timestamp: anObject [

	timestamp := anObject
]

{ #category : #accessing }
SteamData >> title [
^ data at: 'name'
]

{ #category : #accessing }
SteamData >> type [

	| typeTable |
	typeTable := Dictionary newFrom: { 
			             ('advertising' -> #Ad).
			             ('demo' -> #Demo).
			             ('dlc' -> #Dlc).
			             ('game' -> #Game).
			             ('mod' -> #Mod).
			             ('movie' -> #Movie) }.
	^ typeTable at: (self data at: 'type')
]

{ #category : #updating }
SteamData >> updateYourself [

	self fetchYourself.
	self parseYourself.
	self timestamp: DateAndTime now
]

{ #category : #private }
SteamData >> url [
^ self class baseUrl, self id
]
