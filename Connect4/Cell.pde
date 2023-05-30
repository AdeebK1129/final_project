public class Cell {
  private int row;
  private int column;
  private boolean occupied;

  public Cell(int row, int column) {
    this.row = row;
    this.column = column;
    this.occupied = false;
  }

  public boolean isOccupied() {
    return occupied;
  }

  public void setOccupied(boolean occupied) {
    this.occupied = occupied;
  }
}
