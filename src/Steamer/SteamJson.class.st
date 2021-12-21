Class {
	#name : #SteamJson,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #Steamer
}

{ #category : #'instance creation' }
SteamJson class >> newWithId: aString [ 
	^ self basicNew setId: aString;yourself
]

{ #category : #initialization }
SteamJson >> setId: aString [ 
	| steamId|
	steamId := SteamId newFromString: aString.
	steamId isWellFormed ifFalse: [ self error: 'Not a well-formed id: ', aString ].
	id := steamId identifier
]
