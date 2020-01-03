Class {
	#name : #Informant,
	#superclass : #Object,
	#category : #InformantNetwork
}

{ #category : #'as yet unclassified' }
Informant class >> inform [
	<frontierWithExecution> "This pragma indicates that whoever calls this method is part of the execution being observed"
	self inform_real: 'Anonymous'
]

{ #category : #'as yet unclassified' }
Informant class >> inform: aString [
	<frontierWithExecution> "This pragma indicates that whoever calls this method is part of the execution being observed"
	"aString is not the information to transmit, it is a marker allowing to later distinguish the informer from which the information came from (i.e. the name of the informer in the metaphor)"
	self inform_real: aString
]

{ #category : #'as yet unclassified' }
Informant class >> inform_real: aString [
	"aString is not the information to transmit, it is a marker allowing to later distinguish the informer from which the information came from (i.e. the name of the informer in the metaphor)"
	InformantNetwork receiveInformationFrom: aString
]
