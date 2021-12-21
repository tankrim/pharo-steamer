Class {
	#name : #SteamJson,
	#superclass : #Object,
	#instVars : [
		'id',
		'json'
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
	^ self basicNew setId: aString;yourself
]

{ #category : #accessing }
SteamJson >> id [
	^ id
]

{ #category : #initialization }
SteamJson >> setId: aString [ 
	| steamId|
	steamId := SteamId newFromString: aString.
	steamId isWellFormed ifFalse: [ self error: 'Not a well-formed id: ', aString ].
	id := steamId identifier
]

{ #category : #'as yet unclassified' }
SteamJson >> url [
^ self class baseUrl, self id
]
