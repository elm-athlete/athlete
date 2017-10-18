var _elm_bodybuilder$elegant$Native_BodyBuilder = (function() {
  var classesNamesCache = new Map()

  // fetchStyle : String -> Maybe (String)
  function fetchClassesNames(hash) {
    const classesNames = classesNamesCache.get(hash)
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
    classesNamesCache.set(hash, classesNames)
    return classesNames
  }

  function hashString(toHash) {
    var hash = 0, i, chr
    if (toHash.length === 0) return hash
    for (i = 0; i < toHash.length; i++) {
      chr   = toHash.charCodeAt(i);
      hash  = ((hash << 5) - hash) + chr
      hash |= 0 // Convert to 32bit integer
    }
    return hash
  }

  return {
    fetchClassesNames: fetchClassesNames,
    addClassesNames: F2(addClassesNames),
    hashString: hashString
  }
})()
