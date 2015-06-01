package
{
	import flash.display.Sprite;
	import flash.filesystem.*;
	import flash.events.*;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import by.blooddy.crypto.MD5;
	import flash.text.TextField;
	
	public class ApplicationCheckSumReader extends Sprite
	{
		private var fileStream:FileStream;
		private var text:TextField;
		private var button:ClickMe;
		
		public function ApplicationCheckSumReader():void
		{
			text = new TextField();
			addChild(text);
			
			
			text.y = 100;
			text.text = "md5 check sum"
			
			button = new ClickMe();
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, fileBrowseHandler);
			
			button.x = stage.stageWidth / 2;
			button.y = stage.stageHeight / 2;
			
			text.x =  100;
			text.width = stage.stageWidth;
		}
		
		private function fileBrowseHandler(event:MouseEvent):void
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, onSelect);
			file.browse();
		}
		
		private function onSelect(e:Event):void
		{
			trace(e.target.nativePath);
			trace("RASTA2");
			
			var filePath:File = new File(e.target.nativePath);
			fileStream = new FileStream();
			fileStream.addEventListener(Event.COMPLETE, opened);
			fileStream.openAsync(filePath, FileMode.READ);
		}
		
		protected function loadFile(e:Event):void
		{
			
			var file:* = e.target;
			trace(file.nativePath);
		}
		
		protected function opened(event:Event):void
		{
			var bytes:ByteArray = new ByteArray();
			fileStream.readBytes(bytes);
			fileStream.close();
			trace(MD5.hashBytes(bytes));
			text.text = MD5.hashBytes(bytes);
		}
	}
}