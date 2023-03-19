package;

import hx.ws.SocketImpl;
import hx.ws.Types;
import hx.ws.WebSocketHandler;
import lime.app.Application;
class ConsoleWS extends WebSocketHandler
{
	public static var instance:ConsoleWS;
	public function new(s:SocketImpl)
	{
		super(s);
		instance = this;
		onopen = function()
		{
			trace("OPENED OPEN");
			PlayState.instance.txt.text += '\nConnection was opened.';
		}
		onclose = function()
		{
			trace("CLOSED CONNECTION");
			PlayState.instance.txt.text += '\nConnection was closed.';
		}
		onmessage = function(message:MessageType)
		{
			switch (message)
			{
				case BytesMessage(content):
					trace(content.readAllAvailableBytes());
				case StrMessage(content):
					if (content == "AUTOFILLPERM")
					{
						PlayState.instance.txt.text += '\nAutofill permission asked, press G to grant.';
					}
					else
					{
						var ther:Array<String> = content.split('&');
						if (ther[0] == Main.key)
						{
							var theAction:Array<String> = ther[1].split('-');
							switch (theAction[0])
							{
								case 'RUN':
									Sys.command(theAction[1]);
									PlayState.instance.txt.text += '\nCommand injected and accepted: ' + theAction[1];
									send('close');
								case 'KILL':
									Sys.exit(0);
							}
						}
						else
						{
							var theAction:Array<String> = ther[1].split('-');
							send('invalidKey');
							send('close');
							PlayState.instance.txt.text += '\nCommand rejected due to key being invalid';
							Application.current.window.alert('Someone tried to access your PC through WSCommander but used the wrong key.','Warning');
						}
					}
			}
		}
		onerror = function(error)
		{
			PlayState.instance.txt.text += '\nError.';
		}
	}
}
