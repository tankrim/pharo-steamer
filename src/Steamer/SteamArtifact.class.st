Class {
	#name : #SteamArtifact,
	#superclass : #Object,
	#instVars : [
		'steamData'
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
		  setSteamData: steamData;
		  yourself
]

{ #category : #accessing }
SteamArtifact >> id [

	^ steamData id
]

{ #category : #printing }
SteamArtifact >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' id: ';
		print: self id
]

{ #category : #initialization }
SteamArtifact >> setSteamData: aSteamData [ 
	steamData := aSteamData .
]

{ #category : #accessing }
SteamArtifact >> title [

	^ steamData data at: 'name'
]
