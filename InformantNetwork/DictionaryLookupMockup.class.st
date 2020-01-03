Class {
	#name : #DictionaryLookupMockup,
	#superclass : #Object,
	#instVars : [
		'succeedLookup',
		'testValue'
	],
	#category : #InformantNetwork
}

{ #category : #'instance creation' }
DictionaryLookupMockup >> lookup: aKey [
	self testValue: 1.
	Informant inform: 'Start Lookup'.
	"Simulate the lookup"
	self succeedLookup ifFalse: [ self testValue: 2. Informant inform: 'Lookup Failed' "Simulate putting the key into the cache" ]
]

{ #category : #'instance creation' }
DictionaryLookupMockup >> succeedLookup [
	succeedLookup ifNil: [ succeedLookup := false ].
	^ succeedLookup
]

{ #category : #'instance creation' }
DictionaryLookupMockup >> succeedLookup: aValue [
	succeedLookup := aValue
]

{ #category : #'instance creation' }
DictionaryLookupMockup >> testValue [
	^ testValue
]

{ #category : #'instance creation' }
DictionaryLookupMockup >> testValue: aValue [
	testValue := aValue
]
