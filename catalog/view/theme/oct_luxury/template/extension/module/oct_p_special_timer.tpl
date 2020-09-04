<?php if ($products) { ?>
<div class="container">
  <div class="row">
    <div class="goods-of-day">
     <div class="carousel-module-row-header"><?php echo $heading_title; ?></div>
      <div id="goods-of-day" class="owl-carousel owl-theme">
        <?php foreach ($products as $product) { ?>            
          <div class="item">
            <?php if ($product['oct_product_stickers']) { ?>
              <div class="cat-sticker-box">
                <?php foreach ($product['oct_product_stickers'] as $product_sticker) { ?>
                  <div style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;">
                    <?php echo $product_sticker['text']; ?>
                  </div>
                <?php } ?>
              </div>
            <?php } ?>  
            <?php if ($product['thumb']) { ?>
              <div class="image">
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name'] ?>" /></a>
              </div> 
            <?php } ?>
            <div class="name">
            <a href="<?php echo $product['href']; ?>"><?php echo $product['name'] ?></a>
            </div>
            
            <?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                  <span class="price-new"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                <?php } ?>
              </div>
            <?php } ?>
            <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <i class="fa fa-star-o" aria-hidden="true"></i>
                <?php } else { ?>
                <i class="fa fa-star" aria-hidden="true"></i>
                <?php } ?>
                <?php } ?>
              </div>
            <?php } ?>
            <div class="cart">
              <a class="button-cart" title="<?php echo $button_cart_time; ?>" data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_cart('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_cart_time; ?></a>
            </div> 
            <div id="clock-<?php echo $product['product_id']; ?>"></div>
            <script>
            $(document).ready(function() {
              var futureDate  = new Date("<?php echo $product['date_end']; ?> 00:00:00".replace(/-/g, "/"));
              var currentDate = new Date("<?php echo date("Y-m-d H:i:s"); ?>".replace(/-/g, "/"));
              var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;
              function dayDiff(first, second) {
                return (second-first)/(1000*60*60*24);
              }
              if (dayDiff(currentDate, futureDate) < 100) {
                $('.clock').addClass('twoDayDigits');
              } else {
                $('.clock').addClass('threeDayDigits');
              }
              if(diff < 0) {
                diff = 0;
              }
              clock = $('#clock-<?php echo $product['product_id']; ?>').FlipClock(diff, {
                clockFace: 'DailyCounter',
                countdown: true,
                language: '<?php echo $language_code; ?>'
              });
            });
            </script>
          </div>  
        <?php } ?>         
      </div>
      <i class="fa fa-diamond" aria-hidden="true"></i>
    </div>
  </div>
</div>
<script>
$('#goods-of-day').owlCarousel({
  items: 2,
  itemsDesktop : [1199,2],
  itemsDesktopSmall : [979,2],
  autoPlay: false,
  navigation: true,
  slideMargin: 10,
  navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
  stopOnHover:true,
  smartSpeed: 800,
  loop: true,
  pagination: false
});
</script>
<!-- ********** End of товары дня ********** -->
<?php } ?>