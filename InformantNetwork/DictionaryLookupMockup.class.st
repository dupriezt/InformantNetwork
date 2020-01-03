Class {
	#name : #DictionaryLookupMockup,
	#superclass : #Object,
	#instVars : [
		'succeedLookup'
	],
	#category : #InformantNetwork
}

{ #category : #'instance creation' }
DictionaryLookupMockup >> lookup: aKey [
	thisContext inspect.
	self halt.
	"Simulate the lookup"
	self succeedLookup ifFalse: [ "Simulate putting the key into the cache" ]
]

{ #category : #'instance creation' }
DictionaryLookupMockup >> succeedLookup [
	succeedLookup ifNil: [ succeedLookup := false ].
	^ succeedLookup
]
