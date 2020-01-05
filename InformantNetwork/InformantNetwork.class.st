"
# Instance Variables
- informationCollectSchema: Dictionary<String, BlockClosure>
	Defines which information is to be collected when an Informant informs the network. String is a name for the information, BlockClosure is the block to be evaluated in the context of the execution to collect the information
- informationCollected: OrderedCollection<InformationRecord>
	Contains all the information recorded by this network.

# Class Variables
- currentNetwork: InformationNetwork
	The information network that Informant will inform
"
Class {
	#name : #InformantNetwork,
	#superclass : #Object,
	#instVars : [
		'informationCollectSchema',
		'informationCollected'
	],
	#classVars : [
		'currentNetwork'
	],
	#category : #InformantNetwork
}

{ #category : #accessing }
InformantNetwork class >> currentNetwork [
	currentNetwork ifNil: [ currentNetwork := self new ].
	^ currentNetwork
]

{ #category : #'as yet unclassified' }
InformantNetwork class >> newNetwork [
	<script>
	currentNetwork := nil
]

{ #category : #'as yet unclassified' }
InformantNetwork class >> receiveInformationFrom: aString [
	self currentNetwork receiveInformationFrom: aString
]

{ #category : #'as yet unclassified' }
InformantNetwork >> blockToSourceCode: aBlock [
	^ aBlock sourceNode body sourceCode
]

{ #category : #accessing }
InformantNetwork >> collect: aString byEvaluating: aBlock [
	"aString is a name for the information to collect. aBlock is the block to evaluate in the context in which #inform: was called to get the information"
	self informationCollectSchema at: aString put: aBlock.
	
]

{ #category : #accessing }
InformantNetwork >> eraseInformationCollected [
	informationCollected := nil
]

{ #category : #accessing }
InformantNetwork >> evaluateBlock: aBlock inContext: aContext [
	| receiver source |
	receiver := aContext receiver.
	source := self blockToSourceCode: aBlock.
	^ receiver class compiler source: source;
		context: aContext;
		receiver: receiver;
		evaluate
]

{ #category : #'as yet unclassified' }
InformantNetwork >> findCollectionContext [
	"Walks back the context stack until it finds a context whose method has the #frontierWithExecution pragma, then return the sender of that context"
	| result |
	result := thisContext.
	[result method pragmaAt: #frontierWithExecution] whileNil: [ 
		result := result sender.
		result ifNil: [ self error: 'Walked back the full context stack without finding a method with the #frontierWithExecution pragma' ].
	].
	^ result sender
	
]

{ #category : #accessing }
InformantNetwork >> informationCollectSchema [
	informationCollectSchema ifNil: [ informationCollectSchema := Dictionary new ].
	^ informationCollectSchema
]

{ #category : #accessing }
InformantNetwork >> informationCollected [
	informationCollected ifNil: [ informationCollected := InformationCollectionRecord new ].
	^ informationCollected
]

{ #category : #'as yet unclassified' }
InformantNetwork >> receiveInformationFrom: informantName [
	| informationName informationBlock collectionContext collectedInformation successfulCollect informationRecord |
	self informationCollectSchema associations do: [ :anAssociation | 
		informationName := anAssociation key.
		informationBlock := anAssociation value.	
		collectionContext := self findCollectionContext. "Context in which to evaluate informationBlock to collect the information"
		collectedInformation := nil.
		successfulCollect := true.
		[collectedInformation := self evaluateBlock: informationBlock inContext: collectionContext] on: Error do: [:ex |
			self inform: 'Collection of information named: ', informationName, ' by informant named: ', informantName, ' by evaluating code: ', (self blockToSourceCode: informationBlock ), ' failed because: ', ex asString.
			successfulCollect := false.
			 ].
		informationRecord := InformationRecord newWithInformantName: informantName informationName: informationName information: collectedInformation informationCollectedSuccessfully: successfulCollect. 
		self informationCollected add: informationRecord.
	]
]

{ #category : #accessing }
InformantNetwork >> resetInformationToGather [
	self informationCollectSchema removeAll
]
