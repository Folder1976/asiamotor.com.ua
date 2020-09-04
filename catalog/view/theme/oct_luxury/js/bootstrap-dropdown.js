/* ============================================================
 * bootstrap-dropdown.js v2.2.1
 * http://twitter.github.com/bootstrap/javascript.html#dropdowns
 * ============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================ */
!function(a){"use strict";function d(){a(b).each(function(){e(a(this)).removeClass("open")})}function e(b){var d,c=b.attr("data-target");return c||(c=b.attr("href"),c=c&&/#/.test(c)&&c.replace(/.*(?=#[^\s]*$)/,"")),d=a(c),d.length||(d=b.parent()),d}var b="[data-toggle=dropdown]",c=function(b){var c=a(b).on("click.dropdown.data-api",this.toggle);a("html").on("click.dropdown.data-api",function(){c.parent().removeClass("open")})};c.prototype={constructor:c,toggle:function(b){var f,g,c=a(this);if(!c.is(".disabled, :disabled"))return f=e(c),g=f.hasClass("open"),d(),g||(f.toggleClass("open"),c.focus()),!1},keydown:function(b){var c,d,g,h,i;if(/(38|40|27)/.test(b.keyCode)&&(c=a(this),b.preventDefault(),b.stopPropagation(),!c.is(".disabled, :disabled"))){if(g=e(c),h=g.hasClass("open"),!h||h&&27==b.keyCode)return c.click();d=a("[role=menu] li:not(.divider) a",g),d.length&&(i=d.index(d.filter(":focus")),38==b.keyCode&&i>0&&i--,40==b.keyCode&&i<d.length-1&&i++,~i||(i=0),d.eq(i).focus())}}},a.fn.dropdown=function(b){return this.each(function(){var d=a(this),e=d.data("dropdown");e||d.data("dropdown",e=new c(this)),"string"==typeof b&&e[b].call(d)})},a.fn.dropdown.Constructor=c,a(document).on("click.dropdown.data-api touchstart.dropdown.data-api",d).on("click.dropdown touchstart.dropdown.data-api",".dropdown form",function(a){a.stopPropagation()}).on("touchstart.dropdown.data-api",".dropdown-menu",function(a){a.stopPropagation()}).on("click.dropdown.data-api touchstart.dropdown.data-api",b,c.prototype.toggle).on("keydown.dropdown.data-api touchstart.dropdown.data-api",b+", [role=menu]",c.prototype.keydown)}(window.jQuery);