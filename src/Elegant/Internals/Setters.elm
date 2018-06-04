module Elegant.Internals.Setters exposing (..)

import Function


setAlign : a -> { b | align : a } -> { b | align : a }
setAlign v o =
    { o | align = v }


setAlignIn : { b | align : a } -> a -> { b | align : a }
setAlignIn =
    Function.flip setAlign


setAlignment : a -> { b | alignment : a } -> { b | alignment : a }
setAlignment v o =
    { o | alignment = v }


setAlignmentIn : { b | alignment : a } -> a -> { b | alignment : a }
setAlignmentIn =
    Function.flip setAlignment


setAlignSelf : a -> { b | alignSelf : a } -> { b | alignSelf : a }
setAlignSelf v o =
    { o | alignSelf = v }


setAlignSelfIn : { b | alignSelf : a } -> a -> { b | alignSelf : a }
setAlignSelfIn =
    Function.flip setAlignSelf


setAngle : a -> { b | angle : a } -> { b | angle : a }
setAngle v o =
    { o | angle = v }


setAngleIn : { b | angle : a } -> a -> { b | angle : a }
setAngleIn =
    Function.flip setAngle


setBackfaceVisibility : a -> { c | backfaceVisibility : a } -> { c | backfaceVisibility : a }
setBackfaceVisibility b a =
    { a | backfaceVisibility = b }


setTransformStyle : a -> { c | transformStyle : a } -> { c | transformStyle : a }
setTransformStyle b a =
    { a | transformStyle = b }


setBackground : a -> { b | background : a } -> { b | background : a }
setBackground v o =
    { o | background = v }


setBackgroundIn : { b | background : a } -> a -> { b | background : a }
setBackgroundIn =
    Function.flip setBackground


setBackgroundPosition : a -> { b | backgroundPosition : a } -> { b | backgroundPosition : a }
setBackgroundPosition v o =
    { o | backgroundPosition = v }


setBackgroundPositionIn : { b | backgroundPosition : a } -> a -> { b | backgroundPosition : a }
setBackgroundPositionIn =
    Function.flip setBackgroundPosition


setBasis : a -> { b | basis : a } -> { b | basis : a }
setBasis v o =
    { o | basis = v }


setBasisIn : { b | basis : a } -> a -> { b | basis : a }
setBasisIn =
    Function.flip setBasis


setBlurRadius : a -> { b | blurRadius : a } -> { b | blurRadius : a }
setBlurRadius v o =
    { o | blurRadius = v }


setBlurRadiusIn : { b | blurRadius : a } -> a -> { b | blurRadius : a }
setBlurRadiusIn =
    Function.flip setBlurRadius


setBorder : a -> { b | border : a } -> { b | border : a }
setBorder v o =
    { o | border = v }


setBorderIn : { b | border : a } -> a -> { b | border : a }
setBorderIn =
    Function.flip setBorder


setBottom : a -> { b | bottom : a } -> { b | bottom : a }
setBottom v o =
    { o | bottom = v }


setBottomIn : { b | bottom : a } -> a -> { b | bottom : a }
setBottomIn =
    Function.flip setBottom


setBottomLeft : a -> { b | bottomLeft : a } -> { b | bottomLeft : a }
setBottomLeft v o =
    { o | bottomLeft = v }


setBottomLeftIn : { b | bottomLeft : a } -> a -> { b | bottomLeft : a }
setBottomLeftIn =
    Function.flip setBottomLeft


setBottomRight : a -> { b | bottomRight : a } -> { b | bottomRight : a }
setBottomRight v o =
    { o | bottomRight = v }


setBottomRightIn : { b | bottomRight : a } -> a -> { b | bottomRight : a }
setBottomRightIn =
    Function.flip setBottomRight


setShadow : a -> { b | boxShadow : a } -> { b | boxShadow : a }
setShadow v o =
    { o | boxShadow = v }


setTransform : a -> { b | transform : a } -> { b | transform : a }
setTransform v o =
    { o | transform = v }


setTranslate : a -> { c | translate : a } -> { c | translate : a }
setTranslate v o =
    { o | translate = v }


setOrigin : a -> { c | origin : a } -> { c | origin : a }
setOrigin v o =
    { o | origin = v }


setRotate : a -> { c | rotate : a } -> { c | rotate : a }
setRotate v o =
    { o | rotate = v }


setShadowIn : { b | boxShadow : a } -> a -> { b | boxShadow : a }
setShadowIn =
    Function.flip setShadow


setTransformIn : { b | transform : a } -> a -> { b | transform : a }
setTransformIn =
    Function.flip setTransform


setCapitalization : a -> { b | capitalization : a } -> { b | capitalization : a }
setCapitalization v o =
    { o | capitalization = v }


setCapitalizationIn : { b | capitalization : a } -> a -> { b | capitalization : a }
setCapitalizationIn =
    Function.flip setCapitalization


setCharacter : a -> { b | character : a } -> { b | character : a }
setCharacter v o =
    { o | character = v }


setCharacterIn : { b | character : a } -> a -> { b | character : a }
setCharacterIn =
    Function.flip setCharacter


setColor : a -> { b | color : a } -> { b | color : a }
setColor v o =
    { o | color = v }


setColorIn : { b | color : a } -> a -> { b | color : a }
setColorIn =
    Function.flip setColor


setColorStops : a -> { b | colorStops : a } -> { b | colorStops : a }
setColorStops v o =
    { o | colorStops = v }


setColorStopsIn : { b | colorStops : a } -> a -> { b | colorStops : a }
setColorStopsIn =
    Function.flip setColorStops


setCursor : a -> { b | cursor : a } -> { b | cursor : a }
setCursor v o =
    { o | cursor = v }


setCursorIn : { b | cursor : a } -> a -> { b | cursor : a }
setCursorIn =
    Function.flip setCursor


setDecoration : a -> { b | decoration : a } -> { b | decoration : a }
setDecoration v o =
    { o | decoration = v }


setDecorationIn : { b | decoration : a } -> a -> { b | decoration : a }
setDecorationIn =
    Function.flip setDecoration


setDimension : a -> { b | dimension : a } -> { b | dimension : a }
setDimension v o =
    { o | dimension = v }


setDimensionIn : { b | dimension : a } -> a -> { b | dimension : a }
setDimensionIn =
    Function.flip setDimension


setDimensions : a -> { b | dimensions : a } -> { b | dimensions : a }
setDimensions v o =
    { o | dimensions = v }


setDimensionsIn : { b | dimensions : a } -> a -> { b | dimensions : a }
setDimensionsIn =
    Function.flip setDimensions


setDirection : a -> { b | direction : a } -> { b | direction : a }
setDirection v o =
    { o | direction = v }


setDirectionIn : { b | direction : a } -> a -> { b | direction : a }
setDirectionIn =
    Function.flip setDirection


setDisplay : a -> { b | display : a } -> { b | display : a }
setDisplay v o =
    { o | display = v }


setDisplayIn : { b | display : a } -> a -> { b | display : a }
setDisplayIn =
    Function.flip setDisplay


setFamily : a -> { b | family : a } -> { b | family : a }
setFamily v o =
    { o | family = v }


setFamilyIn : { b | family : a } -> a -> { b | family : a }
setFamilyIn =
    Function.flip setFamily


setGrow : a -> { b | grow : a } -> { b | grow : a }
setGrow v o =
    { o | grow = v }


setGrowIn : { b | grow : a } -> a -> { b | grow : a }
setGrowIn =
    Function.flip setGrow


setHorizontal : a -> { b | horizontal : a } -> { b | horizontal : a }
setHorizontal v o =
    { o | horizontal = v }


setHorizontalIn : { b | horizontal : a } -> a -> { b | horizontal : a }
setHorizontalIn =
    Function.flip setHorizontal


setImage : a -> { b | image : a } -> { b | image : a }
setImage v o =
    { o | image = v }


setImageIn : { b | image : a } -> a -> { b | image : a }
setImageIn =
    Function.flip setImage


setImages : a -> { b | images : a } -> { b | images : a }
setImages v o =
    { o | images = v }


setImagesIn : { b | images : a } -> a -> { b | images : a }
setImagesIn =
    Function.flip setImages


setInset : a -> { b | inset : a } -> { b | inset : a }
setInset v o =
    { o | inset = v }


setInsetIn : { b | inset : a } -> a -> { b | inset : a }
setInsetIn =
    Function.flip setInset


setJustifyContent : a -> { b | justifyContent : a } -> { b | justifyContent : a }
setJustifyContent v o =
    { o | justifyContent = v }


setJustifyContentIn : { b | justifyContent : a } -> a -> { b | justifyContent : a }
setJustifyContentIn =
    Function.flip setJustifyContent


setLeft : a -> { b | left : a } -> { b | left : a }
setLeft v o =
    { o | left = v }


setLeftIn : { b | left : a } -> a -> { b | left : a }
setLeftIn =
    Function.flip setLeft


setLineHeight : a -> { b | lineHeight : a } -> { b | lineHeight : a }
setLineHeight v o =
    { o | lineHeight = v }


setLineHeightIn : { b | lineHeight : a } -> a -> { b | lineHeight : a }
setLineHeightIn =
    Function.flip setLineHeight


setListStyleType : a -> { b | listStyleType : a } -> { b | listStyleType : a }
setListStyleType v o =
    { o | listStyleType = v }


setListStyleTypeIn : { b | listStyleType : a } -> a -> { b | listStyleType : a }
setListStyleTypeIn =
    Function.flip setListStyleType


setMargin : a -> { b | margin : a } -> { b | margin : a }
setMargin v o =
    { o | margin = v }


setMarginIn : { b | margin : a } -> a -> { b | margin : a }
setMarginIn =
    Function.flip setMargin


setMax : a -> { b | max : a } -> { b | max : a }
setMax v o =
    { o | max = v }


setMaxIn : { b | max : a } -> a -> { b | max : a }
setMaxIn =
    Function.flip setMax


setMaybeColor : a -> { b | maybeColor : a } -> { b | maybeColor : a }
setMaybeColor v o =
    { o | maybeColor = v }


setMaybeColorIn : { b | maybeColor : a } -> a -> { b | maybeColor : a }
setMaybeColorIn =
    Function.flip setMaybeColor


setMin : a -> { b | min : a } -> { b | min : a }
setMin v o =
    { o | min = v }


setMinIn : { b | min : a } -> a -> { b | min : a }
setMinIn =
    Function.flip setMin


setOffset : a -> { b | offset : a } -> { b | offset : a }
setOffset v o =
    { o | offset = v }


setOffsetIn : { b | offset : a } -> a -> { b | offset : a }
setOffsetIn =
    Function.flip setOffset


setOpacity : a -> { b | opacity : a } -> { b | opacity : a }
setOpacity v o =
    { o | opacity = v }


setOpacityIn : { b | opacity : a } -> a -> { b | opacity : a }
setOpacityIn =
    Function.flip setOpacity


setOutline : a -> { b | outline : a } -> { b | outline : a }
setOutline v o =
    { o | outline = v }


setOutlineIn : { b | outline : a } -> a -> { b | outline : a }
setOutlineIn =
    Function.flip setOutline


setOverflow : a -> { b | overflow : a } -> { b | overflow : a }
setOverflow v o =
    { o | overflow = v }


setOverflowIn : { b | overflow : a } -> a -> { b | overflow : a }
setOverflowIn =
    Function.flip setOverflow


setPadding : a -> { b | padding : a } -> { b | padding : a }
setPadding v o =
    { o | padding = v }


setPaddingIn : { b | padding : a } -> a -> { b | padding : a }
setPaddingIn =
    Function.flip setPadding


setPosition : a -> { b | position : a } -> { b | position : a }
setPosition v o =
    { o | position = v }


setPositionIn : { b | position : a } -> a -> { b | position : a }
setPositionIn =
    Function.flip setPosition


setCorner : a -> { b | corner : a } -> { b | corner : a }
setCorner v o =
    { o | corner = v }


setCornerIn : { b | corner : a } -> a -> { b | corner : a }
setCornerIn =
    Function.flip setCorner


setRight : a -> { b | right : a } -> { b | right : a }
setRight v o =
    { o | right = v }


setRightIn : { b | right : a } -> a -> { b | right : a }
setRightIn =
    Function.flip setRight


addScreenWidth : b -> { a | screenWidths : List b } -> { a | screenWidths : List b }
addScreenWidth screenWidth record =
    { record | screenWidths = screenWidth :: record.screenWidths }


setScreenWidths : a -> { b | screenWidths : a } -> { b | screenWidths : a }
setScreenWidths v o =
    { o | screenWidths = v }


setScreenWidthsIn : { b | screenWidths : a } -> a -> { b | screenWidths : a }
setScreenWidthsIn =
    Function.flip setScreenWidths


setShrink : a -> { b | shrink : a } -> { b | shrink : a }
setShrink v o =
    { o | shrink = v }


setShrinkIn : { b | shrink : a } -> a -> { b | shrink : a }
setShrinkIn =
    Function.flip setShrink


setSize : a -> { b | size : a } -> { b | size : a }
setSize v o =
    { o | size = v }


setSizeIn : { b | size : a } -> a -> { b | size : a }
setSizeIn =
    Function.flip setSize


setSpreadRadius : a -> { b | spreadRadius : a } -> { b | spreadRadius : a }
setSpreadRadius v o =
    { o | spreadRadius = v }


setSpreadRadiusIn : { b | spreadRadius : a } -> a -> { b | spreadRadius : a }
setSpreadRadiusIn =
    Function.flip setSpreadRadius


setStyle : a -> { b | style : a } -> { b | style : a }
setStyle v o =
    { o | style = v }


setStyleIn : { b | style : a } -> a -> { b | style : a }
setStyleIn =
    Function.flip setStyle


setTextOverflow : a -> { b | textOverflow : a } -> { b | textOverflow : a }
setTextOverflow v o =
    { o | textOverflow = v }


setTextOverflowIn : { b | textOverflow : a } -> a -> { b | textOverflow : a }
setTextOverflowIn =
    Function.flip setTextOverflow


setTilt : a -> { b | tilt : a } -> { b | tilt : a }
setTilt v o =
    { o | tilt = v }


setTiltIn : { b | tilt : a } -> a -> { b | tilt : a }
setTiltIn =
    Function.flip setTilt


setTop : a -> { b | top : a } -> { b | top : a }
setTop v o =
    { o | top = v }


setTopIn : { b | top : a } -> a -> { b | top : a }
setTopIn =
    Function.flip setTop


setTopLeft : a -> { b | topLeft : a } -> { b | topLeft : a }
setTopLeft v o =
    { o | topLeft = v }


setTopLeftIn : { b | topLeft : a } -> a -> { b | topLeft : a }
setTopLeftIn =
    Function.flip setTopLeft


setTopRight : a -> { b | topRight : a } -> { b | topRight : a }
setTopRight v o =
    { o | topRight = v }


setTopRightIn : { b | topRight : a } -> a -> { b | topRight : a }
setTopRightIn =
    Function.flip setTopRight


setTypography : a -> { b | typography : a } -> { b | typography : a }
setTypography v o =
    { o | typography = v }


setTypographyIn : { b | typography : a } -> a -> { b | typography : a }
setTypographyIn =
    Function.flip setTypography


setUserSelect : a -> { b | userSelect : a } -> { b | userSelect : a }
setUserSelect v o =
    { o | userSelect = v }


setUserSelectIn : { b | userSelect : a } -> a -> { b | userSelect : a }
setUserSelectIn =
    Function.flip setUserSelect


setVertical : a -> { b | vertical : a } -> { b | vertical : a }
setVertical v o =
    { o | vertical = v }


setVerticalIn : { b | vertical : a } -> a -> { b | vertical : a }
setVerticalIn =
    Function.flip setVertical


setVisibility : a -> { b | visibility : a } -> { b | visibility : a }
setVisibility v o =
    { o | visibility = v }


setVisibilityIn : { b | visibility : a } -> a -> { b | visibility : a }
setVisibilityIn =
    Function.flip setVisibility


setWeight : a -> { b | weight : a } -> { b | weight : a }
setWeight v o =
    { o | weight = v }


setWeightIn : { b | weight : a } -> a -> { b | weight : a }
setWeightIn =
    Function.flip setWeight


setWhiteSpaceWrap : a -> { b | whiteSpaceWrap : a } -> { b | whiteSpaceWrap : a }
setWhiteSpaceWrap v o =
    { o | whiteSpaceWrap = v }


setWhiteSpaceWrapIn : { b | whiteSpaceWrap : a } -> a -> { b | whiteSpaceWrap : a }
setWhiteSpaceWrapIn =
    Function.flip setWhiteSpaceWrap


setWidth : a -> { b | width : a } -> { b | width : a }
setWidth v o =
    { o | width = v }


setWidthIn : { b | width : a } -> a -> { b | width : a }
setWidthIn =
    Function.flip setWidth


setWrap : a -> { b | wrap : a } -> { b | wrap : a }
setWrap v o =
    { o | wrap = v }


setWrapIn : { b | wrap : a } -> a -> { b | wrap : a }
setWrapIn =
    Function.flip setWrap


setZIndex : a -> { b | zIndex : a } -> { b | zIndex : a }
setZIndex v o =
    { o | zIndex = v }


setZIndexIn : { b | zIndex : a } -> a -> { b | zIndex : a }
setZIndexIn =
    Function.flip setZIndex


setThickness : a -> { c | thickness : a } -> { c | thickness : a }
setThickness v o =
    { o | thickness = v }


setThicknessIn : { c | thickness : a } -> a -> { c | thickness : a }
setThicknessIn =
    Function.flip setThickness


setValue : a -> { c | value : a } -> { c | value : a }
setValue v o =
    { o | value = v }


setValueIn : { c | value : a } -> a -> { c | value : a }
setValueIn =
    Function.flip setValue


setLetterSpacing : a -> { c | letterSpacing : a } -> { c | letterSpacing : a }
setLetterSpacing v o =
    { o | letterSpacing = v }


setLetterSpacingIn : { c | letterSpacing : a } -> a -> { c | letterSpacing : a }
setLetterSpacingIn =
    Function.flip setLetterSpacing
