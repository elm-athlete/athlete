function fetch(cacheStore, key) {
  const value = cacheStore.get(key)
  if (value !== undefined && value !== null) {
    return {
      ctor: 'Just',
      _0: value
    }
  } else {
    return {
      ctor: 'Nothing'
    }
  }
}

function setValAndReturnValue (cacheStore, key, value) {
  cacheStore.set(key, value)
  return value
}

var _elm_bodybuilder$elegant$Native_Elegant = (function() {
  var stylesCache = new Map()
  var atomicClassCache = new Map()
  var insertedClasses = new Set()

  // Insert a stylesheet inside the head.
  var css = document.createElement('style')
  css.setAttribute('id', 'elegant-style-sheet')
  document.getElementsByTagName("head")[0].appendChild(css);
  css = css.sheet

  // fetchStyle : String -> Maybe (List String)
  function fetchStyles(key) {
    return fetch(stylesCache, key)
  }


  // addStyle : String -> List (String) -> List (String)
  function addStyles(key, styles) {
    return setValAndReturnValue(stylesCache, key, styles)
  }


  function fetchAtomicClass(key) {
    return fetch(atomicClassCache, key)
  }

  // addAtomicClass : String -> String -> String
  function addAtomicClass(key, atomicClassComputed) {
    if (!insertedClasses.has(atomicClassComputed)) {
      insertedClasses.add(atomicClassComputed)
      css.insertRule(atomicClassComputed)
    }
    return setValAndReturnValue(atomicClassCache, key, atomicClassComputed)
  }

  // getAllStyles : List (List String)
  function getAllStyles() {
    var styles = _elm_lang$core$Native_List.Nil
    for (var value of stylesCache.values()) {
      styles = _elm_lang$core$Native_List.Cons(value, styles)
    }
    return styles
  }

  return {
    fetchStyles: fetchStyles,
    addStyles: F2(addStyles),
    fetchAtomicClass: fetchAtomicClass,
    addAtomicClass: F2(addAtomicClass),
    getAllStyles: getAllStyles
  }
})()
