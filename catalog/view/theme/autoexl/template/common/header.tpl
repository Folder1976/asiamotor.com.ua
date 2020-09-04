<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title;  ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>

<meta property="og:site_name" content="<?php echo $name; ?>" />
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:300italic,400italic,700italic,400,300,700&subset=cyrillic-ext,latin' rel='stylesheet' type='text/css'>
<link href="catalog/view/theme/autoexl/stylesheet/stylesheet.css" rel="stylesheet">
<link href="catalog/view/javascript/jquery/magnific/magnific-popup.css" type="text/css" rel="stylesheet" media="screen" />
<link href="https://fonts.googleapis.com/css?family=PT+Serif&display=swap" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/common.js"></script>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
</head>
<body class="<?php echo $class; ?>">
<nav id="top">
  <div class="container">
	<?php echo $language; ?>
    <?php echo $currency; ?>
    <div id="top-links" class="nav pull-left">
      <ul class="list-inline">
        <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
        <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_shopping_cart; ?></span></a></li>
        <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_checkout; ?></span></a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="site_wrap">
  <style>
    .header-links{
      columns: 2;
      -webkit-columns: 2;
      -moz-columns: 2;
      list-style-type: none;
    }
  </style>
<header>
  <div class="container">
    <div class="row">
      <div class="col-lg-2 col-sm-6 col-xs-mobile">
        <div id="logo">
          <?php if ($logo) { ?>
            <?php if ($home == $og_url) { ?>
              <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
            <?php } else { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
            <?php } ?>
          <?php } else { ?>
            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
          <?php } ?>
        </div>
      </div>

      <div class="col-lg-4 col-sm-6 col-xs-mobile">
        <ul class="header-links">
          <li>
            <a href="/about_us">О нас</a>
          </li>
          <li>
            <a href="/delivery">Доставка/Оплата</a>
          </li>
          <li>
            <a href="/contact-us/">Контакты</a>
          </li>
          <li>
            <a href="/news">Новости</a>
          </li>
          <li>
            <a href="/blogs">Статьи(блог)</a>
          </li>
          <li>
            <a href="/garanty">Гарания/Возврат</a>
          </li>
        </ul>
      </div>
      <div class="col-lg-4 col-sm-6 col-xs-mobile">
        <?php echo $search; ?>
        <ul class="list-inline">
          <li class="dropdown">
            <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class=""><?php echo $text_account; ?></span> <span class="caret"></span></a>
            <ul class="dropdown-menu">
              <?php if ($logged) { ?>
              <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
              <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
              <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
              <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
              <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
              <?php } else { ?>
              <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
              <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
              <?php } ?>
            </ul>
          </li>
        </ul>
      </div>
      <!--div class="col-lg-3 col-sm-4 col-xs-mobile col-xs-mobile-adr">
        
                <div class="top_adress"><?php echo $address; ?></div>
                
      </div-->
      <div class="col-lg-2 col-sm-4 col-xs-mobile">
        <div class="top_contact">
          <div class="top_phone"><a href="tel:<?php echo str_replace(" ","",$telephone); ?>"><?php echo $telephone; ?></a></div>
          
                <div class="top_email"><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></div>
                
        </div>
      </div>
      <div class="col-lg-3 col-sm-4 top_cart"><?php echo $cart; ?><a href="#select_car_mob" class="select_car_mob_btn btn btn-block">Выбрать авто</a></div>
    </div>
  </div>
</header>
<style>
 .price_key a{
   color: white;
 }
 .price_key a:hover{
   color: #E00000;
 }
 .price_key{
    z-index: 10;
    position: relative;
    color: white;
    font-weight: bold;
    top: 70px;
    left: 75px;
    border: 1px solid;
    padding: 5px 15px;
    cursor: pointer;
 }
 .price_key:hover{
      background-color: #eee;
      color: #E00000;
 }
 
 .price_key_mobile{
    background: #0f97cb;
    background: url(/catalog/view/theme/autoexl/image/menu_ul_white.png);
    color: #fff;
    font-weight: 700;
    height: 38px;
    line-height: 38px;
    margin-bottom: 15px;
 }
 .price_key_mobile a{
    color: white;
    font-weight: bold;
 }
 
 @media (max-width: 1200px){
   .price_key {
      display: none;
   }
 @media (min-width: 765px){
   .price_key_mobile {
      display: none;
   }
}
 
</style>
<?php if (true or $categories) { ?>
<div class="container">
  <nav id="menu" class="navbar">
    <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
      <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
    </div>

    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <span class="price_key"><a href="/export/Asia_Motor_price_current_stock.xls"><?php echo $text_price_download; ?></a></span>
      <ul class="nav navbar-nav">
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['children']) { ?>
        <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
          <div class="dropdown-menu">
            <div class="dropdown-inner">
              <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
              <ul class="list-unstyled">
                <?php foreach ($children as $child) { ?>
                <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                <?php } ?>
              </ul>
              <?php } ?>
            </div>
            <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?></a> </div>
        </li>
        <?php } else { ?>
        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
        
      </ul>
    </div>
  </nav>
</div>
<?php } ?>

<div class="container car-mobile-select">
  <nav id="menu" class="navbar">
    <div class="navbar-header"><span id="category" class="visible-xs">Выбрать авто</span>
      <button type="button" class="btn btn-navbar navbar-toggle car-mobile-key" data-toggle="collapse" data-target=".navbar-ex1-collapse-car">
        <i class="fa fa-bars"></i></button>
    </div>
  </nav>
</div>

<div class="container">
 <div class="col-lg-3 col-sm-4 price_key_mobile">
  <a href="/export/Asia_Motor_price_current_stock.xls" class=" btn btn-block"><?php echo $text_price_download; ?></a>
 </div>
</div>

<style>
  #column-left .in{
    opacity: 1!important;
  }
  .car-mobile-select{
   display: none;
  }
 .select_car_wrapper{
  /*display: block;*/
 }
/* @media (max-width: 767px){
  .select_car_wrapper{
    opacity: 0;
    position: absolute;
    z-index: 100 !important;
    background-color: white !important;
    width: calc(100% - 30px) !important;
  }
  .car-mobile-select{
    display: none;
  }
  #column-left .box{
    display: none!important; 
  }
  #column-left .owl-carousel{
    display: none!important; 
  }
  #column-left {
    display: block!important; 
  }
 #column-left .select_car_wrapper{
    display: block!important; 
  }
  .car-mobile-select{
    display: block!important; 
  }
}*/
</style>
<script>
  $(document).ready(function(){
   /*
    $('.car-mobile-key').trigger('click');
    setTimeout(function(){
      $('.car-mobile-key').trigger('click');}
      ,400);
      */
  });
</script>