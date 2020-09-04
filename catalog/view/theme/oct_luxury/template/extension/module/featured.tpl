<!-- ********** New ********** -->
<?php if($position == "column_left" OR $position == "column_right") { ?>
	<div class="carousel-module-container">
<?php } else { ?>
	<div class="container carousel-module-container">
<?php } ?>	
  <div class="row carousel-module-row">
    <div class="carousel-module-row-header"><?php echo $heading_title; ?></div>
    <div id="owl-carousel-module-featured" class="owl-carousel owl-theme">
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
                <span class="price-old"><?php echo $product['price']; ?></span><br/><span class="price-new"><?php echo $product['special']; ?></span>
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
            <?php if ($product['quantity'] > 0) { ?>
           		<a class="button-cart" title="<?php echo $button_cart; ?>" onclick="get_oct_popup_add_to_cart('<?php echo $product['product_id']; ?>', '1');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_cart; ?></a>
						<?php } else { ?>
							<a class="out-of-stock-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_oct_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><?php echo $product['product_preorder_text']; ?></a>
						<?php } ?>
               <?php if (isset($oct_popup_view_data['status']) && $oct_popup_view_data['status'] && $product['quantity'] > 0) { ?>
	            <a data-effect="mfp-zoom-out" onclick="get_oct_popup_product_view('<?php echo $product['product_id']; ?>');" title="<?php echo $button_popup_view; ?>" class="more"><i class="fa fa-eye" aria-hidden="true"></i></a>
	            <?php } else { ?>
		        <a href="<?php echo $product['href']; ?>" title="<?php echo $button_popup_view; ?>" class="more"><i class="fa fa-eye" aria-hidden="true"></i></a>    
		        <?php } ?>   
            <a data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist"><i class="fa fa-heart" aria-hidden="true"></i></a>
            <a data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_compare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="compare"><i class="fa fa-sliders" aria-hidden="true"></i></a>
          </div> 
        </div>  
      <?php } ?>       
    </div>
  </div>
</div>
<script>
$('#owl-carousel-module-featured').owlCarousel({
	items: <?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>,
	itemsDesktop : [1199,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 3; } ?>],
	itemsDesktopSmall : [979,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 2; } ?>],
	itemsMobile : [480,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 1; } ?>],
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
<!-- ********** End of new ********** -->