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

	^ anError printString, String lf
]

{ #category : #private }
SteamerInteractionServer >> handleError: anError [

TranscriptLogger new runDuring: [ 
				StringSignal emit: '[Steamer] ' , anError displayString ].
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
	response := self okResponse.
	receivedData := interactionSocket receiveDataTimeout: 5.
	[ self processMessage: receivedData ]
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
SteamerInteractionServer >> okResponse [

^ 'OK' ,String lf.
]

{ #category : #private }
SteamerInteractionServer >> processMessage: aString [

	TranscriptLogger new runDuring: [ 
		StringSignal emit: '[Steamer] Processing: ' , aString ].

	(aString matchesRegex: 'add .+') ifTrue: [ 
		| instruction id |
		instruction := aString splitOn: Character space.
		id := instruction at: 2.
		^ [SteamerDatabase insertOrUpdateSteamArtifactWithId: id] ensure: [ 	TranscriptLogger new runDuring: [ 
		StringSignal emit:
			'[Steamer] Processed: ', aString ] ] ].

	(aString matchesRegex: 'delete .+') ifTrue: [ 
		| instruction id |
		instruction := aString splitOn: Character space.
		id := instruction at: 2.
		^ SteamerDatabase deleteSteamArtifactWithId: id ].

	(aString matchesRegex: 'updateAll') ifTrue: [ 
		SteamerDatabase selectAllSteamArtifacts.
		^ SteamerDatabase updateAllSteamArtifacts ]
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
SteamerDatabase createTableIfNeeded.
	TranscriptLogger new runDuring: [ 
		StringSignal emit:
			'[Steamer] InteractionServer listening on port 9999' ]
]

{ #category : #api }
SteamerInteractionServer >> stop [

	self isRunning: false.
	TranscriptLogger new runDuring: [ 
		StringSignal emit:
			'[Steamer] InteractionServer is no longer listening' ]
]
