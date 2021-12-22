Class {
	#name : #SteamData,
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
SteamData class >> baseUrl [

	BaseUrl ifNil: [ 
		BaseUrl := 'https://store.steampowered.com/api/appdetails?appids=' ].
	^ BaseUrl 
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

{ #category : #private }
SteamData >> fetchYourself [

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
	json isRecognizedSteamJson ifFalse: [ 
		self error: 'Unrecognized data' ].
	initial := (STON fromString: self json) at: self id.
	parsedJson := initial at: 'data'.
	data := parsedJson
]

{ #category : #initialization }
SteamData >> setId: aString [ 
	| steamId|
	steamId := SteamId newFromString: aString.
	steamId isWellFormed ifFalse: [ self error: 'Not a well-formed id: ', aString ].
	id := steamId identifier
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
