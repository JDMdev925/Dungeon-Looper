using Godot;
using System;

public partial class Gun : Node
{
    public float ROF; //Rate of Fire
    public int MagSize; //Amount of bullets in Magazine
    public int BPS; //Bullets per Shot
    public int CoolDown;
    
    public int Mag; // The Magazine

    public Gun(float rof, int mag, int bps, int rs)
    {
        ROF = rof;
        MagSize = mag;
        BPS = bps;
        CoolDown = rs;

        Mag = MagSize;
    }

}
