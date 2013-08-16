class Die
  constructor: () ->
    this.value = "?"
    this.highlighted = false

  roll: () ->
    this.value = Math.floor((Math.random()*6)+1)

  toggleHighlight: () ->
    this.highlighted = !this.highlighted 

@YahtzeeCtrl = ($scope) -> 
  $scope.dice = [
    new Die
    new Die
    new Die
    new Die
    new Die
  ]

  $scope.addDie = ->
    $scope.dice.push(new Die) 

  $scope.rollDice = ->
    for die in $scope.dice
      die.roll() unless die.highlighted

  $scope.toggleHighlight = (die) ->
    die.toggleHighlight()