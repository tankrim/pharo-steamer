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
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #Steamer
}

{ #category : #'initialize-release' }
SteamerDatabase class >> new [

	self error: 'SteamerDatabase is a singleton -- send uniqueInstance instead'
]

{ #category : #private }
SteamerDatabase class >> prepareInstance: instance [

	instance
		databaseFileName: instance defaultDatabaseFileName;
		initializeGlorp.
	instance session accessor logging: false
]

{ #category : #'initialize-release' }
SteamerDatabase class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := super new. self prepareInstance: uniqueInstance  ]
]

{ #category : #private }
SteamerDatabase >> closeSession [

	databaseSession ifNotNil: [
		databaseSession logout.
		databaseSession := nil ]
]

{ #category : #api }
SteamerDatabase >> createTableIfNeeded [

	[ 
	[ self session createTables ]
		on: SQLite3Error
		do: [ :ex | ex return: nil ] ] ensure: [ self closeSession ]
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

{ #category : #api }
SteamerDatabase >> deleteAllSteamArtifacts [

	|artifacts ids |
	artifacts := self selectAllSteamArtifacts.
	ids := artifacts collect: [ :each | each id ].
	^ self deleteSteamArtifactsWithIds: ids
]

{ #category : #api }
SteamerDatabase >> deleteSteamArtifactWithId: anId [

	[ 
	self session inUnitOfWorkDo: [ 
		| artifact |
		artifact := self session
			            readOneOf: SteamArtifact
			            where: [ :each | each id = anId ].
		artifact ifNotNil: [ self session delete: artifact ] ] ] 
		ensure: [ self closeSession ]
]

{ #category : #api }
SteamerDatabase >> deleteSteamArtifactsWithIds: aCollection [

	[ 
	self session inUnitOfWorkDo: [ 
		aCollection do: [ :eachId | 
			| artifact |
			artifact := self session
				            readOneOf: SteamArtifact
				            where: [ :each | each id = eachId ].
			artifact ifNotNil: [ self session delete: artifact ] ] ] ] 
		ensure: [ self closeSession ]
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

{ #category : #api }
SteamerDatabase >> insertOrUpdateSteamArtifactWithId: anId [

self deleteSteamArtifactWithId: anId.
self insertSteamArtifactWithId: anId.
]

{ #category : #api }
SteamerDatabase >> insertOrUpdateSteamArtifactsWithIds: aCollection [

	^ aCollection do: [ :each | 
		self deleteSteamArtifactWithId: each.
		self insertSteamArtifactWithId: each ]
]

{ #category : #private }
SteamerDatabase >> insertSteamArtifactWithId: anId [


	^ [ 
	  self session inUnitOfWorkDo: [ 
		  self session register: (SteamArtifact newWithId: anId) ] ] 
		  ensure: [ self closeSession ]
]

{ #category : #private }
SteamerDatabase >> openDatabaseSession [

	^ (SteamerDescriptorSystem sessionForLogin: databaseLogin)
			login;
			yourself
]

{ #category : #api }
SteamerDatabase >> selectAllSteamArtifacts [


	^ [ 
	  self session inUnitOfWorkDo: [ 
		  self session read: SteamArtifact ] ] ensure: [ 
		  self closeSession ]
]

{ #category : #api }
SteamerDatabase >> selectSteamArtifactWithId: anId [


	^ [ 
	  self session inUnitOfWorkDo: [ 
		  self session
			  readOneOf: SteamArtifact
			  where: [ :each | each id = anId ] ] ] ensure: [ 
		  self closeSession ]
]

{ #category : #api }
SteamerDatabase >> selectSteamArtifactsWithIds: aCollection [

	^ [ 
	  self session inUnitOfWorkDo: [ 
		  aCollection do: [ :eachId | 
			  self session
				  read: SteamArtifact
				  where: [ :each | each id = eachId ] ] ] ] ensure: [ 
		  self closeSession ]
]

{ #category : #private }
SteamerDatabase >> session [
	^ databaseSession  ifNil: [ databaseSession  := self openDatabaseSession ] 
]

{ #category : #api }
SteamerDatabase >> updateAllSteamArtifacts [

	|  artifacts ids |
	artifacts := self selectAllSteamArtifacts.
	ids := artifacts collect: [ :each | each id ].
	^ self insertOrUpdateSteamArtifactsWithIds: ids
]
