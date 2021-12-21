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

{ #category : #initialization }
SteamId >> setIdentifier: aString [ 
	identifier := aString.
]
