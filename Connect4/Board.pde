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

  public void setCellOccupied(int row, int column, boolean occupied) {
    gameBoard[row][column].setOccupied(occupied);
  }

  public void display() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        Cell cell = gameBoard[row][col];
        if (cell.isOccupied()) {
          // Display occupied cell
          int xCor = 118 + col * 95;
          int yCor = 178 + row * 95;
          board.set(xCor, yCor, pieceColor);
        }
      }
    }
    board.updatePixels();
  }
}
