module Elegant.Setters exposing (..)


setAlign : c -> { b | align : a } -> { b | align : c }
setAlign v o =
    { o | align = v }


setAlignIn : { b | align : a } -> c -> { b | align : c }
setAlignIn =
    flip setAlign


setAlignment : c -> { b | alignment : a } -> { b | alignment : c }
setAlignment v o =
    { o | alignment = v }


setAlignmentIn : { b | alignment : a } -> c -> { b | alignment : c }
setAlignmentIn =
    flip setAlignment


setAlignSelf : c -> { b | alignSelf : a } -> { b | alignSelf : c }
setAlignSelf v o =
    { o | alignSelf = v }


setAlignSelfIn : { b | alignSelf : a } -> c -> { b | alignSelf : c }
setAlignSelfIn =
    flip setAlignSelf


setAngle : c -> { b | angle : a } -> { b | angle : c }
setAngle v o =
    { o | angle = v }


setAngleIn : { b | angle : a } -> c -> { b | angle : c }
setAngleIn =
    flip setAngle


setBackground : c -> { b | background : a } -> { b | background : c }
setBackground v o =
    { o | background = v }


setBackgroundIn : { b | background : a } -> c -> { b | background : c }
setBackgroundIn =
    flip setBackground


setBackgroundPosition : c -> { b | backgroundPosition : a } -> { b | backgroundPosition : c }
setBackgroundPosition v o =
    { o | backgroundPosition = v }


setBackgroundPositionIn : { b | backgroundPosition : a } -> c -> { b | backgroundPosition : c }
setBackgroundPositionIn =
    flip setBackgroundPosition


setBasis : c -> { b | basis : a } -> { b | basis : c }
setBasis v o =
    { o | basis = v }


setBasisIn : { b | basis : a } -> c -> { b | basis : c }
setBasisIn =
    flip setBasis


setBlurRadius : c -> { b | blurRadius : a } -> { b | blurRadius : c }
setBlurRadius v o =
    { o | blurRadius = v }


setBlurRadiusIn : { b | blurRadius : a } -> c -> { b | blurRadius : c }
setBlurRadiusIn =
    flip setBlurRadius


setBorder : c -> { b | border : a } -> { b | border : c }
setBorder v o =
    { o | border = v }


setBorderIn : { b | border : a } -> c -> { b | border : c }
setBorderIn =
    flip setBorder


setBottom : c -> { b | bottom : a } -> { b | bottom : c }
setBottom v o =
    { o | bottom = v }


setBottomIn : { b | bottom : a } -> c -> { b | bottom : c }
setBottomIn =
    flip setBottom


setBottomLeft : c -> { b | bottomLeft : a } -> { b | bottomLeft : c }
setBottomLeft v o =
    { o | bottomLeft = v }


setBottomLeftIn : { b | bottomLeft : a } -> c -> { b | bottomLeft : c }
setBottomLeftIn =
    flip setBottomLeft


setBottomRight : c -> { b | bottomRight : a } -> { b | bottomRight : c }
setBottomRight v o =
    { o | bottomRight = v }


setBottomRightIn : { b | bottomRight : a } -> c -> { b | bottomRight : c }
setBottomRightIn =
    flip setBottomRight


setShadow : c -> { b | boxShadow : a } -> { b | boxShadow : c }
setShadow v o =
    { o | boxShadow = v }


setShadowIn : { b | boxShadow : a } -> c -> { b | boxShadow : c }
setShadowIn =
    flip setShadow


setCapitalization : c -> { b | capitalization : a } -> { b | capitalization : c }
setCapitalization v o =
    { o | capitalization = v }


setCapitalizationIn : { b | capitalization : a } -> c -> { b | capitalization : c }
setCapitalizationIn =
    flip setCapitalization


setCharacter : c -> { b | character : a } -> { b | character : c }
setCharacter v o =
    { o | character = v }


setCharacterIn : { b | character : a } -> c -> { b | character : c }
setCharacterIn =
    flip setCharacter


setColor : c -> { b | color : a } -> { b | color : c }
setColor v o =
    { o | color = v }


setColorIn : { b | color : a } -> c -> { b | color : c }
setColorIn =
    flip setColor


setColorStops : c -> { b | colorStops : a } -> { b | colorStops : c }
setColorStops v o =
    { o | colorStops = v }


setColorStopsIn : { b | colorStops : a } -> c -> { b | colorStops : c }
setColorStopsIn =
    flip setColorStops


setCursor : c -> { b | cursor : a } -> { b | cursor : c }
setCursor v o =
    { o | cursor = v }


setCursorIn : { b | cursor : a } -> c -> { b | cursor : c }
setCursorIn =
    flip setCursor


setDecoration : c -> { b | decoration : a } -> { b | decoration : c }
setDecoration v o =
    { o | decoration = v }


setDecorationIn : { b | decoration : a } -> c -> { b | decoration : c }
setDecorationIn =
    flip setDecoration


setDimension : c -> { b | dimension : a } -> { b | dimension : c }
setDimension v o =
    { o | dimension = v }


setDimensionIn : { b | dimension : a } -> c -> { b | dimension : c }
setDimensionIn =
    flip setDimension


setDimensions : c -> { b | dimensions : a } -> { b | dimensions : c }
setDimensions v o =
    { o | dimensions = v }


setDimensionsIn : { b | dimensions : a } -> c -> { b | dimensions : c }
setDimensionsIn =
    flip setDimensions


setDirection : c -> { b | direction : a } -> { b | direction : c }
setDirection v o =
    { o | direction = v }


setDirectionIn : { b | direction : a } -> c -> { b | direction : c }
setDirectionIn =
    flip setDirection


setDisplay : c -> { b | display : a } -> { b | display : c }
setDisplay v o =
    { o | display = v }


setDisplayIn : { b | display : a } -> c -> { b | display : c }
setDisplayIn =
    flip setDisplay


setFamily : c -> { b | family : a } -> { b | family : c }
setFamily v o =
    { o | family = v }


setFamilyIn : { b | family : a } -> c -> { b | family : c }
setFamilyIn =
    flip setFamily


setGrow : c -> { b | grow : a } -> { b | grow : c }
setGrow v o =
    { o | grow = v }


setGrowIn : { b | grow : a } -> c -> { b | grow : c }
setGrowIn =
    flip setGrow


setHorizontal : c -> { b | horizontal : a } -> { b | horizontal : c }
setHorizontal v o =
    { o | horizontal = v }


setHorizontalIn : { b | horizontal : a } -> c -> { b | horizontal : c }
setHorizontalIn =
    flip setHorizontal


setImage : c -> { b | image : a } -> { b | image : c }
setImage v o =
    { o | image = v }


setImageIn : { b | image : a } -> c -> { b | image : c }
setImageIn =
    flip setImage


setImages : c -> { b | images : a } -> { b | images : c }
setImages v o =
    { o | images = v }


setImagesIn : { b | images : a } -> c -> { b | images : c }
setImagesIn =
    flip setImages


setInset : c -> { b | inset : a } -> { b | inset : c }
setInset v o =
    { o | inset = v }


setInsetIn : { b | inset : a } -> c -> { b | inset : c }
setInsetIn =
    flip setInset


setJustifyContent : c -> { b | justifyContent : a } -> { b | justifyContent : c }
setJustifyContent v o =
    { o | justifyContent = v }


setJustifyContentIn : { b | justifyContent : a } -> c -> { b | justifyContent : c }
setJustifyContentIn =
    flip setJustifyContent


setLeft : c -> { b | left : a } -> { b | left : c }
setLeft v o =
    { o | left = v }


setLeftIn : { b | left : a } -> c -> { b | left : c }
setLeftIn =
    flip setLeft


setLineHeight : c -> { b | lineHeight : a } -> { b | lineHeight : c }
setLineHeight v o =
    { o | lineHeight = v }


setLineHeightIn : { b | lineHeight : a } -> c -> { b | lineHeight : c }
setLineHeightIn =
    flip setLineHeight


setListStyleType : c -> { b | listStyleType : a } -> { b | listStyleType : c }
setListStyleType v o =
    { o | listStyleType = v }


setListStyleTypeIn : { b | listStyleType : a } -> c -> { b | listStyleType : c }
setListStyleTypeIn =
    flip setListStyleType


setMargin : c -> { b | margin : a } -> { b | margin : c }
setMargin v o =
    { o | margin = v }


setMarginIn : { b | margin : a } -> c -> { b | margin : c }
setMarginIn =
    flip setMargin


setMax : c -> { b | max : a } -> { b | max : c }
setMax v o =
    { o | max = v }


setMaxIn : { b | max : a } -> c -> { b | max : c }
setMaxIn =
    flip setMax


setMaybeColor : c -> { b | maybeColor : a } -> { b | maybeColor : c }
setMaybeColor v o =
    { o | maybeColor = v }


setMaybeColorIn : { b | maybeColor : a } -> c -> { b | maybeColor : c }
setMaybeColorIn =
    flip setMaybeColor


setMin : c -> { b | min : a } -> { b | min : c }
setMin v o =
    { o | min = v }


setMinIn : { b | min : a } -> c -> { b | min : c }
setMinIn =
    flip setMin


setOffset : c -> { b | offset : a } -> { b | offset : c }
setOffset v o =
    { o | offset = v }


setOffsetIn : { b | offset : a } -> c -> { b | offset : c }
setOffsetIn =
    flip setOffset


setOpacity : c -> { b | opacity : a } -> { b | opacity : c }
setOpacity v o =
    { o | opacity = v }


setOpacityIn : { b | opacity : a } -> c -> { b | opacity : c }
setOpacityIn =
    flip setOpacity


setOutline : c -> { b | outline : a } -> { b | outline : c }
setOutline v o =
    { o | outline = v }


setOutlineIn : { b | outline : a } -> c -> { b | outline : c }
setOutlineIn =
    flip setOutline


setOverflow : c -> { b | overflow : a } -> { b | overflow : c }
setOverflow v o =
    { o | overflow = v }


setOverflowIn : { b | overflow : a } -> c -> { b | overflow : c }
setOverflowIn =
    flip setOverflow


setPadding : c -> { b | padding : a } -> { b | padding : c }
setPadding v o =
    { o | padding = v }


setPaddingIn : { b | padding : a } -> c -> { b | padding : c }
setPaddingIn =
    flip setPadding


setPosition : c -> { b | position : a } -> { b | position : c }
setPosition v o =
    { o | position = v }


setPositionIn : { b | position : a } -> c -> { b | position : c }
setPositionIn =
    flip setPosition


setCorner : c -> { b | corner : a } -> { b | corner : c }
setCorner v o =
    { o | corner = v }


setCornerIn : { b | corner : a } -> c -> { b | corner : c }
setCornerIn =
    flip setCorner


setRight : c -> { b | right : a } -> { b | right : c }
setRight v o =
    { o | right = v }


setRightIn : { b | right : a } -> c -> { b | right : c }
setRightIn =
    flip setRight


addScreenWidth : b -> { a | screenWidths : List b } -> { a | screenWidths : List b }
addScreenWidth screenWidth record =
    { record | screenWidths = screenWidth :: record.screenWidths }


setScreenWidths : c -> { b | screenWidths : a } -> { b | screenWidths : c }
setScreenWidths v o =
    { o | screenWidths = v }


setScreenWidthsIn : { b | screenWidths : a } -> c -> { b | screenWidths : c }
setScreenWidthsIn =
    flip setScreenWidths


setShrink : c -> { b | shrink : a } -> { b | shrink : c }
setShrink v o =
    { o | shrink = v }


setShrinkIn : { b | shrink : a } -> c -> { b | shrink : c }
setShrinkIn =
    flip setShrink


setSize : c -> { b | size : a } -> { b | size : c }
setSize v o =
    { o | size = v }


setSizeIn : { b | size : a } -> c -> { b | size : c }
setSizeIn =
    flip setSize


setSpreadRadius : c -> { b | spreadRadius : a } -> { b | spreadRadius : c }
setSpreadRadius v o =
    { o | spreadRadius = v }


setSpreadRadiusIn : { b | spreadRadius : a } -> c -> { b | spreadRadius : c }
setSpreadRadiusIn =
    flip setSpreadRadius


setStyle : c -> { b | style : a } -> { b | style : c }
setStyle v o =
    { o | style = v }


setStyleIn : { b | style : a } -> c -> { b | style : c }
setStyleIn =
    flip setStyle


setTextOverflow : c -> { b | textOverflow : a } -> { b | textOverflow : c }
setTextOverflow v o =
    { o | textOverflow = v }


setTextOverflowIn : { b | textOverflow : a } -> c -> { b | textOverflow : c }
setTextOverflowIn =
    flip setTextOverflow


setTilt : c -> { b | tilt : a } -> { b | tilt : c }
setTilt v o =
    { o | tilt = v }


setTiltIn : { b | tilt : a } -> c -> { b | tilt : c }
setTiltIn =
    flip setTilt


setTop : c -> { b | top : a } -> { b | top : c }
setTop v o =
    { o | top = v }


setTopIn : { b | top : a } -> c -> { b | top : c }
setTopIn =
    flip setTop


setTopLeft : c -> { b | topLeft : a } -> { b | topLeft : c }
setTopLeft v o =
    { o | topLeft = v }


setTopLeftIn : { b | topLeft : a } -> c -> { b | topLeft : c }
setTopLeftIn =
    flip setTopLeft


setTopRight : c -> { b | topRight : a } -> { b | topRight : c }
setTopRight v o =
    { o | topRight = v }


setTopRightIn : { b | topRight : a } -> c -> { b | topRight : c }
setTopRightIn =
    flip setTopRight


setTypography : c -> { b | typography : a } -> { b | typography : c }
setTypography v o =
    { o | typography = v }


setTypographyIn : { b | typography : a } -> c -> { b | typography : c }
setTypographyIn =
    flip setTypography


setUserSelect : c -> { b | userSelect : a } -> { b | userSelect : c }
setUserSelect v o =
    { o | userSelect = v }


setUserSelectIn : { b | userSelect : a } -> c -> { b | userSelect : c }
setUserSelectIn =
    flip setUserSelect


setVertical : c -> { b | vertical : a } -> { b | vertical : c }
setVertical v o =
    { o | vertical = v }


setVerticalIn : { b | vertical : a } -> c -> { b | vertical : c }
setVerticalIn =
    flip setVertical


setVisibility : c -> { b | visibility : a } -> { b | visibility : c }
setVisibility v o =
    { o | visibility = v }


setVisibilityIn : { b | visibility : a } -> c -> { b | visibility : c }
setVisibilityIn =
    flip setVisibility


setWeight : c -> { b | weight : a } -> { b | weight : c }
setWeight v o =
    { o | weight = v }


setWeightIn : { b | weight : a } -> c -> { b | weight : c }
setWeightIn =
    flip setWeight


setWhiteSpaceWrap : c -> { b | whiteSpaceWrap : a } -> { b | whiteSpaceWrap : c }
setWhiteSpaceWrap v o =
    { o | whiteSpaceWrap = v }


setWhiteSpaceWrapIn : { b | whiteSpaceWrap : a } -> c -> { b | whiteSpaceWrap : c }
setWhiteSpaceWrapIn =
    flip setWhiteSpaceWrap


setWidth : c -> { b | width : a } -> { b | width : c }
setWidth v o =
    { o | width = v }


setWidthIn : { b | width : a } -> c -> { b | width : c }
setWidthIn =
    flip setWidth


setWrap : c -> { b | wrap : a } -> { b | wrap : c }
setWrap v o =
    { o | wrap = v }


setWrapIn : { b | wrap : a } -> c -> { b | wrap : c }
setWrapIn =
    flip setWrap


setZIndex : c -> { b | zIndex : a } -> { b | zIndex : c }
setZIndex v o =
    { o | zIndex = v }


setZIndexIn : { b | zIndex : a } -> c -> { b | zIndex : c }
setZIndexIn =
    flip setZIndex


setThickness : a -> { c | thickness : b } -> { c | thickness : a }
setThickness v o =
    { o | thickness = v }


setThicknessIn : { c | thickness : b } -> a -> { c | thickness : a }
setThicknessIn =
    flip setThickness


setValue : a -> { c | value : b } -> { c | value : a }
setValue v o =
    { o | value = v }


setValueIn : { c | value : b } -> a -> { c | value : a }
setValueIn =
    flip setValue
