var _elm_bodybuilder$elegant$Native_Elegant = (function() {
  var stylesCache = new Map()

  // fetchStyle : String -> Maybe (List String)
  function fetchStyles(hash) {
    const styles = stylesCache.get(hash)
    if (styles !== undefined && styles !== null) {
      return {
        ctor: 'Just',
        _0: styles
      }
    } else {
      return {
        ctor: 'Nothing'
      }
    }
  }

  // addStyle : String -> List (String) -> List (String)
  function addStyles(hash, styles) {
    stylesCache.set(hash, styles)
    return styles
  }

  var atomicClassCache = new Map()
  function fetchAtomicClass(hash) {
    const styles = atomicClassCache.get(hash)
    if (styles !== undefined && styles !== null) {
      return {
        ctor: 'Just',
        _0: styles
      }
    } else {
      return {
        ctor: 'Nothing'
      }
    }
  }

  // addStyle : String -> List (String) -> List (String)
  function addAtomicClass(hash, atomicClassComputed) {
    atomicClassCache.set(hash, atomicClassComputed)
    return atomicClassComputed
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
