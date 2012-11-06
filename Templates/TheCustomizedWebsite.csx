@import "buttons.css";
/* DO NOT ADD ANYTHING, INCLUDING COMMENTS, BEFORE THE ABOVE @IMPORT LINE(S) */
/* @~ClientName~@ */
/* Copyright (c) @~CopyrightYears~@ by TheCustomizedWebsite.com */
/* Most Recent Update:  @~UpdateDate~@ */

/* Force all browsers to use known margin and padding */

*
{
  margin : 0px 0px 0px 0px;
  padding : 0px 0px 0px 0px;
  border-spacing : 0px;
}

.DesktopDefaultPage
{
  margin-left : auto;
  margin-right : auto;
  background-color : #@~SideBGColor~@;
  width : 950px;
  position : relative;
  @~SideBGImage~@
}

#form1
{
  background-color : #@~CenterBGColor~@;
 }
 
.customizefooter
{
  margin-left : auto;
  margin-right : auto;
  margin-top	: 16px;
}

#MainContentTable
{
	background-color : #@~CenterBGColor~@;
	width : 950px;
    @~CenterBGImage~@
}

body
{
  background-attachment : fixed;
  @~SideBGImage~@
  background-position: top center;
  background-repeat:no-repeat;
  margin-left : 0;
  background-color : #@~SideBGColor~@;
}

#TCW-Header
{
  position : relative;
  border-spacing : 0px;
}

#TCW-top_header_pix
{
  position : relative;
  display:	block;
/* Hack to make IE6 work somewhat better */
  float : right;
  @~TopImageCSS~@
}

#TCW-header_pix
{
  position : relative;
  display:	block;
/* Hack to make IE6 work somewhat better */
  float : right;
}

#TCW-IDX-content
{
  background-color : #@~CenterBGColor~@;
  @~CenterBGImage~@;
  margin-left : auto;
  margin-right : auto;
  width : 950px;
}

#TCW-Customization
{
  padding-top : 25px;
  font-size : 10px;
  color : @~SideBGColor~@;
  background-color : #@~CenterBGColor~@;
  margin-left : auto;
  margin-right : auto;
  width : 950px;
}

.TCW_CustomizationLink
{
@~TCWCustomizationLink~@
}

.TCW_CustomizationLink a:link {color : #@~CustomizationLinkColor~@ }
.TCW_CustomizationLink a:visited {color : #@~CustomizationLinkColor~@ }
.TCW_CustomizationLink a:hover {color : #@~CustomizationLinkHoverColor~@; background-color : #@~CustomizationLinkHoverBackground~@ }

.TCW_IDXLoginLink
{
  text-align : center;
  color : @~CenterBGColor~@;
  font-size : 10px;
  padding-bottom : 10px;
}
/* IDX search customization */

#IDX-main
{
  z-index : 9;
  margin-left : auto;
  margin-right : auto;
}

#IDX-main div
{
  z-index : 9;
}

#IDX-searchPageWrapper
{
  z-index : 9;
}

#IDX-main-content
{
  background-color : #@~CenterBGColor~@;
/*  @~CenterBGImage~@; */
  min-width : 950px;
  margin-left : auto;
  margin-right : auto; 
  z-index : 10;
  border-spacing : 0px;
}

#IDX-geoBoxWrapper
{
	z-index : 10;
}

#IDX-propertyTypes select
{
	z-index : 10;
}

/* styles for browser links */
img.firefox
{
width : 12.04; 
height : 4em; 
vertical-align : center;
margin : 0px 1em 0.5em 1em;
}

img.safari
{
  width : 10.8;
  height : 4em; 
  vertical-align : center;
  margin : 0px 1em 0.2em 1em;
  border : 0;
}

img.chrome
{
  padding-top : 3em;
  height : 4em;
  width : 19.2em;
  vertical-align : center;
  margin : 0px 1em 0px 1em;
  border : 0;
}

img.ie_8
{
  height : 4em;
  width : 25.5em;
  vertical-align : center;
  margin : 0px 1em 0.3em 1em;
  border : 0;
}  

img.ie_8_1
{
  height : 4em;
  width : 7.6em;
  vertical-align : center;
  margin : 0px 1em 0.5em 1em;
  border : 0;
}  

img.opera
{
  height : 4em;
  width : 10.13;
  vertical-align : center;
  margin : 0px 1em 0.2em 1em;
  border : 0;
}

#TCW-browser-bar /* This proportionally sizes and positions all of the above image links */
{
  position : relative;
  margin : 0 auto 1em auto;
  width : 950px;
  font-size : 0.5em;
  padding-bottom : 1.5em;
  text-align : center;
  background-color : #@~CenterBGColor~@;
}