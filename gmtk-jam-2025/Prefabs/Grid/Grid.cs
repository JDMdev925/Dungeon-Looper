using Godot;
using System;
using System.Collections.Generic;

public partial class Grid : GodotObject {
	public Vector2 AnchorPoint;
	public float MaxRow;
	public float MaxColumn;
	public float CellWidth;
	public float CellHeight;
	public List<Cell> cells = new List<Cell>();
	
	public Grid(Vector2 ANCHORPOINT, Vector2 CELLSIZE, int ROW, int COL){
		
		AnchorPoint = ANCHORPOINT;
		MaxRow = ROW;
		MaxColumn = COL;
		CellWidth = CELLSIZE.X;
		CellHeight = CELLSIZE.Y;
		
		for (int i = 0; i < MaxColumn; i++)
		{
			for (int j = 0; j < MaxRow; j++)
			{
				cells.Add(new Cell(CellWidth, CellHeight, new Vector2(j, i), AnchorPoint));
			}
		}
	}

	public int GridSize
	{
		get
		{
			return cells.Count;
		}
	}

	public Cell GetCell(int i)
	{
		if (cells[i] != null)
		{
			return cells[i];
		}
		else
		{
			return cells[4];
		}
	}
}
