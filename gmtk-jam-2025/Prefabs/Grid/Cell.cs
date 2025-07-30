using Godot;
using System;

public partial class Cell : Node
{
	public float Width;
	public float Height;
	public Vector2 LocalPosition;

	Vector2 Anchor;

	public Cell(float WIDTH, float HEIGHT, Vector2 POS, Vector2 ANCHOR)
	{
		Width = WIDTH;
		Height = HEIGHT;
		LocalPosition = POS;
		Anchor = ANCHOR;
	}

	private Vector2 Midpoint
	{
		get
		{
			return new Vector2(Width / 2, Height / 2);
		}
	}

	public Vector2 Centre
	{
		get
		{
			return Anchor + Midpoint + new Vector2(Width * LocalPosition.X, Height * LocalPosition.Y);

		}
	}

	public Vector2 TopLeft
	{
		get
		{
			return Centre - Midpoint;
		}
	}

	public Vector2 BottomRight
	{
		get
		{
            return Centre + Midpoint;
        }
	}
}
