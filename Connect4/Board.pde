public class Board {
  private Cell[][] gameBoard = new Cell[6][7];
  private final int rows = 6;
  private final int columns = 7;

  public Board() {
    for (int rowNum = 0; rowNum < rows; rowNum++) {
      for (int colNum = 0; colNum < columns; colNum++) {
        gameBoard[rowNum][colNum] = new Cell(rowNum, colNum);
      }
    }
  }

  public int findEmptyRow(int column) {
    for (int row = rows - 1; row >= 0; row--) {
      if (!gameBoard[row][column].isOccupied()) {
        return row;
      }
    }
    return -1;
  }

  public void setCellOccupied(int row, int column) {
    gameBoard[row][column].setOccupied();
  }

  public void display() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        Cell cell = gameBoard[row][col];
        if (cell.isOccupied()) {
          // Display occupied cell
          int xCor = 118 + col * 94;
          int yCor = 178 + row * 94;
          board.set(xCor, yCor, pieceColor);
        }
      }
    }
    board.updatePixels();
  }
  
    public Cell getCell(int row, int col) {
    return gameBoard[row][col];
  }
  
  public int getRows() {
    return rows;
  }
  
  public int getColumns() {
    return columns;
  }
  
  public boolean checkForWin(int lastRow, int lastCol) {
  int currentColor = gameBoard[lastRow][lastCol].getCellColor();

  // Check horizontal win
  int count = 1;
  int leftCol = lastCol - 1;
  while (leftCol >= 0 && gameBoard[lastRow][leftCol].isOccupied() && gameBoard[lastRow][leftCol].getCellColor() == currentColor) {
    count++;
    leftCol--;
  }
  int rightCol = lastCol + 1;
  while (rightCol < columns && gameBoard[lastRow][rightCol].isOccupied() && gameBoard[lastRow][rightCol].getCellColor() == currentColor) {
    count++;
    rightCol++;
  }
  if (count >= 4) {
    System.out.println("Player " + currentColor + " Wins!");
    return true;
  }

  // Check vert wins
  count = 1;
  int topRow = lastRow - 1;
  while (topRow >= 0 && gameBoard[topRow][lastCol].isOccupied() && gameBoard[topRow][lastCol].getCellColor() == currentColor) {
    count++;
    topRow--;
  }
  int bottomRow = lastRow + 1;
  while (bottomRow < rows && gameBoard[bottomRow][lastCol].isOccupied() && gameBoard[bottomRow][lastCol].getCellColor() == currentColor) {
    count++;
    bottomRow++;
  }
  if (count >= 4) {
    System.out.println("Player " + currentColor + " Wins!");
    return true;
    
  }

  // diagonal 1: Check topleft to bottomright win
  count = 1;
  int row = lastRow - 1;
  int col = lastCol - 1;
  while (row >= 0 && col >= 0 && gameBoard[row][col].isOccupied() && gameBoard[row][col].getCellColor() == currentColor) {
    count++;
    row--;
    col--;
  }
  row = lastRow + 1;
  col = lastCol + 1;
  while (row < rows && col < columns && gameBoard[row][col].isOccupied() && gameBoard[row][col].getCellColor() == currentColor) {
    count++;
    row++;
    col++;
  }
  if (count >= 4) {
    return true;
  }

  // diagonal 2: Check topright to bottomleft) win
  count = 1;
  row = lastRow - 1;
  col = lastCol + 1;
  while (row >= 0 && col < columns && gameBoard[row][col].isOccupied() && gameBoard[row][col].getCellColor() == currentColor) {
    count++;
    row--;
    col++;
  }
  row = lastRow + 1;
  col = lastCol - 1;
  while (row < rows && col >= 0 && gameBoard[row][col].isOccupied() && gameBoard[row][col].getCellColor() == currentColor) {
    count++;
    row++;
    col--;
  }
  if (count >= 4) {
    return true;
  }

  return false;
}


public void updateBoard(int xCor, int colorNum) {
  int column = (xCor - 62) / 95; // determine what column piece goes in based on mouse xCor

  int emptyRow = findEmptyRow(column); // find first empty row in given column

  if (emptyRow != -1) {
    gameBoard[emptyRow][column].setOccupied();
    gameBoard[emptyRow][column].setCellColor(colorNum);

    // Check if the current move results in a win
    boolean isWin = checkForWin(emptyRow, column);
    if (isWin) {
    } else {
      // Handle the next player's turn
      // ...
    }
  }
}

public String toString(){
   String arrString = "";
    for(int i = 0; i < gameBoard.length; i++) {
        for(int j = 0; j < gameBoard[i].length; j++) {
            arrString += gameBoard[i][j].getCellColor() + " ";
        }
        arrString += "\n";
    }
    return arrString;
}  
}
