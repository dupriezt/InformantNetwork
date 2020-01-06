Class {
	#name : #InformantNetworkPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'informationTable',
		'refreshInformationTableButton',
		'listOfFiltersByInformationName',
		'informationProcessingTextField'
	],
	#category : #InformantNetwork
}

{ #category : #specs }
InformantNetworkPresenter class >> defaultSpec [

	^ SpBoxLayout newHorizontal "Show collected information"
		add: (SpBoxLayout newVertical
			add: 'Collected Information' withConstraints: [:cstr | cstr height: 20];
			add: #informationTable;
			add: #refreshInformationTableButton  withConstraints: [:cstr | cstr height: 30];
			yourself) withConstraints: [:cstr | cstr width: 500];
		add: (SpBoxLayout newVertical
			add: 'Processing block (argument is `info` (InformationCollectionRecord))' withConstraints: [:cstr | cstr height: 20];
			add: #informationProcessingTextField;
			add: 'Filters / Sorters' withConstraints: [:cstr | cstr height: 20];
			add: #listOfFiltersByInformationName;
			yourself
		);
		yourself
]

{ #category : #'instance creation' }
InformantNetworkPresenter class >> initialExtent [
	^ 1100@300
]

{ #category : #'instance creation' }
InformantNetworkPresenter class >> open [
	<script>
	| a |
	a := self new openWithSpec.
	a window extent: self initialExtent.
	^ a
]

{ #category : #specs }
InformantNetworkPresenter class >> title [
	^ 'Informant Network'
]

{ #category : #specs }
InformantNetworkPresenter class >> worldMenu: aBuilder [
	<worldMenu>
	aBuilder item: 'Informant Network';
		parent: #Debugging;
		order: 5;
		action: [self open];
		iconName: #smallDoIt
]

{ #category : #initialization }
InformantNetworkPresenter >> initializeWidgets [ 
	informationTable := self newTable
		addColumn: (SpIndexTableColumn new
			title: 'Index';
			evaluated: [:item | item index]);
		addColumn: (SpStringTableColumn new
			title: 'Informant Name';
			evaluated: [:item | item informantName]);
		addColumn: (SpStringTableColumn new
			title: 'Information Name';
			evaluated: [:item | item informationName]);
		addColumn: (SpStringTableColumn new
			title: 'Information';
			evaluated: [:item | item information]);
		addColumn: (SpStringTableColumn new
			title: 'Success';
			evaluated: [:item | item informationCollectedSuccessfully]);
		yourself.
	refreshInformationTableButton := self newButton
		action: [ self refreshInformationTable ];
		label: 'Refresh';
		yourself.
	 listOfFiltersByInformationName := self newTable.
	informationProcessingTextField := self newTextInput
		acceptBlock: [:processingText | self refreshInformationTableWithProcessingText: processingText];
		placeholder: 'info';
		yourself.
	
	self refreshInformationTable
]

{ #category : #initialization }
InformantNetworkPresenter >> refreshInformationTable [
	| textOfProcessingField |
	textOfProcessingField := informationProcessingTextField text.
	textOfProcessingField = '' ifTrue: [textOfProcessingField := 'info' ].
	self refreshInformationTableWithProcessingText: textOfProcessingField.
]

{ #category : #initialization }
InformantNetworkPresenter >> refreshInformationTableWithProcessingText: aString [
	| textOfProcessingField subC |
	textOfProcessingField := aString.
	textOfProcessingField = '' ifTrue: [textOfProcessingField := 'info' ].
	subC := InformationCollectionRecordProcessing newAnonymousSubclass.
	subC compile: 'process: infoCollection
		^ [:info | ', textOfProcessingField, ' ] value: infoCollection'.
	informationTable items: (subC new perform: #process: with: (InformantNetwork currentNetwork informationCollected)).
]
