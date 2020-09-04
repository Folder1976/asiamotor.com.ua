<div id="addcart-popup" class="white-popup mfp-with-anim">
	<h2 class="popup-header"><?php echo $heading_title; ?></h2>
	<div class="left">
		<div class="popup-text">
			<h3><?php echo $product_name; ?></h3>
			<p><?php echo $text_go_to_checkout; ?></p>
			<a class="popup-button" href="<?php echo $checkout_url; ?>"><?php echo $button_checkout; ?></a>
			<div class="cart-continue">
				<p><?php echo $text_continue_shopping; ?></p>
				<a class="popup-button" onclick="$.magnificPopup.close();"><?php echo $button_close; ?></a>
			</div>
		</div>
	</div>
	<div class="right">
		<div class="img-box">
			<div class="cart-sticker"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $text_already_in_the_basket; ?></div>
			<img src="<?php echo $product_thumb; ?>" alt="<?php echo $product_name; ?>" class="img-responsive" />
		</div>
	</div>
	<div class="clearfix"></div>
</div>