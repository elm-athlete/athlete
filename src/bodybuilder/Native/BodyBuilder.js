var _elm_bodybuilder$elegant$Native_BodyBuilder = (function() {
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

  return {
    fetchClassesNames: fetchClassesNames,
    addClassesNames: F2(addClassesNames),
    fetchDisplayStyle: fetchDisplayStyle,
    addDisplayStyle: F2(addDisplayStyle)
  }
})()
