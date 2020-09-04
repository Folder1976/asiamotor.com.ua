function getCookie(name) {
	var matches = document.cookie.match(new RegExp(
	"(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
	));
	
	return matches ? decodeURIComponent(matches[1]) : 'undefined';
}

function get_oct_policy() {
	$.ajax({
        url: "index.php?route=common/footer/getOctPolicy",
        type: "post",
        dataType: "json",
        success: function(t) {
            if (t['text_oct_policy']) {
	            var html = '<div id="oct-policy" class="fixed-bottom"><div class="container"><div class="row"><div class="col-lg-12 d-flex align-items-center justify-content-between"><div class="oct-policy-text">'+ t['text_oct_policy'] +'</div><button type="button" id="oct-policy-btn">'+ t['oct_policy_accept'] +'</button></div></div></div></div>';
	            
	            $('body').append(html);
	            
	            $('#oct-policy-btn').on('click', function () {
					$('#oct-policy').addClass('clicked');
					const date = new Date(t['oct_policy_day_now'].replace(/-/g, "/"));
					date.setTime(date.getTime() + (t['oct_max_day'] * 24 * 60 * 60 * 1000));
					document.cookie = t['oct_policy_value']+'=1; path=/; expires=' + date.toUTCString();
				});
            }
        },
        error: function(e, t, i) {
            alert(i + "\r\n" + e.statusText + "\r\n" + e.responseText)
        }
    });
}

function get_oct_popup_add_to_wishlist(e) {
    $.ajax({
        url: "index.php?route=account/wishlist/add",
        type: "post",
        data: "product_id=" + e,
        dataType: "json",
        success: function(t) {
            $.magnificPopup.open({
                tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
                items: {
                    src: "index.php?route=extension/module/oct_popup_add_to_wishlist&product_id=" + e,
                    type: "ajax"
                },
                midClick: !0,
                removalDelay: 200
            }), $("#wishlist-total span").html(t.total), $("#wishlist-total").attr("title", t.total)
        },
        error: function(e, t, i) {
            alert(i + "\r\n" + e.statusText + "\r\n" + e.responseText)
        }
    });
}

function get_oct_popup_add_to_compare(e) {
    $.ajax({
        url: "index.php?route=product/compare/add",
        type: "post",
        data: "product_id=" + e,
        dataType: "json",
        success: function(t) {
            $.magnificPopup.open({
                tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
                items: {
                    src: "index.php?route=extension/module/oct_popup_add_to_compare&product_id=" + e,
                    type: "ajax"
                },
                midClick: !0,
                removalDelay: 200
            }), $("#compare-total").html(t.total)
        },
        error: function(e, t, i) {
            alert(i + "\r\n" + e.statusText + "\r\n" + e.responseText)
        }
    });
}

function get_oct_popup_add_to_cart(e) {
    $.ajax({
        url: "index.php?route=checkout/cart/add",
        type: "post",
        data: "product_id=" + e + "&quantity=" + ("undefined" != typeof quantity ? quantity : 1),
        dataType: "json",
        success: function(t) {
	        if(typeof octYandexEcommerce == 'function') {
				octYandexEcommerce(t);
		    }
	        
            t.redirect && (location = t.redirect), t.success && ($.magnificPopup.open({
                tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
                items: {
                    src: "index.php?route=extension/module/oct_popup_add_to_cart&product_id=" + e,
                    type: "ajax"
                },
                midClick: !0,
                removalDelay: 200
            }), $("#cart-total").html(t.total), $("#cart > ul").load("index.php?route=common/cart/info ul li"))
        },
        error: function(e, t, i) {
            alert(i + "\r\n" + e.statusText + "\r\n" + e.responseText)
        }
    });
}

function get_oct_popup_cart() {
    $(".checkout-cart").length <= 0 && $(".checkout-oct_fastorder").length <= 0 && $.magnificPopup.open({
        tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
        items: {
            src: "index.php?route=extension/module/oct_popup_cart",
            type: "ajax"
        },
        midClick: !0,
        removalDelay: 200
    });
}

function get_oct_popup_login() {
    $.magnificPopup.open({
        tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
        items: {
            src: "index.php?route=extension/module/oct_popup_login",
            type: "ajax"
        },
        midClick: !0,
        removalDelay: 200
    });
}

function get_oct_popup_product_view(e) {
    $.magnificPopup.open({
        tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
        items: {
            src: "index.php?route=extension/module/oct_popup_view&product_id=" + e,
            type: "ajax"
        },
        midClick: !0,
        removalDelay: 200,
        showCloseBtn: !0
    });
}

function get_oct_popup_found_cheaper(product_id) {
	setTimeout(function() { 
		$.magnificPopup.open({
			tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
			items: {
				src: 'index.php?route=extension/module/oct_popup_found_cheaper&product_id='+product_id,
				type: 'ajax'
			},
			midClick: true, 
			removalDelay: 200
		});
	}, 1);
}

function get_oct_popup_purchase(product_id) {  
	setTimeout(function() { 
		$.magnificPopup.open({
			tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
			items: {
				src: 'index.php?route=extension/module/oct_popup_purchase&product_id='+product_id,
				type: 'ajax'
			},
			midClick: true, 
			removalDelay: 200
		});
	}, 1);
}

function get_oct_popup_call_phone() {  
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/oct_popup_call_phone',
			type: 'ajax'
		},
		midClick: true, 
		removalDelay: 200
	});
}

function get_oct_product_preorder(product_id) {  
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_luxury/stylesheet/oct_product_preorder/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/oct_product_preorder&product_id='+product_id,
			type: 'ajax'
		}
	});
}

function doLiveSearch( ev, keywords ) {

	if( ev.keyCode == 38 || ev.keyCode == 40 ) {
		return false;
	}	

	$('#livesearch_search_results').remove();
	$("#close-desktop-search").fadeOut(20);
	updown = -1;

	if( keywords == '' || keywords.length < 3 ) {
		return false;
	}
	keywords = encodeURI(keywords);

	$.ajax({url: $('base').attr('href') + 'index.php?route=product/search/ajax&keyword=' + encodeURIComponent(keywords) + '&filter_category_id=' + $("#search input[name=category_id]").val(), dataType: 'json', success: function(result) {
		
		if(result.length > 0 ) {
			var eList = document.createElement('ul');
			eList.id = 'livesearch_search_results';
			var eListElem;
			var eLink;
			for( var i in result ) {
			eListElem = document.createElement('li');
        
	        eListDiv = document.createElement('div');
	        eListDiv.setAttribute("style", "height: 10px; clear: both;");
	        closeDiv = document.createElement('div');
	        closeDiv.setAttribute("style", "height: 25px; clear: both;");

	        
	        eListDivpr = document.createElement("span");
	        eListDivpr.innerHTML = result[i].price;
	        eListDivpr.setAttribute("style", "height: 14px; color: #147927;"); 
	        "" != result[i].special && eListDivpr.setAttribute("style", "text-decoration: line-through;");
	
	        eListDivprspec = document.createElement("span"); 
	        eListDivprspec.innerHTML = result[i].special;
	        eListDivprspec.setAttribute("style", "font-weight: bold; margin-left: 8px; color: #a70d0d; font-size: 16px;"); 
	        
	        eListDivstatus = document.createElement("span");
	        eListDivstatus.innerHTML = result[i].stock;
	        eListDivstatus.setAttribute("style", "height: 14px; color: #337ab7; margin-left: 15px;");
	    
	        eListImg = document.createElement('img');
	        eListImg.src = result[i].image;
	        eListImg.setAttribute("style", "margin-right: 10px;");
	        eListImg.align = 'left';
					
	        eLink = document.createElement('a');
	        eLink.setAttribute("style", "display: block;");
					eLink.appendChild( document.createTextNode(result[i].name) );
					if( typeof(result[i].href) != 'undefined' ) {
						var convertlink = result[i].href;
						eLink.href = convertlink.replace(/&amp;/g, "&");
						
					} else {
						eLink.href = $('base').attr('href') + 'index.php?route=product/product&product_id=' + result[i].product_id + '&keyword=' + encodeURIComponent(keywords);
					}
					eListElem.appendChild(eLink);
					eList.appendChild(eListImg);
					eList.appendChild(eListElem);
					eList.appendChild(eListDivpr);
					"" != result[i].special && eList.appendChild(eListDivprspec);
					eList.appendChild(eListDivstatus);
					eList.appendChild(eListDiv);
				}
				if( $('#livesearch_search_results').length > 0 ) {
					$('#livesearch_search_results').remove();
				}
				$('#search').append(eList);
				$("#livesearch_search_results").css("display", "none");
				$("#livesearch_search_results").slideDown("fast");
				$('#search').append($("#close-desktop-search"));
				$("#close-desktop-search").fadeIn(20);
			} else {
				$("#close-desktop-search").fadeOut(20);
			}
	}});

	return true;
}

function doLiveSearchMobile(ev, keywords) {
	if (ev.keyCode == 38 || ev.keyCode == 40) {
		return false;
	}

	$('#msearchresults').remove();
	updown = -1;

	if (keywords == '' || keywords.length < 3) {
		return false;
	}
	keywords = encodeURI(keywords);

	$.ajax({
		url: $('base').attr('href') + 'index.php?route=product/search/ajax&keyword=' + encodeURIComponent(keywords),
		dataType: 'json',
		success: function (result) {
			if (result.length > 0) {
				var eList = document.createElement('ul');
				eList.id = 'msearchresults';
				var eListElem;
				var eLink;
				for (var i in result) {
					eListElem = document.createElement('li');
					eListElem.setAttribute("class", "clearfix");
					eListElem.setAttribute("style", "margin-bottom:10px;");

					eListDiv = document.createElement('div');

					eListDivpr = document.createElement("span");
					eListDivpr.innerHTML = result[i].price;
					eListDivpr.setAttribute("style", "color: #147927;display:block;margin-top: 10px;");
					"" != result[i].special && eListDivpr.setAttribute("style", "text-decoration: line-through;");

					eListDivprspec = document.createElement("span");
					eListDivprspec.innerHTML = result[i].special;
					eListDivprspec.setAttribute("style", "font-weight: bold; display: block; color: #a70d0d; font-size: 16px;");

					eListDivstatus = document.createElement("span");
					eListDivstatus.innerHTML = result[i].stock;
					eListDivstatus.setAttribute("style", "color: #337ab7;font-weight: bold;");

					eListImg = document.createElement('img');
					eListImg.src = result[i].image;
					eListImg.setAttribute("style", "margin-right: 10px;float:left;display:block;");

					eLink = document.createElement('a');
					eLink.setAttribute("style", "display: block;line-height: 1.5; float: none;padding-right: 0;");
					eLink.appendChild(document.createTextNode(result[i].name));
					if (typeof (result[i].href) != 'undefined') {
						var convertlink = decodeURIComponent(result[i].href);
						eLink.href = convertlink.replace('&amp;', "&");

					} else {
						eLink.href = $('base').attr('href') + 'index.php?route=product/product&product_id=' + result[i].product_id + '&keyword=' + encodeURIComponent(keywords);
					}
					
					eListElem.appendChild(eListImg);
					eListDiv.appendChild(eLink);
					eListDiv.appendChild(eListDivpr);
					"" != result[i].special && eListDiv.appendChild(eListDivprspec);
					eListDiv.appendChild(eListDivstatus);
					eListElem.appendChild(eListDiv);
					eList.appendChild(eListElem);
				}
				if ($('.mobile-search-result').length > 0) {
					$('.mobile-search-result').html('');
				}
				$('.mobile-search-result').append(eList);
			}
		}
	});

	return true;
}


function upDownEvent(e) {
    var t = document.getElementById("livesearch_search_results");
    if ($("#search").find("[name=search]").first(), t) {
        var i = t.childNodes.length - 1;
        if (-1 != updown && void 0 !== t.childNodes[updown] && $(t.childNodes[updown]).removeClass("highlighted"), 38 == e.keyCode ? updown = updown > 0 ? --updown : updown : 40 == e.keyCode && (updown = i > updown ? ++updown : updown), updown >= 0 && i >= updown) {
            $(t.childNodes[updown]).addClass("highlighted");
            var n = t.childNodes[updown].childNodes[0].text;
            void 0 === n && (n = t.childNodes[updown].childNodes[0].innerText), $("#search").find("[name=search]").first().val(new String(n).replace(/(\s\(.*?\))$/, ""))
        }
    }
    return !1
}
null != navigator.userAgent.match(/iPad/i) && (window.onorientationchange = function() {}), document.documentElement.addEventListener("touchstart", function(e) {
    e.touches.length > 1 && e.preventDefault()
}, !1), $(document).ready(function() {
	
	// mobile menu
	$( "#sidebar-toggle" ).click(function() {
		$( "#menu-mobile-box" ).addClass('opened');
		$( "html" ).addClass('noscroll');
	});	
	$( ".mob-menu-close" ).click(function() {
		$( "#menu-mobile-box" ).removeClass('opened');
		$( "html" ).removeClass('noscroll');
	});
	// second level
	$('.mob-menu-toggle').on('click', function() {
		$('#menu-mobile').css('transform', 'translateX(-100%)');
		$(this).parent().addClass('open');
		$('.mob-menu-header-item').css('display', 'none');
		$('#menu-back').addClass('clicked');
		$('.mob-menu-ul').scrollTop(0);
	});
	
	// third level
	$('.mob-menu-toggle-child').on('click', function() {
		$(this).parent().parent().addClass('moved');
		$('#menu-back').addClass('clicked-child');
	});
	
	$('#menu-back').on('click', function () {
		if ($(this).hasClass('clicked-child')) {
			// third level
			$(this).removeClass('clicked-child');
			$('.mob-menu-child-second.moved').removeClass('moved');
			$('.mob-menu-child-second > li.open').removeClass('open');
		} else if ($(this).hasClass('clicked')) {
			// second level
			$(this).removeClass("clicked");
			$('#menu-mobile').css('transform', 'translateX(0)');
			$('.mob-menu-header-item').css('display', 'inline-block');
			$('.mob-menu-ul > li.open').removeClass('open');
			$('.mob-menu-ul').css('height', 'calc(100vh - 59px)');
		}
	});
	
	$( "#close-desktop-search" ).click(function() {
	$("#search .input-lg").val('');
	$('#livesearch_search_results').remove();
	$(this).fadeOut(10);
	});
	
	$("#mob-search-div").find("[name=search-mobile]").first().keyup(function (ev) {
		doLiveSearchMobile(ev, this.value);
	}).focus(function (ev) {
		doLiveSearchMobile(ev, this.value);
	}).keydown(function (ev) {
		upDownEvent(ev);
	}).blur(function () {});
	$(document).bind('keydown', function (ev) {
		try {
			if (ev.keyCode == 13 && $('.highlighted').length > 0) {
				document.location.href = $('.highlighted').find('a').first().attr('href');
			}
		} catch (e) {}
	});

	
    $(".right-menu-btn").on("click", function(e) {
        $(".right-menu-info").fadeToggle("slow")
    }), $("#back-top").hide(), $(function() {
        $(window).scroll(function() {
            $(this).scrollTop() > 450 ? $("#back-top").fadeIn() : $("#back-top").fadeOut()
        }), $("#back-top a").click(function() {
            return $("body,html").animate({
                scrollTop: 0
            }, 800), !1
        })
    }), $(".dropdown-toggle").dropdown(), $("#sstore-3-level li.active").addClass("open").children("ul").show(), $("#sstore-3-level li.has-sub>a.toggle-a").on("click", function() {
        $(this).removeAttr("href");
        var e = $(this).parent("li");
        e.hasClass("open") ? (e.removeClass("open"), e.find("li").removeClass("open"), e.find("ul").slideUp(200)) : (e.addClass("open"), e.children("ul").slideDown(200), e.siblings("li").children("ul").slideUp(200), e.siblings("li").removeClass("open"), e.siblings("li").find("li").removeClass("open"), e.siblings("li").find("ul").slideUp(200))
    }), $(".phoneclick").on("click", function() {
        return !1
    }), $("#oct-search-button").on("click", function() {
        srchurl = $("base").attr("href") + "index.php?route=product/search";
        var e = $("input[name='search']").val();
        if (e.length <= 0) return !1;
        e && (srchurl += "&search=" + encodeURIComponent(e));
        var t = $("input[name='category_id']").prop("value");
        t > 0 && (srchurl += "&sub_category=true&category_id=" + encodeURIComponent(t)), location = srchurl
    }), $("#search input[name='search']").on("keydown", function(e) {
        if (13 == e.keyCode) {
            if ($("input[name='search']").val().length <= 0) return !1;
            $("#oct-search-button").trigger("click")
        }
    }), $("#search a").click(function() {
        $(".cats-button").html('<span class="category-name">' + $(this).html() + '&nbsp;</span>'), $(".selected_oct_cat").val($(this).attr("id")), $("#close-desktop-search").css("display","none");
	         var inputvalue = $("input[name='search']").val();
	         doLiveSearch(0, inputvalue);
    });
    
    
    $("button.cats-button").click(function() {
        $("#search .dropdown").removeClass("open");
        $("#search .dropdown-menu").toggleClass("hide-cats-class");
    });

    
    var e = document.location.toString();
    $("a").filter(function() {
        return -1 != e.indexOf(this.href)
    }).addClass("current-link");
    var t, i, n = (t = window, i = "inner", "innerWidth" in window || (i = "client", t = document.documentElement || document.body), {
        width: t[i + "Width"],
        height: t[i + "Height"]
    }).width;
    window.addEventListener("orientationchange", function() {
        90 == window.orientation && location.reload()
    }, !1), n > 1024 && $(window).scroll(function() {
        $(this).scrollTop() > 290 ? ($("#menu-fix").addClass("fixed"), $("#fixed-cart").append($("#cart-total")), $("#right-menu-ul").append($(".right-menu-ul li")), $(".menu-row").append($("#logo")), $(".fixed-wishlist").append($("#wishlist-total")), $("body").css("margin-top", "80px")) : ($("#menu-fix").removeClass("fixed"), $("#cart > .cart-btn").append($("#cart-total")), $(".right-menu-ul").append($("#right-menu-ul li")), $(".first-header-container .row .luxury-logo-box").prepend($("#logo")), $(".wishlist-acc-dropdown").append($("#wishlist-total")), $("body").css("margin-top", "0"))
    }), 992 >= n && ($("#mobile-fixed-cart").append($("#cart-total")), $("#top-links > ul").append($("#left-top-links > ul > li.acc-dropdown")), $(".phohes-dropdown").append($(".right-menu-ul li.right-menu-ul-li")), $("#sidebar-wishlist").append($("#wishlist-total")), $("#sidebar-compare").append($("#compare-total-head")), $(".sidebar-info").append($(".right-menu-ul li")))
}), $(document).delegate("ul.dropdown-menu", "click", function(e) {
    e.stopPropagation()
}), $(window).on("resize", function() {
    var e, t, i = (e = window, t = "inner", "innerWidth" in window || (t = "client", e = document.documentElement || document.body), {
        width: e[t + "Width"],
        height: e[t + "Height"]
    }).width;
    992 >= i ? ($("#fixed-cart").append($("#cart-total")), $("#top-links > ul").append($("#left-top-links > ul > li.acc-dropdown")), $(".phohes-dropdown").append($(".right-menu-ul li.right-menu-ul-li"))) : ($("#cart .cart-btn").append($("#cart-total")), $(".fixed-right-menu .fixed-cart").append($("#fixed-cart")), $(".first-header-container .row .luxury-logo-box").prepend($("#logo")), $(".right-menu-ul").append($(".phohes-dropdown li.right-menu-ul-li")), $("#left-top-links > ul").prepend($("#top-links > ul > li.acc-dropdown")), $("#top-search").append($("#search")), $(".wishlist-acc-dropdown").append($("#wishlist-total")), $(".right-menu-ul").append($(".sidebar-info li"))), 992 >= i ? ($("#sidebar-wishlist").append($("#wishlist-total")), $("#sidebar-compare").append($("#compare-total-head")), $(".sidebar-info").append($(".right-menu-ul li")), $("#mobile-fixed-cart").append($("#cart-total"))) : $(".wishlist-acc-dropdown").append($("#wishlist-total"))
}), $(function() {
    $("#desc-cat-button").on("click", function(e) {
        setTimeout(function() {
            $(".desc-cat-text").css("height", "auto"), $(".desc-cat-text").css("overflow", "visible"), $("#desc-cat-button").css("display", "none")
        }, 300)
    }), $(".popup-with-zoom-anim").magnificPopup({
        type: "inline",
        midClick: !0,
        removalDelay: 200,
        callbacks: {
            beforeOpen: function() {
                this.st.mainClass = this.st.el.attr("data-effect")
            }
        }
    }), $(".popup-button").on("click", function() {
        $.magnificPopup.close()
    })
}), $(window).width() > 1025 && function(e, t, i) {
    var n = e();
    e.fn.dropdownHover = function(i) {
        return n = n.add(this.parent()), this.each(function() {
            var a, s, r = e(this).parent(),
                c = {
                    delay: e(this).data("delay"),
                    instantlyCloseOthers: e(this).data("close-others")
                },
                l = e.extend(!0, {}, {
                    delay: 0,
                    instantlyCloseOthers: !0
                }, i, c);
            r.hover(function() {
                o() && (!0 === l.instantlyCloseOthers && n.removeClass("open"), t.clearTimeout(a), e(this).addClass("open"))
            }, function() {
                o() && (a = t.setTimeout(function() {
                    r.removeClass("open")
                }, l.delay))
            }), r.find(".dropdown-submenu").hover(function() {
                o() && t.clearTimeout(s), e(this).children(".dropdown-menu").show()
            }, function() {
                var i = e(this).children(".dropdown-menu");
                o() ? s = t.setTimeout(function() {
                    i.hide()
                }, l.delay) : i.hide()
            })
        })
    };
    var o = function() {
        return !0
    };
    e(document).ready(function() {
        e('[data-hover="dropdown"]').dropdownHover(), e('<div class="nav-collapse collapse" style="visibility:hidden;position:fixed" id="cwspear-is-awesome">.</div>').appendTo("body")
    });
    var a = ".dropdown-submenu:hover>.dropdown-menu{display:none}",
        s = document.createElement("style");
    s.type = "text/css", s.styleSheet ? s.styleSheet.cssText = a : s.appendChild(document.createTextNode(a)), e("head")[0].appendChild(s)
}(jQuery, this);
var oct_a = !1,
    oct_hov = !1,
    oct_real_link = $("html").hasClass("oct_real_link"),
    oct_menu_resp = !1,
    oct_is_resp = "yes";
$(document).ready(function() {
    var e, t, i = (e = window, t = "inner", "innerWidth" in window || (t = "client", e = document.documentElement || document.body), {
        width: e[t + "Width"],
        height: e[t + "Height"]
    }).width;
    "yes" == oct_is_resp && 992 > i && (oct_menu_resp = !0), $("ul.oct_megamenu li .sub-menu .content .hover-menu ul li").hover(function() {
        $(this).children("ul").addClass("active")
    }, function() {
        $(this).children("ul").removeClass("active")
    }), $(".oct_close-menu").on("click", function() {
        return $(this).parent().removeClass("active"), $(this).next().next().next().animate({
            height: "hide"
        }, 400), !1
    }), $(".oct_hide_cat").on("click", function() {
        return $(this).parent().removeClass("active"), $(this).next().animate({
            height: "hide"
        }, 400), !1
    }), $("ul.oct_megamenu > li").each(function() {
        var e = 0;
        $(this).find(".mobile-enabled").each(function() {
            e++
        }), 0 == e && $(this).find(".oct_open-menu").addClass("mobile-disabled")
    }), $(".oct_open-menu").on("click", function() {
        $(this).parent().addClass("active"), $(this).next().next().animate({
            height: "show"
        }, 400), oct_menu_resp = !0
    }), $("ul.oct_megamenu > li.click .content a").click(function() {
        window.location = $(this).attr("href")
    }), $(".oct_show_cat").on("click", function() {
        return $(".oct_show_cat").parent().removeClass("active"), $(".oct_show_cat").next().next().animate({
            height: "hide"
        }, 400), $(this).parent().addClass("active"), $(this).next().next().animate({
            height: "show"
        }, 400), !1
    }), $("ul.oct_megamenu > li.hover").hover(function() {
        if (0 == oct_menu_resp) {
            if (oct_a = $(this), oct_hov = !0, $("ul.oct_megamenu > li").removeClass("active"), $(this).addClass("active"), oct_real_link) {
                $(this).children(".sub-menu").css("left", "auto");
                var e = $(this).children(".sub-menu"),
                    t = ($(window).width(), $("body").outerWidth(), e.offset().left, e.outerWidth(), $(".horizontal ul.oct_megamenu"));
                $(window).width(), $("body").outerWidth(), t.offset().left, t.outerWidth(), e.offset().left < t.offset().left && $(this).children(".sub-menu").css("left", "0")
            } else $(this).children(".sub-menu").css("right", "auto"), e = $(this).children(".sub-menu"), $(window).width(), e.offset().left, e.outerWidth();
            var i = $(this).children("a").outerWidth() / 2,
                n = $(this).children("a").offset().left - $(this).find(".content").offset().left;
            $(this).find(".content > .arrow").css("left", n + i)
        }
    }, function() {
        if (0 == oct_menu_resp) {
            var e = $(this).attr("title");
            if (oct_hov = !1, "hover-intent" == e) {
                var t = $(this);
                setTimeout(function() {
                    0 == oct_hov && $(t).removeClass("active")
                }, 500)
            } else $(this).removeClass("active")
        }
    }), $(".categories-image-right ul > li > a").hover(function() {
        $(this).closest(".categories-image-right").find("img").attr("src", $(this).attr("data-image"))
    }, function() {
        var e = $(this).closest(".categories-image-right").attr("data-image");
        $(this).closest(".categories-image-right").find("img").attr("src", e)
    }), $("ul.oct_megamenu > li.click").click(function() {
        if (1 == $(this).removeClass("active")) return !1;
        if (oct_a = $(this), oct_hov = !0, $("ul.oct_megamenu > li").removeClass("active"), $(this).addClass("active"), oct_real_link) {
            $(this).children(".sub-menu").css("left", "auto");
            var e = $(this).children(".sub-menu"),
                t = $(window).width() - ($("body").outerWidth() - e.offset().left + e.outerWidth()),
                i = $(".horizontal ul.oct_megamenu");
            $(window).width(), $("body").outerWidth(), i.offset().left, i.outerWidth(), e.offset().left < i.offset().left && $(this).children(".sub-menu").css("left", "0")
        } else $(this).children(".sub-menu").css("right", "auto"), e = $(this).children(".sub-menu"), t = $(window).width() - (e.offset().left + e.outerWidth()), i = $(".horizontal ul.oct_megamenu"), $(window).width() - (i.offset().left + i.outerWidth()) > t && $(this).children(".sub-menu").css("right", "0");
        var n = $(this).children("a").outerWidth() / 2,
            o = $(this).children("a").offset().left - $(this).find(".content").offset().left;
        return $(this).find(".content > .arrow").css("left", o + n), !1
    }), $("html").on("click", function() {
        "yes" == oct_is_resp && $(window).width() < 992 || $("ul.oct_megamenu > li.click").removeClass("active")
    }), $("#oct_menu_header").click(function() {
        return "yes" == oct_is_resp && $(window).width() < 992 && (1 == $(this).hasClass("active") ? ($(this).parent().find(".megamenu-wrapper").stop(!0, !0).animate({
            height: "hide"
        }, 400), $(this).removeClass("active")) : ($(this).parent().find(".megamenu-wrapper").stop(!0, !0).animate({
            height: "toggle"
        }, 400), $(this).addClass("active"))), !1
    })
}), $(window).resize(function() {
    oct_menu_resp = !1, "yes" == oct_is_resp && $(window).width() < 992 && (oct_menu_resp = !0)
});
var updown = -1;
$(document).ready(function() {
	$(".mob-search-close").click(function() {
        return $("#mob-search-div").removeClass("opened"), $("html").removeClass("noscroll")
	 }),
    $("#search-toggle").click(function() {
        $("#mob-search-div").addClass("opened"), $("html").addClass("noscroll")
    }), $(".mob-search-submit").bind("click", function() {
        url = $("base").attr("href") + "index.php?route=product/search";
        var e = $("#mob-search-input").val();
        e && (url += "&search=" + encodeURIComponent(e)), $("#mob-search-input").val().length > 0 && (url += "&search=" + encodeURIComponent(e), location = url)
    }), $("#mob-search-div input[name='search-mobile']").bind("keydown", function(e) {
        if (13 == e.keyCode) {
            url = $("base").attr("href") + "index.php?route=product/search";
            var t = $("#mob-search-input").val();
            t && (url += "&search=" + encodeURIComponent(t)), $("#mob-search-input").val().length > 0 && (url += "&search=" + encodeURIComponent(t), location = url)
        }
    }), $("#search").find("[name=search]").first().keyup(function(e) {
        doLiveSearch(e, this.value)
    }), $(document).bind("keydown", function(e) {
        try {
            13 == e.keyCode && $(".highlighted").length > 0 && (document.location.href = $(".highlighted").find("a").first().attr("href"))
        } catch (e) {}
    })
});