"
I am a baseline to define the structure and dependencies of the InformantNetwork project.
"
Class {
	#name : #BaselineOfInformantNetwork,
	#superclass : #BaselineOf,
	#category : #BaselineOfInformantNetwork
}

{ #category : #baseline }
BaselineOfInformantNetwork >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Dependencies"
			"self materialDesignLite: spec."
			"Packages"
			spec
				package: 'InformantNetwork'.
				"package: 'InformantNetwork-Tests' with: [ spec requires: #('InformantNetwork') ]."
			"Groups"
			spec
				group: 'Core' with: #('InformantNetwork');
				group: 'Tests' with: #('InformantNetwork') ].
]

{ #category : #dependencies }
BaselineOfInformantNetwork >> materialDesignLite: spec [
	spec
		baseline: 'MaterialDesignLite' with: [ spec repository: 'github://DuneSt/MaterialDesignLite:v2.x.x/src' ]
]

{ #category : #accessing }
BaselineOfInformantNetwork >> projectClass [
	^ MetacelloCypressBaselineProject
]
