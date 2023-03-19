package;

import flixel.FlxState;
import flixel.text.FlxText;
import lime.app.Application;
class PlayState extends FlxState
{
	public var txt:FlxText;
	public static var instance:PlayState;
	override public function create()
	{
		super.create();
		instance = this;
		flixel.FlxG.autoPause = false;

		Application.current.window.alert('The password is ' + Main.key,'WARNING');

		txt = new FlxText(5,5,"WSCommander Console\n\n");
		txt.size = 20;
		add(txt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (flixel.FlxG.keys.justPressed.G)
		{
			ConsoleWS.instance.send("PERMGRANTED." + Main.key);
		}
	}
}
