var _elm_bodybuilder$elegant$Native_BodyBuilder = (function() {
  var classesNamesCache = {}

  // fetchStyle : String -> Maybe (String)
  function fetchClassesNames(hash) {
    const classesNames = classesNamesCache[hash]
    if (classesNames !== undefined && classesNames !== null) {
      return {
        ctor: 'Just',
        _0: classesNames
      }
    } else {
      return {
        ctor: 'Nothing'
      }
    }
  }

  // addStyle : String -> String -> String
  function addClassesNames(hash, classesNames) {
    classesNamesCache[hash] = classesNames
    return classesNames
  }

  return {
    fetchClassesNames: fetchClassesNames,
    addClassesNames: F2(addClassesNames)
  }
})()
