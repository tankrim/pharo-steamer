"
SteamerDatabase insertOrUpdateSteamArtifactsWithIds: #('10' '100').
SteamerDatabase deleteSteamArtifactsWithIds: #( '10' '100').

| vh |
Transcript clear.
SteamerDatabase databaseFileName: 'steamer.db'
  evaluate: [ :db |
    db session accessor logging: true. ""This shows the generated SQL.""
    vh := (db session read: SteamArtifact)].
vh

| vh |
Transcript clear.
SteamerDatabase databaseFileName: 'steamer.db'
  evaluate: [ :db |
    db session accessor logging: true. ""This shows the generated SQL.""
    db session inUnitOfWorkDo: [ db session register: (SteamArtifact newWithId: '260210') ].
    vh := (db session read: SteamArtifact)].
vh
"
Class {
	#name : #SteamerDatabase,
	#superclass : #Object,
	#instVars : [
		'databaseLogin',
		'databaseSession',
		'databaseFileName'
	],
	#category : #Steamer
}

{ #category : #api }
SteamerDatabase class >> createTableIfNeeded [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	[ 
	[ instance session createTables ]
		on: SQLite3Error
		do: [ :ex | ex return: nil ] ] ensure: [ instance closeSession ]
]

{ #category : #api }
SteamerDatabase class >> deleteAllSteamArtifacts [

	| instance artifacts ids |
	instance := self new.
	self prepareInstance: instance.
	artifacts := self selectAllSteamArtifacts.
	ids := artifacts collect: [ :each | each id ].
	^ self deleteSteamArtifactsWithIds: ids
]

{ #category : #api }
SteamerDatabase class >> deleteSteamArtifactWithId: anId [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	[ 
	instance session inUnitOfWorkDo: [ 
		| artifact |
		artifact := instance session
			            readOneOf: SteamArtifact
			            where: [ :each | each id = anId ].
		artifact ifNotNil: [ instance session delete: artifact ] ] ] 
		ensure: [ instance closeSession ]
]

{ #category : #api }
SteamerDatabase class >> deleteSteamArtifactsWithIds: aCollection [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	[ 
	instance session inUnitOfWorkDo: [ 
		aCollection do: [ :eachId | 
			| artifact |
			artifact := instance session
				            readOneOf: SteamArtifact
				            where: [ :each | each id = eachId ].
			artifact ifNotNil: [ instance session delete: artifact ] ] ] ] 
		ensure: [ instance closeSession ]
]

{ #category : #api }
SteamerDatabase class >> insertOrUpdateSteamArtifactWithId: anId [

self deleteSteamArtifactWithId: anId.
self insertSteamArtifactWithId: anId.
]

{ #category : #api }
SteamerDatabase class >> insertOrUpdateSteamArtifactsWithIds: aCollection [

aCollection do: [ :each |
	self deleteSteamArtifactWithId: each.
	self insertSteamArtifactWithId: each ]
]

{ #category : #private }
SteamerDatabase class >> insertSteamArtifactWithId: anId [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	^ [ 
	  instance session inUnitOfWorkDo: [ 
		  instance session register: (SteamArtifact newWithId: anId) ] ] 
		  ensure: [ instance closeSession ]
]

{ #category : #private }
SteamerDatabase class >> prepareInstance: instance [

	instance
		databaseFileName: instance defaultDatabaseFileName;
		initializeGlorp.
	instance session accessor logging: false
]

{ #category : #api }
SteamerDatabase class >> selectAllSteamArtifacts [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	^ [ 
	  instance session inUnitOfWorkDo: [
		instance session read: SteamArtifact. 
 ] ] ensure: [ 
		  instance closeSession ]
]

{ #category : #api }
SteamerDatabase class >> selectSteamArtifactWithId: anId [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	^ [ 
	  instance session inUnitOfWorkDo: [ 
		  instance session
			  readOneOf: SteamArtifact
			  where: [ :each | each id = anId ] ] ] ensure: [ 
		  instance closeSession ]
]

{ #category : #api }
SteamerDatabase class >> selectSteamArtifactsWithIds: aCollection [

	| instance |
	instance := self new.
	self prepareInstance: instance.
	^ [ 
	  instance session inUnitOfWorkDo: [ 
		  aCollection do: [ :eachId | 
			  instance session
				  read: SteamArtifact
				  where: [ :each | each id = eachId ] ] ] ] ensure: [ 
		  instance closeSession ]
]

{ #category : #api }
SteamerDatabase class >> updateAllSteamArtifacts [

	| instance artifacts ids |
	instance := self new.
	self prepareInstance: instance.
	artifacts := self selectAllSteamArtifacts.
	ids := artifacts collect: [ :each | each id].
	^ self insertOrUpdateSteamArtifactsWithIds: ids
]

{ #category : #private }
SteamerDatabase >> closeSession [

	databaseSession ifNotNil: [
		databaseSession logout.
		databaseSession := nil ]
]

{ #category : #private }
SteamerDatabase >> databaseFileName [

	^ databaseFileName
]

{ #category : #private }
SteamerDatabase >> databaseFileName: anObject [

	databaseFileName := anObject
]

{ #category : #private }
SteamerDatabase >> defaultDatabaseFileName [
^ 'steamer.db'
]

{ #category : #private }
SteamerDatabase >> initializeGlorp [
| accessor |
	PharoDatabaseAccessor DefaultDriver: SQLite3Driver.
	databaseLogin := Login new
		                 database: SQLite3Platform new;
		                 host:
			                 SmalltalkImage current imagePath asFileReference
				                 parent fullName
			                 , FileSystem disk delimiter asString;
		                 port: '';
		                 username: '';
		                 password: '';
		                 databaseName: self databaseFileName;
		                 yourself.
accessor := DatabaseAccessor forLogin: databaseLogin.
accessor login.
]

{ #category : #private }
SteamerDatabase >> openDatabaseSession [

	^ (SteamerDescriptorSystem sessionForLogin: databaseLogin)
			login;
			yourself
]

{ #category : #private }
SteamerDatabase >> session [
	^ databaseSession  ifNil: [ databaseSession  := self openDatabaseSession ] 
]
