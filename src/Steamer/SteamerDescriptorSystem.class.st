"
""connection := SQLite3Connection on: (Smalltalk imageDirectory / 'steamer.db') fullName.
connection close.""
""PharoDatabaseAccessor DefaultDriver: SQLite3Driver.""
""""
session logout.
accessor logout.
Transcript clear.
""""
login := Login new
database: SQLite3Platform new;
host: 'localhost';
databaseName: (Smalltalk imageDirectory / 'steamer.db') fullName.
""""
accessor := DatabaseAccessor forLogin: login.
accessor login.
""""
session := SteamerDescriptorSystem sessionForLogin: login.
session login.
session accessor logging: true.
""""
""session createTables.	""
""""
session inUnitOfWorkDo: [
{
SteamArtifact newWithId: '1920'.
SteamArtifact newWithId: '2510'.
SteamArtifact newWithId: '1237830'.
SteamArtifact newWithId: '24010'.
SteamArtifact newWithId: '1230'.
SteamArtifact newWithId: '919'.
} do: [ :each | session register: each ]
].
(session read: SteamArtifact).
Transcript clear.
"
Class {
	#name : #SteamerDescriptorSystem,
	#superclass : #DescriptorSystem,
	#category : #Steamer
}

{ #category : #initialization }
SteamerDescriptorSystem >> classModelForSteamAd: aClassModel [

	aClassModel newAttributeNamed: #discount.
	aClassModel newAttributeNamed: #price.
	aClassModel newAttributeNamed: #currency.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #url.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #initialization }
SteamerDescriptorSystem >> classModelForSteamDemo: aClassModel [

	aClassModel newAttributeNamed: #discount.
	aClassModel newAttributeNamed: #price.
	aClassModel newAttributeNamed: #currency.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #url.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #initialization }
SteamerDescriptorSystem >> classModelForSteamDlc: aClassModel [

	aClassModel newAttributeNamed: #discount.
	aClassModel newAttributeNamed: #price.
	aClassModel newAttributeNamed: #currency.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #url.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #initialization }
SteamerDescriptorSystem >> classModelForSteamGame: aClassModel [

	aClassModel newAttributeNamed: #discount.
	aClassModel newAttributeNamed: #price.
	aClassModel newAttributeNamed: #currency.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #url.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #initialization }
SteamerDescriptorSystem >> classModelForSteamMod: aClassModel [

	aClassModel newAttributeNamed: #discount.
	aClassModel newAttributeNamed: #price.
	aClassModel newAttributeNamed: #currency.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #url.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #initialization }
SteamerDescriptorSystem >> classModelForSteamMovie: aClassModel [

	aClassModel newAttributeNamed: #discount.
	aClassModel newAttributeNamed: #price.
	aClassModel newAttributeNamed: #currency.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #url.
	aClassModel newAttributeNamed: #title.
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #initialization }
SteamerDescriptorSystem >> constructAllClasses [

	^ super constructAllClasses
		  add: SteamArtifact;
		  add: SteamAd;
		  add: SteamDemo;
		  add: SteamDlc;
		  add: SteamGame;
		  add: SteamMod;
		  add: SteamMovie;
		  yourself
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamAd: aDescriptor [

	| gameTable |
	gameTable := self tableNamed: 'ALL_DATA'.
	aDescriptor table: gameTable.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (gameTable fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #currency
		to: (gameTable fieldNamed: 'currency').
	(aDescriptor newMapping: DirectMapping)
		from: #discount
		to: (gameTable fieldNamed: 'discount').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (gameTable fieldNamed: 'price').
	(aDescriptor newMapping: DirectMapping)
		from: #title
		to: (gameTable fieldNamed: 'title').
	(aDescriptor newMapping: DirectMapping)
		from: #url
		to: (gameTable fieldNamed: 'url').
	(aDescriptor newMapping: DirectMapping)
		from: #timestamp
		to: (gameTable fieldNamed: 'timestamp').
	(self typeResolverFor: SteamArtifact)
		register: aDescriptor
		keyedBy: 'ADV'
		field: (gameTable fieldNamed: 'object_type')
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamArtifact: aDescriptor [

	| table |
	table := self tableNamed: 'ALL_DATA'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #currency
		to: (table fieldNamed: 'currency').
	(aDescriptor newMapping: DirectMapping)
		from: #discount
		to: (table fieldNamed: 'discount').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (table fieldNamed: 'price').
	(aDescriptor newMapping: DirectMapping)
		from: #title
		to: (table fieldNamed: 'title').
	(aDescriptor newMapping: DirectMapping)
		from: #url
		to: (table fieldNamed: 'url').
	(aDescriptor newMapping: DirectMapping)
		from: #timestamp
		to: (table fieldNamed: 'timestamp').
	(self typeResolverFor: SteamArtifact)
		register: aDescriptor
		abstract: true
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamDemo: aDescriptor [

	| gameTable |
	gameTable := self tableNamed: 'ALL_DATA'.
	aDescriptor table: gameTable.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (gameTable fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #currency
		to: (gameTable fieldNamed: 'currency').
	(aDescriptor newMapping: DirectMapping)
		from: #discount
		to: (gameTable fieldNamed: 'discount').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (gameTable fieldNamed: 'price').
	(aDescriptor newMapping: DirectMapping)
		from: #title
		to: (gameTable fieldNamed: 'title').
	(aDescriptor newMapping: DirectMapping)
		from: #url
		to: (gameTable fieldNamed: 'url').
	(aDescriptor newMapping: DirectMapping)
		from: #timestamp
		to: (gameTable fieldNamed: 'timestamp').
	(self typeResolverFor: SteamArtifact)
		register: aDescriptor
		keyedBy: 'DEM'
		field: (gameTable fieldNamed: 'object_type')
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamDlc: aDescriptor [

	| gameTable |
	gameTable := self tableNamed: 'ALL_DATA'.
	aDescriptor table: gameTable.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (gameTable fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #currency
		to: (gameTable fieldNamed: 'currency').
	(aDescriptor newMapping: DirectMapping)
		from: #discount
		to: (gameTable fieldNamed: 'discount').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (gameTable fieldNamed: 'price').
	(aDescriptor newMapping: DirectMapping)
		from: #title
		to: (gameTable fieldNamed: 'title').
	(aDescriptor newMapping: DirectMapping)
		from: #url
		to: (gameTable fieldNamed: 'url').
	(aDescriptor newMapping: DirectMapping)
		from: #timestamp
		to: (gameTable fieldNamed: 'timestamp').
	(self typeResolverFor: SteamArtifact)
		register: aDescriptor
		keyedBy: 'DLC'
		field: (gameTable fieldNamed: 'object_type')
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamGame: aDescriptor [ 
   | gameTable |
   gameTable := self tableNamed: 'ALL_DATA'.
   aDescriptor table: gameTable.
   (aDescriptor newMapping: DirectMapping) from: #id
      to: (gameTable fieldNamed: 'id').
   (aDescriptor newMapping: DirectMapping) from: #currency
      to: (gameTable fieldNamed: 'currency').
   (aDescriptor newMapping: DirectMapping) from: #discount
      to: (gameTable fieldNamed: 'discount').
   (aDescriptor newMapping: DirectMapping) from: #price
      to: (gameTable fieldNamed: 'price').
   (aDescriptor newMapping: DirectMapping) from: #title
      to: (gameTable fieldNamed: 'title').
   (aDescriptor newMapping: DirectMapping) from: #url
      to: (gameTable fieldNamed: 'url').
   (aDescriptor newMapping: DirectMapping) from: #timestamp
      to: (gameTable fieldNamed: 'timestamp').
   (self typeResolverFor: SteamArtifact ) register: aDescriptor keyedBy: 'GAM' field: (gameTable fieldNamed: 'object_type').
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamMod: aDescriptor [

	| gameTable |
	gameTable := self tableNamed: 'ALL_DATA'.
	aDescriptor table: gameTable.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (gameTable fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #currency
		to: (gameTable fieldNamed: 'currency').
	(aDescriptor newMapping: DirectMapping)
		from: #discount
		to: (gameTable fieldNamed: 'discount').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (gameTable fieldNamed: 'price').
	(aDescriptor newMapping: DirectMapping)
		from: #title
		to: (gameTable fieldNamed: 'title').
	(aDescriptor newMapping: DirectMapping)
		from: #url
		to: (gameTable fieldNamed: 'url').
	(aDescriptor newMapping: DirectMapping)
		from: #timestamp
		to: (gameTable fieldNamed: 'timestamp').
	(self typeResolverFor: SteamArtifact)
		register: aDescriptor
		keyedBy: 'MOD'
		field: (gameTable fieldNamed: 'object_type')
]

{ #category : #initialization }
SteamerDescriptorSystem >> descriptorForSteamMovie: aDescriptor [

	| gameTable |
	gameTable := self tableNamed: 'ALL_DATA'.
	aDescriptor table: gameTable.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (gameTable fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #currency
		to: (gameTable fieldNamed: 'currency').
	(aDescriptor newMapping: DirectMapping)
		from: #discount
		to: (gameTable fieldNamed: 'discount').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (gameTable fieldNamed: 'price').
	(aDescriptor newMapping: DirectMapping)
		from: #title
		to: (gameTable fieldNamed: 'title').
	(aDescriptor newMapping: DirectMapping)
		from: #url
		to: (gameTable fieldNamed: 'url').
	(aDescriptor newMapping: DirectMapping)
		from: #timestamp
		to: (gameTable fieldNamed: 'timestamp').
	(self typeResolverFor: SteamArtifact)
		register: aDescriptor
		keyedBy: 'MOV'
		field: (gameTable fieldNamed: 'object_type')
]

{ #category : #initialization }
SteamerDescriptorSystem >> tableForALL_DATA: aTable [

	aTable createFieldNamed: 'title' type: (platform varChar: 300).
	aTable createFieldNamed: 'currency' type: (platform varChar: 3).
	aTable createFieldNamed: 'url' type: (platform varChar: 100).
	aTable createFieldNamed: 'discount' type: platform integer.
	aTable createFieldNamed: 'price' type: platform integer.
	aTable createFieldNamed: 'timestamp' type: platform timestamp.
	aTable createFieldNamed: 'object_type' type: (platform varChar: 10).
		(aTable createFieldNamed: 'id' type: (platform varChar: 50))
		bePrimaryKey
]

{ #category : #initialization }
SteamerDescriptorSystem >> typeResolverForSteamArtifact [
   ^FilteredTypeResolver forRootClass: SteamArtifact . 
]
