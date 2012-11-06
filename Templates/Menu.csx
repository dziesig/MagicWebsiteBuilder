/* Menu CSS by "The Customized Website" */
/* Copyright (C) @~CopyrightYears~@ by The Customized Website */
/* @~ClientName~@ */
/* Most Recent Update:  @~UpdateDate~@ */

@~BarCSS~@
@~MenuBarTopCSS~@
@~MenuBarBottomCSS~@
@~MenuBarLeftCSS~@
@~MenuBarRightCSS~@
.@~MenuName~@{font:@~SelectedTextHeight~@px @~FontName~@; @~FontWeight~@; z-index : @~ZIndex~@}
ul.@~MenuName~@ {float: @~MenuFloat~@; list-style-type:none; margin:0; padding:0;}
ul.@~MenuName~@ * {margin:0; padding:0;z-index : @~ZIndex~@;}
ul.@~MenuName~@ a {@~DisplayBlock~@ text-decoration:none} 
ul.@~MenuName~@ a:visited {color:#@~UnselectedTextColorCSS~@; background-color: #@~UnselectedBackgroundColorCSS~@; text-decoration:none;  z-index : @~ZIndex~@} /* text brown background light blue  /* main menu bar for IE6+ */
ul.@~MenuName~@ li {position:relative; float:left; margin-right: 2px; list-style-type:none; @~Separator~@;  z-index : @~ZIndex~@}
ul.@~MenuName~@ ul {position:absolute; top:@~DropDownTop~@px; left:0; background:white; display:none; opacity:0; list-style:none} /* flash of this color in IE6 */
ul.@~MenuName~@ ul li {position:relative; border:1px solid #aaa; border-top:none; width:@~DropDownWidth~@px; margin:0; z-index : @~ZIndex~@} 
ul.@~MenuName~@ ul li a {display:block; padding:33px 17px 5px 3px; z-index : @~ZIndex~@}/* These don't seem to do anything */
ul.@~MenuName~@ ul li a {display:block; padding:3px 17px 5px 3px; color:#@~DropDownUnsTextColorCSS~@; background-color : #@~DropDownUnsBGColorCSS~@; z-index : @~ZIndex~@}/* submenu text and background for IE6 */
ul.@~MenuName~@ ul li a:visited {color:#@~DropDownUnsTextColorCSS~@; background-color : #@~DropDownUnsBGColorCSS~@; z-index : @~ZIndex~@} /* unselected submenu text and background */
ul.@~MenuName~@ ul li a:hover {color: #@~DropDownSelTextColorCSS~@; background-color:#@~DropDownSelBGColorCSS~@; z-index : @~ZIndex~@} /* selected submenu text and background (no sub-sub menu) */
ul.@~MenuName~@ ul ul {left:@~DropDownWidth~@px; top:-1px; z-index : @~ZIndex~@}
ul.@~MenuName~@ .@~MenuName~@_link:link {border:@~BorderSize~@px solid #aaa; padding:@~MainMenuPadding~@; font-weight:bold; color : #@~UnselectedTextColorCSS~@; text-decoration : none; background-color :  #@~UnselectedBackgroundColorCSS~@; width:@~EvenSpacingBoxWidth~@px; z-index : @~ZIndex~@; text-align : @~MainMenuTextAlign~@}/* main menu unselected (with link) for IE6 */
ul.@~MenuName~@ .@~MenuName~@_link:visited {border:@~BorderSize~@px solid #aaa; padding:@~MainMenuPadding~@; font-weight:bold; color : #@~UnselectedTextColorCSS~@; background-color : #@~UnselectedBackgroundColorCSS~@; width:@~EvenSpacingBoxWidth~@px;  z-index : @~ZIndex~@; text-align : @~MainMenuTextAlign~@} /* main menu unselected */
ul.@~MenuName~@ .@~MenuName~@_link:hover, ul.menu .menuhover {background-color:#@~SelectedBackgroundColorCSS~@; color: #@~SelectedTextColorCSS~@; z-index : @~ZIndex~@ } /* main menu selected text and background */
ul.@~MenuName~@ .@~MenuName~@_sub {color: #@~DropDownUnsTextColorCSS~@; background:#@~DropDownUnsBGColorCSS~@ url(@~DeployBaseURL~@Images/@~DropDownUnsArrowImage~@) @~DropDownArrowPos~@px  8px no-repeat; z-index : @~ZIndex~@}  /* unselected sub-menu with sub-sub menu */
ul.@~MenuName~@ .@~MenuName~@_sub:hover {color:#@~DropDownSelTextColorCSS~@; background : #@~DropDownSelBGColorCSS~@ url(@~DeployBaseURL~@Images/@~DropDownSelArrowImage~@) @~DropDownArrowPos~@px  8px no-repeat; z-index : @~ZIndex~@} /* selected sub-menu with sub-sub menu */
ul.@~MenuName~@ .@~MenuName~@_topline {border-top:1px solid #aaa z-index : @~ZIndex~@}

ul.@~MenuName~@ .@~MenuName~@_link_dd:link      {border:@~BorderSize~@px solid #aaa; padding:@~MainMenuDropDownPadding~@; font-weight:bold; color : #@~UnselectedTextColorCSS~@; text-decoration : none; background : #@~UnselectedBackgroundColorCSS~@ url(@~DeployBaseURL~@Images/@~UnselectedArrowImage~@) 2px  @~MainMenuArrowPos~@px no-repeat; width:@~EvenSpacingBoxWidth~@px; z-index : @~ZIndex~@; text-align : @~MainMenuTextAlign~@}/* main menu unselected (with link) for IE6 */
ul.@~MenuName~@ .@~MenuName~@_link_dd:visited {border:@~BorderSize~@px solid #aaa; padding:@~MainMenuDropDownPadding~@; font-weight:bold; color: #@~UnselectedTextColorCSS~@; text-decoration : none; background : #@~UnselectedBackgroundColorCSS~@ url(@~DeployBaseURL~@Images/@~UnselectedArrowImage~@) 2px  @~MainMenuArrowPos~@px no-repeat;  width:@~EvenSpacingBoxWidth~@px; z-index : @~ZIndex~@; text-align : @~MainMenuTextAlign~@} /* main menu unselected */
ul.@~MenuName~@ .@~MenuName~@_link_dd:hover, ul.menu .menuhover {background : #@~SelectedBackgroundColorCSS~@ url(@~DeployBaseURL~@Images/@~SelectedArrowImage~@) 2px  @~MainMenuArrowPos~@px no-repeat; color: #@~SelectedTextColorCSS~@; z-index : @~ZIndex~@ } /* main menu selected text and background */
