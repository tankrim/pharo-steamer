Class {
	#name : #SteamerInteractionServer,
	#superclass : #Object,
	#instVars : [
		'connectionSocket',
		'isRunning',
		'isRunningLock'
	],
	#category : #Steamer
}

{ #category : #private }
SteamerInteractionServer >> errorResponse: anError [

	^ 'NOTOK ', anError printString , String lf
]

{ #category : #private }
SteamerInteractionServer >> handleError: anError [

	self log: '[Steamer] ' with: anError.
	(anError isKindOf: SteamerError)
		ifTrue: [ anError return: nil ]
		ifFalse: [ anError pass ]
]

{ #category : #initialization }
SteamerInteractionServer >> initialize [
super initialize.
isRunningLock := Mutex new.
self isRunning: false
]

{ #category : #private }
SteamerInteractionServer >> interactOnConnection [
| interactionSocket |
interactionSocket := connectionSocket waitForAcceptFor: 1 ifTimedOut: [^self].
[self interactUsing: interactionSocket] fork
]

{ #category : #private }
SteamerInteractionServer >> interactUsing: interactionSocket [

	| receivedData response |
	[ 
	receivedData := interactionSocket receiveDataTimeout: 5.
	[ response := self processMessage: receivedData trimmed ]
		on: Error
		do: [ :ex | 
			response := self errorResponse: ex.
			self handleError: ex ].
	interactionSocket sendData: response ] ensure: [ 
		interactionSocket closeAndDestroy ]
]

{ #category : #private }
SteamerInteractionServer >> isRunning [
^ isRunningLock critical: [ isRunning ]
]

{ #category : #private }
SteamerInteractionServer >> isRunning: aBoolean [
isRunningLock critical: [ isRunning := aBoolean ]
]

{ #category : #private }
SteamerInteractionServer >> log: aString [

	TranscriptLogger new runDuring: [ 
		StringSignal emit: aString ].

]

{ #category : #private }
SteamerInteractionServer >> log: aString with: anObject [

	TranscriptLogger new runDuring: [ StringSignal emit: aString, anObject printString  ]
]

{ #category : #private }
SteamerInteractionServer >> notOkResponse [

	^ 'NOTOK' , String lf
]

{ #category : #private }
SteamerInteractionServer >> okResponse [

^ 'OK' ,String lf.
]

{ #category : #private }
SteamerInteractionServer >> processAdd: aString [

	| id instruction |
	instruction := aString splitOn: Character space.
	id := instruction at: 2.
	[ 
	SteamerDatabase uniqueInstance insertOrUpdateSteamArtifactWithId: id ] 
		ensure: [ 
			self log: '[Steamer] Processed: ' with: aString ].
	^ self okResponse
]

{ #category : #private }
SteamerInteractionServer >> processDelete: aString [

	| id instruction |
	instruction := aString splitOn: Character space.
	id := instruction at: 2.
	[ SteamerDatabase uniqueInstance deleteSteamArtifactWithId: id ] 
		ensure: [ 
			self log: '[Steamer] Processed: ' with: aString ].
	^ self okResponse
]

{ #category : #private }
SteamerInteractionServer >> processMessage: aString [

	self log: '[Steamer] Processing: ' with: aString.

	(aString matchesRegex: '^add .+') ifTrue: [ 
		^ self processAdd: aString ].

	(aString matchesRegex: '^delete .+') ifTrue: [ 
		^ self processDelete: aString ].

	(aString matchesRegex: '^quit') ifTrue: [ 
		^ self processQuit: aString ].

	(aString matchesRegex: '^updateAll') ifTrue: [ 
		^ self processUpdateAll: aString ].
	^ self notOkResponse
]

{ #category : #private }
SteamerInteractionServer >> processQuit: aString [

	[ self stop ] ensure: [ 
		self log: '[Steamer] Processed: ' with: aString ].
	^ self okResponse
]

{ #category : #private }
SteamerInteractionServer >> processUpdateAll: aString [

	[ SteamerDatabase uniqueInstance updateAllSteamArtifacts ] ensure: [ 
			self log: '[Steamer] Processed: ' with: aString].
	^ self okResponse
]

{ #category : #private }
SteamerInteractionServer >> serve [
[ [ self isRunning ]
whileTrue: [ self interactOnConnection ] ]
ensure: [ connectionSocket closeAndDestroy ]
]

{ #category : #api }
SteamerInteractionServer >> start [

	isRunningLock critical: [ 
		self isRunning ifTrue: [ ^ self ].
		self isRunning: true ].
	connectionSocket := Socket newTCP.
	connectionSocket listenOn: 9999 backlogSize: 10.
	[ self serve ] fork.
	SteamerDatabase uniqueInstance createTableIfNeeded.
	self log:
			'[Steamer] InteractionServer listening on port 9999'
]

{ #category : #api }
SteamerInteractionServer >> stop [

	self isRunning: false.
	self log: '[Steamer] InteractionServer is no longer listening'
]
