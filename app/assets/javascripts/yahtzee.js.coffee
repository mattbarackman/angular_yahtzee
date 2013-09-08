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

class @Board
  constructor: ->
    @categories = 
      ones: null
      twos: null
      threes: null
      fours: null
      fives: null
      sixes: null
      threeOfAKind: null
      fourOfAKind: null
      fullHouse: null
      smallStraight: null
      largeStraight: null
      yahtzee: null
      chance: null

  updateCategory: (category, dice) ->
    if @categories[category] == null 
      @categories[category] = @scoreDice(category, dice.map (x) -> x.value)
      true
    else       
      false

  scoreDice: (category, dice) ->

    switch category
      when "ones" then @scoreBasic(dice, [1])
      when "twos" then @scoreBasic(dice, [2])
      when "threes" then @scoreBasic(dice, [3])
      when "fours" then @scoreBasic(dice, [4])
      when "fives" then @scoreBasic(dice, [5])
      when "sixes" then @scoreBasic(dice, [6])
      when "threeOfAKind" then @scoreThreeOfAKind(dice)
      when "fourOfAKind" then @scoreFourOfAKind(dice)
      when "fullHouse" then @scoreFullHouse(dice)
      when "smallStraight" then @scoreSmallStraight(dice)
      when "largeStraight" then @scoreLargeStraight(dice) 
      when "yahtzee" then @scoreYahtzee(dice)
      when "chance" then @scoreBasic(dice, [1..6])

  scoreBasic: (dice, qualifyingDice) ->
    ones = dice.filter (x) -> x in qualifyingDice;
    if ones.length == 0 
      sum = 0 
    else 
      sum = ones.reduce (t, s) -> t + s


  breakIntoSets: (dice) ->
    sets = {}
    for die in dice 
      if sets[die] >= 1 
         sets[die] += 1
      else
         sets[die] = 1
    sets

  scoreThreeOfAKind: (dice) ->
    sets = @breakIntoSets(dice)
    double = false
    triple = false
    for i in [1..6]
      if sets[i] >= 3
        return dice.reduce (t, s) -> t + s
    0

  scoreFourOfAKind: (dice) ->
    sets = @breakIntoSets(dice)
    double = false
    triple = false
    for i in [1..6]
      if sets[i] >= 4
        return dice.reduce (t, s) -> t + s
    0

  scoreFullHouse: (dice) ->
    sets = @breakIntoSets(dice)
    double = false
    triple = false
    for i in [1..6]
      double = true if sets[i] == 2
      triple = true if sets[i] == 3
    if double and triple
      25
    else
      0

  scoreSmallStraight: (dice) ->
    sortedDice = dice.sort()
    counter = 1
    for i in [0..(sortedDice.length-2)]
      if sortedDice[i+1] == sortedDice[i] + 1  then counter++ else counter = 1
      return 30 if counter == 4
    0


  scoreLargeStraight: (dice) ->
    sortedDice = dice.sort()
    counter = 1
    for i in [0..(sortedDice.length-2)]
      if sortedDice[i+1] == sortedDice[i] + 1  then counter++ else counter = 1
      return 40 if counter == 5
    0

  scoreYahtzee: (dice) ->
    sets = @breakIntoSets(dice)
    for i in [1..6]
      if sets[i] == 5
        return 50
    0

  showBoard: ->
    console.log(@categories)
  

class @Player
  constructor: (@name) ->
    @board = (new Board)
    @dice = [new Die, new Die, new Die, new Die, new Die]
  
  updateCategory: (category, score) ->
    @board.updateCategory category, score

  deselectAllDice: ->
    for die in @dice
      die.highlighted = false

  rollDice: ->
    for die in @dice
      die.roll() unless die.highlighted
    @showDice()

  showDice: ->
    console.log("")
    for die in @dice
      console.log(die)

  selectDice: ->
    selected_dice = prompt("Which dice do you want to save?").split("")
    return if selected_dice.length == 0
    for die in selected_dice
      @dice[parseInt(die)-1].toggleHighlight()

  selectAndUpdateCategory: ->
    success = false
    until success
      category = prompt("Which category would you like to choose?")
      success = @board.updateCategory category, @dice

  showBoard: ->
    @board.showBoard()


class @Die
  constructor: () ->
    @value = "?"
    @highlighted = false

  roll: () ->
    @value = Math.floor((Math.random()*6)+1)

  toggleHighlight: () ->
    @highlighted = !@highlighted 

class @GameController
  
  constructor: (player_count) ->
    @players = @setPlayerNames(player_count)
    @winner = false

  setPlayerNames: (player_count) ->
    players = []
    for i in [1..player_count]
      name = prompt("Player " + i + ": what is your name?")
      players[i-1] = new Player name
    players

  run: ->
     until @winner
      for player in @players
        player.deselectAllDice()
        player.rollDice()
        player.selectDice()
        player.rollDice()
        player.selectDice()
        player.rollDice()
        player.selectAndUpdateCategory()
        player.showBoard()

# gc = new GameController(2)
# gc.run()
# debugger

# score


# setup game:
#   - get player count
#   - for each player create a player with a scorecard and a name. assign to players in game controller. 
#      - for each player assign them a score card with null values for each category

