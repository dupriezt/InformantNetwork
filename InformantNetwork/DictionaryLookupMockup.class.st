Class {
	#name : #DictionaryLookupMockup,
	#superclass : #Object,
	#instVars : [
		'succeedLookup',
		'testValue'
	],
	#category : #InformantNetwork
}

{ #category : #'as yet unclassified' }
DictionaryLookupMockup >> informantNoise [
	Informant report: 'Noise 1'.
	((Random new nextInt: 2)	= 1) ifTrue: [Informant report: 'Noise 2'].
	Informant report: 'Noise 3'.
	((Random new nextInt: 2)	= 1) ifTrue: [Informant report: 'Noise 4'].
]

{ #category : #'instance creation' }
DictionaryLookupMockup >> lookup: aKey [
	self testValue: 1.
	Informant report: 'Start Lookup'.
	"Simulate the lookup"
	self succeedLookup ifFalse: [ self testValue: 2. Informant report: 'Lookup Failed' "Simulate putting the key into the cache" ]
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
