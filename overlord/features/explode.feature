Feature: Bomb explosion
	As a supervillain
	I want the bomb to explode if someone tries to disarm it incorrectly 3 times
	So that only people who know the code can disarm it

	Scenario: User enters incorrect disarm code for the third time.
		Given the bomb is activated
		And an incorrect code has been entered two times
		When I enter an incorrect disarm code
		Then the bomb will explode
		And I should see "The bomb exploded"