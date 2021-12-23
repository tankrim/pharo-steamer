Class {
	#name : #SteamData,
	#superclass : #Object,
	#instVars : [
		'id',
		'json',
		'data'
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
SteamData >> fetchYourself [

	| fetchedJson |
	fetchedJson := ZnClient new
		               enforceAcceptContentType: true;
		               accept: ZnMimeType applicationJson;
		               get: self url.
	fetchedJson isWellFormedSteamJson ifFalse: [ MalformedSteamJson signalWith: fetchedJson ].
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
	json isRecognizedSteamJson ifFalse: [ UnrecognizedSteamId signalWith: self id].
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

{ #category : #initialization }
SteamData >> updateYourself [

	self fetchYourself.
	self parseYourself
]

{ #category : #private }
SteamData >> url [
^ self class baseUrl, self id
]
