Class {
	#name : #SteamJson,
	#superclass : #Object,
	#instVars : [
		'id',
		'json',
		'data'
	],
	#classVars : [
		'BaseUrl'
	],
	#category : #Steamer
}

{ #category : #accessing }
SteamJson class >> baseUrl [

	BaseUrl ifNil: [ 
		BaseUrl := 'https://store.steampowered.com/api/appdetails?appids=' ].
	^ BaseUrl 
]

{ #category : #'instance creation' }
SteamJson class >> newWithId: aString [

	^ self basicNew
		  setId: aString;
		  updateYourself;
		  yourself
]

{ #category : #accessing }
SteamJson >> data [
	^ data
]

{ #category : #'as yet unclassified' }
SteamJson >> fetchYourself [

	| fetchedJson |
	fetchedJson := ZnClient new
		               enforceAcceptContentType: true;
		               accept: ZnMimeType applicationJson;
		               get: self url.
	fetchedJson isWellFormedSteamJson ifFalse: [ 
		self error: 'Invalid Steam json' ].
	json := fetchedJson
]

{ #category : #accessing }
SteamJson >> id [
	^ id
]

{ #category : #accessing }
SteamJson >> json [

	^ json
]

{ #category : #'as yet unclassified' }
SteamJson >> parseYourself [

	| initial parsedJson |
	json isRecognizedSteamJson ifFalse: [ 
		self error: 'Unrecognized data' ].
	initial := (STON fromString: self json) at: self id.
	parsedJson := initial at: 'data'.
	data := parsedJson
]

{ #category : #initialization }
SteamJson >> setId: aString [ 
	| steamId|
	steamId := SteamId newFromString: aString.
	steamId isWellFormed ifFalse: [ self error: 'Not a well-formed id: ', aString ].
	id := steamId identifier
]

{ #category : #initialization }
SteamJson >> updateYourself [

	self fetchYourself.
	self parseYourself
]

{ #category : #'as yet unclassified' }
SteamJson >> url [
^ self class baseUrl, self id
]
