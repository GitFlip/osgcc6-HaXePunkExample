package worlds;

import com.haxepunk.Entity;
import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import entities.Block;
import entities.Player;

/**
 * ...
 * @author Rob Filippi
 */

class GameWorld extends World
{

	public function new() 
	{
		super ();
	}
	
	public override function begin()
	{
		add(new Block(30, 100)); //This block is just a test. It doesn't do anything yet
		add(new Player(30, 50));
	}
	
	
	private var block:Entity;
}