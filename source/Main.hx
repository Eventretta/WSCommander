package;

import flixel.FlxGame;
import hx.ws.Log;
import hx.ws.WebSocketServer;
import openfl.display.Sprite;
import flixel.FlxG;

class Main extends Sprite
{
	public var alphay:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890|%abcdefghijklmnopqrstuvwyxz()=?";
	public static var key:String = "";
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
		Log.mask = Log.INFO | Log.DEBUG | Log.DATA;
		var server = new WebSocketServer<ConsoleWS>("localhost", 1388, 10);
		server.start();

		for (i in 0...20)
		{
			key += alphay.split('')[FlxG.random.int(0, alphay.split('').length - 1)];
		}
	}
}
