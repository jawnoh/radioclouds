package com.radioclouds.visualizer {
  import flash.ui.Keyboard;
  import flash.events.KeyboardEvent;
  import flash.events.FocusEvent;
  import flash.text.TextField;
  import flash.events.Event;
  import flash.events.MouseEvent;

  import com.radioclouds.visualizer.gui.TextButton;

  import flash.text.AntiAliasType;

  import com.radioclouds.visualizer.gui.TextFieldSpecial;

  import flash.text.TextFieldType;

  import com.radioclouds.visualizer.gui.RoundedBox;

  import flash.display.Sprite;

  /**
   * @author matas
   */
  public class InfoPanel extends Sprite {
    private var _background : RoundedBox;
    private static const _DEFAULT_HEIGHT : Number = 60;
    private static const _TITLE_STRING : String = "Radio<em>Clouds</em>";
    private static const _VERSION_STRING : String = "v0.2";
    private static const _INFO_STRING : String = "created by <a href=\"http://petrikas.de\" target=\"_blank\">Matas Petrikas</a> using <a href=\"http://soundcloud.com/pages/api\" target=\"_blank\">SoundCloud API</a>. More info and sourcecode <a href=\"http://radioclouds.com/about\">here</a>";
    private static const _HELP_STRING : String = "To listen to your own favorite artist on SoundCloud, type in his or her username here";
    private static const _SUBMIT_TEXT : String = "ok";
    private static const _USERNAME_TEXT : String = "username";
    private var _containerWidth : Number;
    private var _infoText : TextFieldSpecial;
    private var _titleText : TextFieldSpecial;
    private var _inputText : TextField;
    private var _submitButton : TextButton;
    public static const SUBMIT : String = "onSubmit";
    private var _helpText : TextFieldSpecial;
    private var _versionText : TextFieldSpecial;

    public function InfoPanel() {
			
      _background = new RoundedBox({height: _DEFAULT_HEIGHT, color: 0x333333, radius: 0, alpha: 0.95});
      addChild(_background);
			
      _titleText = new TextFieldSpecial({
				htmlText: _TITLE_STRING, x: 10, y: 8, format: Styles.HEADLINE
			});
      _titleText.scaleX = _titleText.scaleY = 1.7;
			
      _versionText = new TextFieldSpecial({
				htmlText: _VERSION_STRING, x: _titleText.width + 10, y: 8, format: Styles.HEADLINE
			});
      _versionText.scaleX = _versionText.scaleY = 1.7;
			
      _infoText = new TextFieldSpecial({
				htmlText: _INFO_STRING, selectable: true, mouseEnabled: true, antiAliasType: AntiAliasType.NORMAL, x: 12, y: 40
			});
			
      _helpText = new TextFieldSpecial({
				htmlText: _HELP_STRING, mouseEnabled: true, color: 0xcccccc, y: 10
			});
			


			
			
      _inputText = new TextField();
			
      _inputText.y = 30;
      _inputText.width = 150;
      _inputText.height = 20;
      _inputText.background = true;
      _inputText.backgroundColor = 0x222222;
      _inputText.selectable = true;
      _inputText.embedFonts = true;
      _inputText.defaultTextFormat = Styles.HEADLINE;
      _inputText.text = _USERNAME_TEXT;
      _inputText.type = TextFieldType.INPUT;
      _inputText.addEventListener(FocusEvent.FOCUS_IN, onInputFocus);
			
      _inputText.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardEvent);
			
      _submitButton = new TextButton({
				label: _SUBMIT_TEXT, format: Styles.HEADLINE, y: _inputText.y
			});
      _submitButton.addEventListener(MouseEvent.CLICK, onSubmit);
			
			
      addChild(_titleText);
      addChild(_versionText);
      addChild(_infoText);
      addChild(_helpText);
      addChild(_inputText);
      addChild(_submitButton);
    }

    public function onKeyboardEvent(event : KeyboardEvent) : void {
      if(event.keyCode == Keyboard.ENTER) {
        onSubmit(new MouseEvent(MouseEvent.CLICK));
      }
    } 

    private function onInputFocus(event : FocusEvent) : void {
      trace("input entered!!!!!" + _inputText.text.length);
      if(_inputText.text == _USERNAME_TEXT) {
        _inputText.text = "";
      }
      _inputText.removeEventListener(FocusEvent.FOCUS_IN, onInputFocus);
      _inputText.addEventListener(FocusEvent.FOCUS_OUT, onInputDefocus);
    }

    private function onInputDefocus(event : FocusEvent) : void {
      trace("input left!!!!!" + _inputText.text.length);
      if(_inputText.text == "") {
        _inputText.text = _USERNAME_TEXT;	
      }
      _inputText.addEventListener(FocusEvent.FOCUS_IN, onInputFocus);
    }

    private function onSubmit(event : MouseEvent) : void {
      if(_inputText.text != " " && _inputText.text != _USERNAME_TEXT && _inputText.text.length > 0) {
        dispatchEvent(new Event(InfoPanel.SUBMIT));
      }
    }

    private function redraw() : void {
      _background.width = _containerWidth;
      _submitButton.x = _containerWidth - _submitButton.width - 10;
      _inputText.x = _submitButton.x - _inputText.width - 5;
      _helpText.x = _containerWidth - _helpText.width - 10;
    }

    public override function set width(newWidth : Number) : void {
      _containerWidth = newWidth;
      redraw();
    }

    public function get userQuery() : String {
      return _inputText.text.toLowerCase().replace(" ", "-");
    }
  }
}
