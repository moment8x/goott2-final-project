/*  ---------------------------------------------------
    Template Name: Ogani
    Description:  Ogani eCommerce  HTML Template
    Author: Colorlib
    Author URI: https://colorlib.com
    Version: 1.0
    Created: Colorlib
---------------------------------------------------------  */

"use strict";

// 동적태그 드랍다운
function kor() {
  let output = `<ul><li><a href="#" style="font-weight: bold">국내도서 전체</a></li><li><a href="#">소설</a></li><li><a href="#">시/에세이</a></li><li><a href="#">인문</a></li><li><a href="#">가정/육아</a></li><li><a href="#">요리</a></li><li><a href="#">건강</a></li><li><a href="#">취미/실용/스포츠</a></li><li><a href="#">경제/경영</a></li><li><a href="#">자기계발</a></li><li><a href="#">정치/사회</a></li><li><a href="#">역사/문화</a></li></ul>`;
  output += `<ul style="padding-top: 60px"><li><a href="#">종교</a></li><li><a href="#">예술/대중문화</a></li><li><a href="#">중/고등참고서</a></li><li><a href="#">기술/공학</a></li><li><a href="#">외국어</a></li><li><a href="#">과학</a></li><li><a href="#">취섭/수험서</a></li><li><a href="#">여행</a></li><li><a href="#">컴퓨터/IT</a></li><li><a href="#">잡지</a></li><li><a href="#">청소년</a></li></ul>`;
  output += `<ul style="padding-top: 60px"><li><a href="#">초등 참고서</a></li><li><a href="#">유아(0~7세)</a></li><li><a href="#">어린이(초등)</a></li><li><a href="#">만화</a></li><li><a href="#">대학교재</a></li><li><a href="#">한국소개도서</a></li><li><a href="#">교보 오리지널</a></li></ul>`;
  $("#drop_in_category").html(output);
}
function eng() {
  let output = `<ul><li><a href="#"style="font-weight: bold;">해외도서 전체</a></li><li><a href="#">문학</a></li><li><a href="#">취미/실용/여행</a></li><li><a href="#">생활/요리/건강</a></li><li><a href="#">예술/건축</a></li><li><a href="#">인문/사회</a></li><li><a href="#">경제/경영</a></li><li><a href="#">과학/기술</a></li><li><a href="#">어린이ELT</a></li><li><a href="#">유아/아동/청소년</a></li><li><a href="#">한국관련도서</a></li><li><a href="#">문구/멀티/비도서</a></li></ul>`;
  output += `<ul style="padding-top: 60px"><li><a href="#">ELT/수험서</a></li><li><a href="#">프랑스도서</a></li><li><a href="#">독일도서</a></li><li><a href="#">스페인도서</a></li><li><a href="#">기타도서</a></li><li><a href="#">교재</a></li></ul>`;
  $("#drop_in_category").html(output);
}
function jap() {
  let output = `<ul><li><a href="#"style="font-weight: bold;">일본도서 전체</a></li><li><a href="#">잡지</a></li><li><a href="#">엔터테인먼트</a></li><li><a href="#">만화/애니</a></li><li><a href="#">문학</a></li><li><a href="#">라이트노벨</a></li><li><a href="#">문고</a></li><li><a href="#">신서</a></li><li><a href="#">아동</a></li><li><a href="#">실용서/예술</a></li><li><a href="#">인문/사회</a></li><li><a href="#">자연/기술과학</a></li></ul>`;
  output += `<ul style="padding-top: 60px">어학/학습</a></li><li><a href="#">문구/멀티/기타</a></li><li><a href="#">중국도서</a></li></ul>`;
  $("#drop_in_category").html(output);
}

(function ($) {
  /*------------------
        Preloader
    --------------------*/
  $(window).on("load", function () {
    $(".loader").fadeOut();
    $("#preloder").delay(200).fadeOut("slow");

    /*------------------
            Gallery filter
        --------------------*/
    $(".featured__controls li").on("click", function () {
      $(".featured__controls li").removeClass("active");
      $(this).addClass("active");
    });
    if ($(".featured__filter").length > 0) {
      var containerEl = document.querySelector(".featured__filter");
      var mixer = mixitup(containerEl);
    }
  });

  /*------------------
        Background Set
    --------------------*/
  $(".set-bg").each(function () {
    var bg = $(this).data("setbg");
    $(this).css("background-image", "url(" + bg + ")");
  });

  //Humberger Menu
  $(".humberger__open").on("click", function () {
    $(".humberger__menu__wrapper").addClass("show__humberger__menu__wrapper");
    $(".humberger__menu__overlay").addClass("active");
    $("body").addClass("over_hid");
  });

  $(".humberger__menu__overlay").on("click", function () {
    $(".humberger__menu__wrapper").removeClass(
      "show__humberger__menu__wrapper"
    );
    $(".humberger__menu__overlay").removeClass("active");
    $("body").removeClass("over_hid");
  });

  /*------------------
		Navigation
	--------------------*/
  $(".mobile-menu").slicknav({
    prependTo: "#mobile-menu-wrap",
    allowParentLinks: true,
  });

  /*-----------------------
        Categories Slider
    ------------------------*/
  $(".categories__slider").owlCarousel({
    loop: true,
    margin: 0,
    items: 4,
    dots: false,
    nav: true,
    navText: [
      "<span class='fa fa-angle-left'><span/>",
      "<span class='fa fa-angle-right'><span/>",
    ],
    animateOut: "fadeOut",
    animateIn: "fadeIn",
    smartSpeed: 1200,
    autoHeight: false,
    autoplay: true,
    responsive: {
      0: {
        items: 1,
      },

      480: {
        items: 2,
      },

      768: {
        items: 3,
      },

      992: {
        items: 4,
      },
    },
  });

  $(".hero__categories__all").on("click", function () {
    $(".hero__categories ul").slideToggle(400);
  });

  /*--------------------------
        Latest Product Slider
    ----------------------------*/
  $(".latest-product__slider").owlCarousel({
    loop: true,
    margin: 0,
    items: 1,
    dots: false,
    nav: true,
    navText: [
      "<span class='fa fa-angle-left'><span/>",
      "<span class='fa fa-angle-right'><span/>",
    ],
    smartSpeed: 1200,
    autoHeight: false,
    autoplay: true,
  });

  /*-----------------------------
        Product Discount Slider
    -------------------------------*/
  $(".product__discount__slider").owlCarousel({
    loop: true,
    margin: 0,
    items: 3,
    dots: true,
    smartSpeed: 1200,
    autoHeight: false,
    autoplay: true,
    responsive: {
      320: {
        items: 1,
      },

      480: {
        items: 2,
      },

      768: {
        items: 2,
      },

      992: {
        items: 3,
      },
    },
  });

  /*---------------------------------
        Product Details Pic Slider
    ----------------------------------*/
  $(".product__details__pic__slider").owlCarousel({
    loop: true,
    margin: 20,
    items: 4,
    dots: true,
    smartSpeed: 1200,
    autoHeight: false,
    autoplay: true,
  });

  /*-----------------------
		Price Range Slider
	------------------------ */
  var rangeSlider = $(".price-range"),
    minamount = $("#minamount"),
    maxamount = $("#maxamount"),
    minPrice = rangeSlider.data("min"),
    maxPrice = rangeSlider.data("max");
  rangeSlider.slider({
    range: true,
    min: minPrice,
    max: maxPrice,
    values: [minPrice, maxPrice],
    slide: function (event, ui) {
      minamount.val("$" + ui.values[0]);
      maxamount.val("$" + ui.values[1]);
    },
  });
  minamount.val("$" + rangeSlider.slider("values", 0));
  maxamount.val("$" + rangeSlider.slider("values", 1));

  /*--------------------------
        Select
    ----------------------------*/
  $("select").niceSelect();

  /*------------------
		Single Product
	--------------------*/
  $(".product__details__pic__slider img").on("click", function () {
    var imgurl = $(this).data("imgbigurl");
    var bigImg = $(".product__details__pic__item--large").attr("src");
    if (imgurl != bigImg) {
      $(".product__details__pic__item--large").attr({
        src: imgurl,
      });
    }
  });

  /*-------------------
		Quantity change
	--------------------- */
  var proQty = $(".pro-qty");
  proQty.prepend('<span class="dec qtybtn">-</span>');
  proQty.append('<span class="inc qtybtn">+</span>');
  proQty.on("click", ".qtybtn", function () {
    var $button = $(this);
    var oldValue = $button.parent().find("input").val();
    if ($button.hasClass("inc")) {
      var newVal = parseFloat(oldValue) + 1;
    } else {
      // Don't allow decrementing below zero
      if (oldValue > 0) {
        var newVal = parseFloat(oldValue) - 1;
      } else {
        newVal = 0;
      }
    }
    $button.parent().find("input").val(newVal);
  });
})(jQuery);
