package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.matttuttle.PhysicsEntity;

/**
 * ...
 * @author Rob Filippi
 */

class Player extends Entity
{
		
	private var flip:Bool;
	private var change_color:Bool;
	private var velocityX:Float;
	private var velocityY:Float;
    private var sprite:Spritemap;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		sprite = new Spritemap( "gfx/swordguy2.png", 48, 32 );
		
		sprite.add( "stand", [0, 1, 2, 3, 4, 5], 10, true );
		sprite.add( "run", [6, 7, 8, 9, 10, 11], 20, true );
		sprite.add( "color_change", [12, 13, 14, 15, 16, 17], 10, true );
		
		graphic = sprite;
		
		// defines left, right, up, down as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W]);
        Input.define("down", [Key.DOWN, Key.S]);
		Input.define("change_color", [Key.SPACE]);
		
		velocityX = 0;
		velocityY = 0;
		
		change_color = false;
        
        type = CollisionType.PLAYER;
        
        setHitbox(48, 32);
	}
	
	// set velocity based on keyboard input
    private function handleInput()
    {
        velocityX = 0;
		velocityY = 0;
 
        if (Input.check("left"))
        {
			flip = true;
			//sprite.flipped = true;	//Moved to setAnimations. Thoughts?
            velocityX = -4;
        }
 
        if (Input.check("right"))
        {
			flip = false;
			//sprite.flipped = false;   //Moved to setAnimations. Thoughts?
            velocityX = 4;
        }
		
		if (Input.check("up"))
		{
			velocityY = -4;
		}
		
		if (Input.check("down"))
		{
			velocityY = 4;
		}
        
		if (Input.check("change_color"))
		{
            trace( "change" );
			change_color = true;
		}
		else
		{
			change_color = false;
		}
		
    }
	
	//Set the animation based on 
	private function setAnimations()
    {
        if ( !change_color && velocityX == 0 && velocityY == 0)
        {
            sprite.play("stand");
        }
        else if ( !change_color )
        {
            sprite.play("run");
        }
		else if ( change_color )
		{
			sprite.play("color_change");
		}
		
		if (/*velocityX < 0*/ flip) 
		{
			//left
			sprite.flipped = true;
		}
		else 
		{
			//right
			sprite.flipped = false;
		}
    }
	
	public override function update()
    {
        super.update();
        
		handleInput();
 
        moveBy(velocityX, velocityY);
        
        if ( collide( CollisionType.STATIC_SOLID, x, y ) != null )
        {
            trace( "collide" );
            change_color = true;
        }
        
        setAnimations();
    }
	

}