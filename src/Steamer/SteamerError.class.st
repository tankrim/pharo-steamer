"
I am a common superclass for errors in Steamer operations.
"
Class {
	#name : #SteamerError,
	#superclass : #Error,
	#instVars : [
		'datum'
	],
	#category : #Steamer
}

{ #category : #'as yet unclassified' }
SteamerError class >> datum: anObject [

^ self basicNew initializeWithDatum: anObject 
]

{ #category : #'as yet unclassified' }
SteamerError class >> signalWith: anObject [

	^ (self datum: anObject) signal: anObject printString
]

{ #category : #initialization }
SteamerError >> datum [

	^ datum
]

{ #category : #initialization }
SteamerError >> initializeWithDatum: anObject [

datum := anObject
]

{ #category : #printing }
SteamerError >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' datum: ';
		print: datum
]
