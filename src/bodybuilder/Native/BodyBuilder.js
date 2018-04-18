var _elm_athlete$athlete$Native_BodyBuilder = (function() {
  var classesNamesCache = new Map()
  var displayStyleCache = new Map()

  // fetchStyle : String -> Maybe (String)
  function fetchClassesNames(key) {
    return storeFetch(classesNamesCache, key)
  }

  // addStyle : String -> String -> String
  function addClassesNames(key, classesNames) {
    return setValAndReturnValue(classesNamesCache, key, classesNames)
  }

  // fetchStyle : String -> Maybe (String)
  function fetchDisplayStyle(key) {
    return storeFetch(displayStyleCache, key)
  }

  // addStyle : String -> String -> String
  function addDisplayStyle(key, classesNames) {
    return setValAndReturnValue(displayStyleCache, key, classesNames)
  }

  var fakeNode = {
    getElementById: function() { return null; },
    addEventListener: function() {},
    removeEventListener: function() {}
  };
  
  var onDocument = on(typeof document !== 'undefined' ? document : fakeNode);
  var onWindow = on(typeof window !== 'undefined' ? window : fakeNode);
  var doc = (typeof document !== 'undefined') ? document : fakeNode;
  
  var rAF = typeof requestAnimationFrame !== 'undefined'
	        ? requestAnimationFrame
	        : function(callback) { callback(); };

  function on(node)
  {
    return function(eventName, decoder, toTask)
    {
      return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
  
        function performTask(event)
        {
          var result = A2(_elm_lang$core$Json_Decode$decodeValue, decoder, event);
          if (result.ctor === 'Ok')
          {
            _elm_lang$core$Native_Scheduler.rawSpawn(toTask(result._0));
          }
        }
  
        node.addEventListener(eventName, performTask);
  
        return function()
        {
          node.removeEventListener(eventName, performTask);
        };
      });
    };
  }

  function withNode(id, doStuff)
  {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
    {
      rAF(function()
      {
        var node = document.getElementById(id);
        if (node === null)
        {
          callback(_elm_lang$core$Native_Scheduler.fail({ ctor: 'NotFound', _0: id }));
          return;
        }
        callback(_elm_lang$core$Native_Scheduler.succeed(doStuff(node)));
      });
    });
  }


  // FOCUS

  function focusWithoutScroll(id)
  {
    return withNode(id, function(node) {
      var x = window.scrollX, y = window.scrollY;
      node.focus();
      window.scrollTo(x, y);
      return _elm_lang$core$Native_Utils.Tuple0;
    });
  }


  return {
    fetchClassesNames: fetchClassesNames,
    addClassesNames: F2(addClassesNames),
    fetchDisplayStyle: fetchDisplayStyle,
    addDisplayStyle: F2(addDisplayStyle),
    focusWithoutScroll: focusWithoutScroll
  }
})()
