Class {
	#name : #InformationRecord,
	#superclass : #Object,
	#instVars : [
		'informantName',
		'informationName',
		'information',
		'informationCollectedSuccessfully',
		'index'
	],
	#classVars : [
		'currentIndex'
	],
	#category : #InformantNetwork
}

{ #category : #'instance creation' }
InformationRecord class >> currentIndex [
	currentIndex ifNil: [ currentIndex := 0 ].
	^ currentIndex
]

{ #category : #'instance creation' }
InformationRecord class >> currentIndex: anInt [
	currentIndex := anInt
]

{ #category : #'instance creation' }
InformationRecord class >> getFreshIndex [
	self currentIndex: self currentIndex + 1.
	^ self currentIndex
]

{ #category : #'instance creation' }
InformationRecord class >> newWithInformantName: informantName informationName: informationName information: information  informationCollectedSuccessfully: informationCollectedSuccessfully [
	| r |
	r := self new.
	r informantName: informantName;
		informationName: informationName;
		information: information;
		informationCollectedSuccessfully: informationCollectedSuccessfully;
		index: self getFreshIndex.
	^ r
]

{ #category : #initialization }
InformationRecord class >> resetIndex [
	<script>
	currentIndex := 0.
]

{ #category : #accessing }
InformationRecord >> index [
	^ index
]

{ #category : #accessing }
InformationRecord >> index: anObject [
	index := anObject
]

{ #category : #accessing }
InformationRecord >> informantName [
	^ informantName
]

{ #category : #accessing }
InformationRecord >> informantName: anObject [
	informantName := anObject
]

{ #category : #accessing }
InformationRecord >> information [
	^ information
]

{ #category : #accessing }
InformationRecord >> information: anObject [
	information := anObject
]

{ #category : #accessing }
InformationRecord >> informationCollectedSuccessfully [
	^ informationCollectedSuccessfully
]

{ #category : #accessing }
InformationRecord >> informationCollectedSuccessfully: anObject [
	informationCollectedSuccessfully := anObject
]

{ #category : #accessing }
InformationRecord >> informationName [
	^ informationName
]

{ #category : #accessing }
InformationRecord >> informationName: anObject [
	informationName := anObject
]
