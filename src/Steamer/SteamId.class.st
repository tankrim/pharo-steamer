Class {
	#name : #SteamId,
	#superclass : #Object,
	#instVars : [
		'identifier'
	],
	#category : #Steamer
}

{ #category : #'instance creation' }
SteamId class >> newFromString: aString [

	^ self basicNew
		  setIdentifier: aString;
		  yourself
]

{ #category : #accessing }
SteamId >> identifier [
	^ identifier
]

{ #category : #testing }
SteamId >> isWellFormed [

	identifier isString ifFalse: [ ^ false ].
	^ identifier isWellFormedSteamId
]

{ #category : #initialization }
SteamId >> setIdentifier: aString [ 
	identifier := aString.
]
