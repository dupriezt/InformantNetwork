Class {
	#name : #Informant,
	#superclass : #Object,
	#category : #InformantNetwork
}

{ #category : #report }
Informant class >> report [
	<frontierWithExecution> "This pragma indicates that whoever calls this method is part of the execution being observed"
	self report_real: 'Anonymous'
]

{ #category : #report }
Informant class >> report: aString [
	<frontierWithExecution> "This pragma indicates that whoever calls this method is part of the execution being observed"
	"aString is not the information to transmit, it is a marker allowing to later distinguish the informer from which the information came from (i.e. the name of the informer in the metaphor)"
	self report_real: aString
]

{ #category : #report }
Informant class >> report_real: aString [
	"aString is not the information to transmit, it is a marker allowing to later distinguish the informer from which the information came from (i.e. the name of the informer in the metaphor)"
	InformantNetwork receiveInformationFrom: aString
]
