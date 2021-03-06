"
I am data on one piece of software from Steam.

In particular I know which type of Steam software I represent; its title; its currency (if any); its price (if any); and its discount (if any). I also know when I was successfully created.

I know how to update myself.

I collaborate with `String` in determining the well-formedness of my json.

I collaborate with `SteamId` in determining the well-formedness of the id with which I am created.

If the id with which I am created is not well formed the error exception `MalformedSteamId` is signaled.

If the json I fetch from Steam is not well formed the error exception `MalformedSteamJson` is signaled.

If Steam has no knowledge of a piece of software with my id the error exception `UnrecognizedSteamId` is signaled.

To create an instance of me, do:

```
SteamData newWithId: '10'.
```

Example:

```
| sd |
sd := SteamData newWithId: '10'.
sd type. ""#Game""
sd title. ""'Counter-Strike'""
sd currency. ""'EUR'""
sd price. ""163""
sd discount. ""80""
sd timestamp. ""2021-12-28T17:55:59.840719+01:00""
sd updateYourself. ""The same object with fresh data.""
```

Internal Representation and Key Implementation Points.

    Instance Variables
	id:		<SteamId>
	data: <Dictionary>
	json: <String>
	timestamp: <DateAndTime>
"
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
		  initializeFromSteam;
		  yourself
]

{ #category : #accessing }
SteamData >> currency [

	^ self priceData at: 'currency'
]

{ #category : #accessing }
SteamData >> data [
	^ data
]

{ #category : #accessing }
SteamData >> discount [

	^ self priceData at: 'discount_percent'
]

{ #category : #fetching }
SteamData >> fetchJson [

	json := ZnClient new
		  enforceAcceptContentType: true;
		  accept: ZnMimeType applicationJson;
		  get: self url
]

{ #category : #testing }
SteamData >> hasRecognizedJson [

	json isString ifFalse: [ ^ false ].
	^ json isRecognizedSteamJson 
]

{ #category : #testing }
SteamData >> hasWellFormedId [

	id isString ifFalse: [ ^ false ].
	^ id isWellFormedSteamId 
]

{ #category : #testing }
SteamData >> hasWellFormedJson [

	json isString ifFalse: [ ^ false ].
	^ json isWellFormedSteamJson 
]

{ #category : #accessing }
SteamData >> id [
	^ id
]

{ #category : #initialization }
SteamData >> initializeFromSteam [

	self hasWellFormedId ifFalse: [ MalformedSteamId signalWith: self id ].
	self fetchJson.

	self hasWellFormedJson ifFalse: [ 
		MalformedSteamJson signalWith: self json ].
	self hasRecognizedJson ifFalse: [ 
		UnrecognizedSteamId signalWith: self id ].

	self parseJson.
	self timestamp: DateAndTime now
]

{ #category : #accessing }
SteamData >> json [

	^ json
]

{ #category : #parsing }
SteamData >> parseJson [

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

	^ data at: 'price_overview' ifAbsent: (Dictionary newFrom: { 
				   ('initial' -> 0).
				   ('currency' -> '').
				   ('discount_percent' -> 0).
				   ('final' -> 0) })
]

{ #category : #initialization }
SteamData >> reInitializeFromSteam [

	self initializeFromSteam 
]

{ #category : #initialization }
SteamData >> setId: aString [

	| steamId |
	steamId := SteamId newFromString: aString.
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

{ #category : #private }
SteamData >> url [
^ self class baseUrl, self id
]
