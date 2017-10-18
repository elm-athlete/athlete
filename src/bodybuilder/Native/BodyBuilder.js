var _elm_bodybuilder$elegant$Native_BodyBuilder = (function() {
  var classesNamesCache = new Map()

  // fetchStyle : String -> Maybe (String)
  function fetchClassesNames(key) {
    return fetch(classesNamesCache, key)
  }

  // addStyle : String -> String -> String
  function addClassesNames(key, classesNames) {
    return setValAndReturnValue(classesNamesCache, key, classesNames)
  }

  return {
    fetchClassesNames: fetchClassesNames,
    addClassesNames: F2(addClassesNames)
  }
})()
