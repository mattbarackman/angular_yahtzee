# use require to load any .js file available to the asset pipeline

describe "Player", ->
  it "should have a name", ->
    matt = new Player "Matt"
    expect(matt.name).toNotBe null

describe "Board", ->
  it "correctly scores ones", ->
    board = new Board
    expect(board.scoreDice("ones", [2,2,2,3,4])).toBe 0
    expect(board.scoreDice("ones", [1,2,2,3,4])).toBe 1
    expect(board.scoreDice("ones", [1,1,1,1,2])).toBe 4
    expect(board.scoreDice("ones", [1,1,1,1,1])).toBe 5

  it "correctly scores twos", ->
    board = new Board
    expect(board.scoreDice("twos", [1,1,1,3,4])).toBe 0
    expect(board.scoreDice("twos", [1,1,2,3,4])).toBe 2
    expect(board.scoreDice("twos", [2,2,2,2,2])).toBe 10

  it "correctly scores threes", ->
    board = new Board
    expect(board.scoreDice("threes", [1,1,1,5,4])).toBe 0
    expect(board.scoreDice("threes", [1,1,2,3,4])).toBe 3
    expect(board.scoreDice("threes", [3,3,3,3,3])).toBe 15

  it "correctly scores fours", ->
    board = new Board
    expect(board.scoreDice("fours", [1,1,1,5,2])).toBe 0
    expect(board.scoreDice("fours", [1,1,4,3,2])).toBe 4
    expect(board.scoreDice("fours", [4,4,4,4,4])).toBe 20

  it "correctly scores fives", ->
    board = new Board
    expect(board.scoreDice("fives", [1,2,1,3,4])).toBe 0
    expect(board.scoreDice("fives", [5,1,2,3,4])).toBe 5
    expect(board.scoreDice("fives", [5,5,5,5,5])).toBe 25

  it "correctly scores sixes", ->
    board = new Board
    expect(board.scoreDice("sixes", [1,2,1,3,4])).toBe 0
    expect(board.scoreDice("sixes", [5,1,2,6,4])).toBe 6
    expect(board.scoreDice("sixes", [6,6,6,6,6])).toBe 30


  it "correctly scores fullHouse", ->
    board = new Board
    expect(board.scoreDice("fullHouse", [1,1,2,2,2])).toBe 25
    expect(board.scoreDice("fullHouse", [5,3,5,3,5])).toBe 25
    expect(board.scoreDice("fullHouse", [5,5,5,5,5])).toBe 0

  it "correctly scores threeOfAKind", ->
    board = new Board
    expect(board.scoreDice("threeOfAKind", [1,1,2,2,2])).toBe 8
    expect(board.scoreDice("threeOfAKind", [5,3,5,3,5])).toBe 21
    expect(board.scoreDice("threeOfAKind", [5,5,5,5,5])).toBe 25
    expect(board.scoreDice("threeOfAKind", [5,2,3,1,5])).toBe 0

  it "correctly scores fourOfAKind", ->
    board = new Board
    expect(board.scoreDice("fourOfAKind", [1,2,2,2,2])).toBe 9
    expect(board.scoreDice("fourOfAKind", [5,5,5,5,5])).toBe 25
    expect(board.scoreDice("fourOfAKind", [1,2,3,3,5])).toBe 0

  it "correctly scores smallStraight", ->
    board = new Board
    expect(board.scoreDice("smallStraight", [1,2,3,4,1])).toBe 30
    expect(board.scoreDice("smallStraight", [1,2,3,4,5])).toBe 30  
    expect(board.scoreDice("smallStraight", [5,2,3,4,5])).toBe 30
    expect(board.scoreDice("smallStraight", [5,2,3,1,5])).toBe 0

  it "correctly scores largeStraight", ->
    board = new Board
    expect(board.scoreDice("largeStraight", [5,2,1,4,3])).toBe 40
    expect(board.scoreDice("largeStraight", [5,5,5,5,5])).toBe 0

  it "correctly scores yahtzee", ->
    board = new Board
    expect(board.scoreDice("yahtzee", [5,5,5,5,5])).toBe 50
    expect(board.scoreDice("yahtzee", [4,4,4,4,4])).toBe 50
    expect(board.scoreDice("yahtzee", [5,5,5,5,4])).toBe 0


  it "correctly scores chance", ->
    board = new Board
    expect(board.scoreDice("chance", [1,1,1,1,1])).toBe 5
    expect(board.scoreDice("chance", [5,1,5,1,5])).toBe 17
    expect(board.scoreDice("chance", [5,5,5,5,5])).toBe 25
