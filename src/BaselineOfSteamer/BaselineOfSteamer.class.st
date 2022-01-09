Class {
	#name : #BaselineOfSteamer,
	#superclass : #BaselineOf,
	#category : #BaselineOfSteamer
}

{ #category : #baselines }
BaselineOfSteamer >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		self setUpDependencies: spec.
		spec
			package: 'Steamer';
			package: 'Steamer-Tests' with: [ spec requires: #( 'Steamer' ) ] ]
]

{ #category : #baselines }
BaselineOfSteamer >> setUpDependencies:  spec [

	spec
		baseline: 'SQLite3'
		with: [ 
		spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src'; loads: #('SQLite3-Glorp') ]
]
