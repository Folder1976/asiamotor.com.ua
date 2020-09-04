<div id="quick-view" class="white-popup wide-popup mfp-with-anim">
  <h2 class="popup-header"><?php echo $heading_title; ?></h2>
  <?php if ($stock_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $stock_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="popup-text">
    <h3><?php echo $product_name; ?></h3>
  </div>
  <div id="content">
    <div class="row">
      <?php if ($oct_popup_view_data['image'] || $oct_popup_view_data['additional_image']) { ?>
      <?php if ($thumb || $images) { ?>
      <div class="col-md-7 col-sm-12 left-info">
          <ul class="thumbnails product-images">
          <?php if ($special) { ?>
              <li id="main-product-you-save">-<?php echo $economy; ?>%</li>
              <?php } ?>
          <?php if ($oct_popup_view_data['image'] && $thumb) { ?>
          <li class="product-sticker-box">
            <?php if ($oct_product_stickers) { ?>
                <?php foreach ($oct_product_stickers as $product_sticker) { ?>
                  <div style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;">
                    <?php echo $product_sticker['text']; ?>
                  </div>
                <?php } ?>
            <?php } ?>
              </li>
            <a class="thumbnail" href="<?php echo $view_product_link; ?>" title="<?php echo $product_name; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" id="popup-main-image" /></a>
          <?php } ?>
          </ul>
  		<?php if ($oct_popup_view_data['additional_image'] && $images) { ?>
  		<div id="image-additional">
            <div class="thumbnails all-carousel">
                <div>
                  <input type="radio" name="sub_images" value="<?php echo $thumb; ?>" id="sub-image-0" style="display: none;" />
                  <label title="<?php echo $product_name; ?>" for="sub-image-0"><img src="<?php echo $thumb; ?>" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" /></label>
                </div>
      		  <?php $img_key = 1; foreach ($images as $image) { ?>
                <div>
                  <input type="radio" name="sub_images" value="<?php echo $image['popup']; ?>" id="sub-image-<?php echo $img_key; ?>" style="display: none;" />
                  <label title="<?php echo $product_name; ?>" for="sub-image-<?php echo $img_key; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" /></label>
                </div>
                <?php $img_key++; } ?>
            </div>
  		</div>
  		<?php } ?>
  		<script>
  			  $(document).on('change', '#quick-view input[name=\'sub_images\']', function() {
  				$('#quick-view #popup-main-image').attr('src',$('#quick-view input[name=sub_images]:checked').val());
  			  });
  			  $(document).on('click', '#quick-view #image-additional .owl-wrapper .owl-item label', function() {
  				  $('#quick-view #image-additional .owl-wrapper .owl-item label').removeClass('label-active');
  				  $(this).toggleClass('label-active');
  			  });
  		</script>
      </div>
      <?php } ?>
      <?php } ?>
      <div class="col-md-5 col-sm-12">
      <div class="right-info">
        <ul class="list-unstyled">
          <?php if ($manufacturer) { ?>
          <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>" class="manufacturers"><?php echo $manufacturer; ?></a></li>
          <?php } ?>
          <li><?php echo $text_model; ?> <span class="gold"><?php echo $model; ?></span></li>
           <li class="stock<?php if(isset($quantity) && $quantity <= 0) { echo " minus"; } ?>"><i class="fa fa-circle" aria-hidden="true"></i> <?php echo $stock; ?></li>
      <?php if($oct_luxury_pr_shortdesc !='' && $description !='') { ?>
      <li class="short-desc"><?php echo utf8_substr(strip_tags(html_entity_decode($description, ENT_QUOTES, 'UTF-8')), 0, 120) . '..'; ?></li>
      <?php } ?>
        </ul>
        <div id="product_view">
          <?php if ($price) { ?>
          <ul class="list-unstyled price-ul">
            <li class="row">
              <?php if (!$special) { ?>
              <h2 class="price col-sm-6" id="popup-main-price"><?php echo $price; ?></h2>
              <?php } else { ?>
              <h2 class="price col-sm-6" id="popup-special-price"><?php echo $special; ?></h2>

              <p class="col-sm-6 price-old" style="text-decoration: line-through;" id="popup-main-price"><?php echo $price; ?></p>
              <?php } ?>
              <?php if ($tax) { ?>
              <li><?php echo $text_tax; ?> <span id="popup-main-tax"><?php echo $tax; ?></span></li>
              <?php } ?>
              <?php if ($points) { ?>
              <li><?php echo $text_points; ?> <?php echo $points; ?></li>
              <?php } ?>
              <?php if ($discounts) { ?>
              <li>
                <hr>
              </li>
              <?php foreach ($discounts as $discount) { ?>
              <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
              <?php } ?>
              <?php } ?>
            </li>
            <li class="row">
              <?php if (isset($oct_popup_found_cheaper_data['status']) && $oct_popup_found_cheaper_data['status']) { ?>
              <p class="col-sm-6 found-cheaper"><a data-effect="mfp-zoom-out" onclick="get_oct_popup_found_cheaper('<?php echo $product_id; ?>');"><?php echo $text_oct_popup_found_cheaper; ?></a></p>
              <?php } ?>
            </li>
          </ul>
          <?php } ?>
          <div class="form-group buy-box">
            <form method="post" enctype="multipart/form-data" id="view-form">
            <?php if ($options) { ?>
            <hr>
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <?php if (isset($oct_images_by_options_data['status']) && $oct_images_by_options_data['status']) { ?>
              <select onchange="oct_update_prices_opt();" name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
              <?php } else { ?>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
              <?php } ?>
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>" <?php if (!$option_value['quantity_status']) { ?>disabled="disabled"<?php } ?>><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <?php if ($option_value['image']) { ?>
                	<div class="radio radio-img">
	                  <?php if ($option_value['quantity_status']) { ?>
						  <label data-toggle="tooltip" data-trigger="hover" title="<?php echo $option['name']; ?> <?php echo $option_value['name']." "; if ($option_value['price']) { ?><?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?><?php } ?>" class="not-selected-img optmid-<?php echo $option['option_id'];?>">
                    <?php } else { ?>
                      <label data-toggle="tooltip" data-trigger="hover" title="<?php echo $text_option_disable; ?>" class="not-selected-img optmid-<?php echo $option['option_id'];?>" style="opacity:0.2;cursor:default;">
                    <?php } ?>
	                    <?php if ($option_value['quantity_status']) { ?>
		                    <?php if (isset($oct_images_by_options_data['status']) && $oct_images_by_options_data['status']) { ?>
		                    <input onchange="oct_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" />
		                    <?php } else { ?>
		                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" />
		                    <?php } ?>
		                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
	                    <?php } else { ?>
	                    	<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" disabled="disabled" />
		                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
	                    <?php } ?>
	                  </label>
	                </div>
                <?php } else { ?>
	                <div class="radio">
	                  <?php if ($option_value['quantity_status']) { ?>
	                    <label data-toggle="tooltip" data-trigger="hover" title="<?php echo $option['name']; ?> <?php echo $option_value['name']." "; if ($option_value['price']) { ?><?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?><?php } ?>" class="not-selected optid-<?php echo $option['option_id'];?>">
	                  <?php } else { ?>
	                    <label data-toggle="tooltip" data-trigger="hover" title="<?php echo $text_option_disable; ?>" class="not-selected optid-<?php echo $option['option_id'];?>" style="opacity:0.5;cursor:default;">
	                  <?php } ?>
	                    <?php if ($option_value['quantity_status']) { ?>
	                      <?php if (isset($oct_images_by_options_data['status']) && $oct_images_by_options_data['status']) { ?>
	                      <input onchange="oct_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" />
	                      <?php } else { ?>
	                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" />
	                      <?php } ?>
	                    <?php } else { ?>
	                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" disabled="disabled" />
	                    <?php } ?>
	                    <?php echo $option_value['name']; ?>
	                  </label>
	                </div>
                <?php } ?>
                <?php } ?>
                <div class="clearfix"></div>
              </div>
            </div>
            	<script>
	              $(document).ready(function() {
	                 $('#quick-view label.optmid-<?php echo $option['option_id'];?>').click(function(){
	                   if ($(this).find('#quick-view input[type=radio]').is('input:disabled')) {
	                    $('#quick-view label.selected-img').removeClass('selected-img').addClass('not-selected-img');
	                    $(this).css({
	                      'opacity': 0.2,
	                      'cursor': 'default'
	                    });
	                   } else {
	                    $('#quick-view label.optmid-<?php echo $option['option_id'];?>').removeClass('selected-img').addClass('not-selected-img');
	                    $(this).removeClass('not-selected-img').addClass('selected-img');
	                   }
	                 });
	              });
	            </script>
	            <script>
	              $(document).ready(function() {
	                 $('#quick-view label.optid-<?php echo $option['option_id'];?>').click(function(){
	                   if ($(this).find('#quick-view input[type=radio]').is('input:disabled')) {
	                    $('#quick-view label.selected').removeClass('selected').addClass('not-selected');
	                    $(this).css({
	                      'opacity': 0.5,
	                      'cursor': 'default'
	                    });
	                   } else {
	                    $('#quick-view label.optid-<?php echo $option['option_id'];?>').removeClass('selected').addClass('not-selected');
	                    $(this).removeClass('not-selected').addClass('selected');
	                   }
	                 });
	              });
	            </script>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <label <?php if (!$option_value['quantity_status']) { ?>style="opacity:0.5;cursor:default;" title="<?php echo $text_option_disable; ?>"<?php } ?>>
                    <?php if ($option_value['quantity_status']) { ?>
                      <?php if (isset($oct_images_by_options_data['status']) && $oct_images_by_options_data['status']) { ?>
                      <input onchange="oct_update_prices_opt();" type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <?php } else { ?>
                      <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <?php } ?>
                    <?php } else { ?>
                      <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" disabled="disabled" />
                    <?php } ?>
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
                    <?php } ?>
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
          <?php } ?>
          <?php if ($option['type'] == 'text') { ?>
          <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
            <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          </div>
          <?php } ?>
          <?php if ($option['type'] == 'textarea') { ?>
          <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
            <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
            <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
          </div>
          <?php } ?>
          <?php if ($option['type'] == 'file') { ?>
          <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
            <label class="control-label"><?php echo $option['name']; ?></label>
            <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="popup-input-option<?php echo $option['product_option_id']; ?>" />
          </div>
          <?php } ?>
          <?php if ($option['type'] == 'date') { ?>
          <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
            <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
            <div class="input-group date">
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
              </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
            <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
            <div class="input-group datetime">
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
              </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
            <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
            <div class="input-group time">
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
              </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            <br/>
            <?php } ?>
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="popup-recurring-description"></div>
            </div>
            <?php } ?>
            <div class="oct-product-buttons-box">
            <?php if ($oct_popup_view_data['quantity']) { ?>
            <div class="number">
              <div class="frame-change-count">
                <div class="btn-minus">
                  <button type="button" id="superminus" onclick="$(this).parent().next().val(~~$(this).parent().next().val()-1); popup_update_prices('<?php echo $product_id; ?>');" class="main-color1">
                    <span class="icon-minus"><i class="fa fa-minus"></i></span>
                  </button>
                </div>
              <input type="text" name="quantity" value="<?php echo $minimum; ?>" maxlength="3" class="plus-minus" onchange="popup_update_prices('<?php echo $product_id; ?>'); return validate(this);" keypress="popup_update_prices('<?php echo $product_id; ?>'); return validate(this);">
                <div class="btn-plus">
                  <button type="button" id="superplus" onclick="$('.plus-minus').val(~~$('.plus-minus').val()+1); popup_update_prices('<?php echo $product_id; ?>');" class="main-color1">
                    <span class="icon-plus"><i class="fa fa-plus"></i></span>
                  </button>
                </div>
              </div>
            </div>
            <?php } else { ?>
            <input type="hidden" name="quantity" value="<?php echo $minimum; ?>" />
            <?php } ?>
            <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_cart; ?></button>
            <?php if ($oct_popup_view_data['wishlist']) { ?>
            <button type="button" class="wishlist-btn" data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_wishlist('<?php echo $product_id; ?>');" title="<?php echo $button_wishlist; ?>"><i class="fa fa-heart"></i></button>
            <?php } ?>
            <?php if ($oct_popup_view_data['compare']) { ?>
            <button type="button" class="compare-btn" data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_compare('<?php echo $product_id; ?>');" title="<?php echo $button_compare; ?>"><i class="fa fa-sliders" aria-hidden="true"></i></button>
            <?php } ?>
            </div>
            <?php if (isset($oct_popup_purchase_data['status']) && $oct_popup_purchase_data['status']) { ?>
            <br>
            <div class="buy-in-click"><i class="fa fa-hand-pointer-o"></i> <a data-effect="mfp-zoom-out" onclick="get_oct_popup_purchase('<?php echo $product_id; ?>');"><?php echo $text_oct_popup_purchase; ?></a></div>
            <?php } ?>
            <hr>
            <input name="product_id" value="<?php echo $product_id; ?>" style="display: none;" type="hidden">
            </form>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>

            <?php if($oct_luxury_pr_garantedtext != "" && (isset($oct_popup_view_data['advantages']) && $oct_popup_view_data['advantages'])) { echo $oct_luxury_pr_garantedtext; } ?>
          </div>
        </div>
      </div>
    </div>
    </div>
    <div class="row tabs-row">
      <div class="col-sm-12">
        <ul class="nav nav-tabs">
          <?php if ($oct_popup_view_data['description']) { ?>
          <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
          <?php } ?>
          <?php if ($oct_popup_view_data['specification'] && $attribute_groups) { ?>
          <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
          <?php } ?>
          <?php if ($oct_popup_view_data['review'] && $review_status) { ?>
          <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
          <?php } ?>
          <?php if ($oct_product_extra_tabs) { ?>
            <?php $tab_i=0; foreach ($oct_product_extra_tabs as $product_extra_tab) { ?>
              <li><a href="#tab-extra-<?php echo $tab_i; ?>" data-toggle="tab"><?php echo $product_extra_tab['title']; ?></a></li>
            <?php $tab_i++; } ?>
          <?php } ?>
        </ul>
        <div class="tab-content">
          <?php if ($oct_popup_view_data['description']) { ?>
          <div class="tab-pane active" id="tab-description">
            <div class="cpt_product_description"><?php echo $description; ?></div>
          </div>
          <?php } ?>
          <?php if ($oct_popup_view_data['specification'] && $attribute_groups) { ?>
          <div class="tab-pane" id="tab-specification">
            <table class="table table-bordered">
              <?php foreach ($attribute_groups as $attribute_group) { ?>
              <thead>
                <tr>
                  <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                <tr>
                  <td><?php echo $attribute['name']; ?></td>
                  <td><?php echo $attribute['text']; ?></td>
                </tr>
                <?php } ?>
              </tbody>
              <?php } ?>
            </table>
          </div>
          <?php } ?>
          <?php if ($oct_popup_view_data['review'] && $review_status) { ?>
          <div class="tab-pane" id="tab-review">
            <form class="form-horizontal" id="form-review">
              <div id="review"></div>
              <h2><?php echo $text_write; ?></h2>
              <?php if ($review_guest) { ?>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                  <input type="text" name="name" value="" id="input-name" class="form-control" />
                </div>
              </div>
              <?php if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) { ?>
              <div class="form-group">
                <div class="col-sm-12">
                  <label class="control-label" for="input-positive_text"><?php echo $entry_positive_text; ?></label>
                  <textarea name="positive_text" rows="4" id="input-positive_text" class="form-control"></textarea>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-12">
                  <label class="control-label" for="input-negative_text"><?php echo $entry_negative_text; ?></label>
                  <textarea name="negative_text" rows="4" id="input-negative_text" class="form-control"></textarea>
                </div>
              </div>
              <input type="hidden" name="where_bought" value="1" />
              <?php } ?>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                  <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                  <div class="help-block"><?php echo $text_note; ?></div>
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label"><?php echo $entry_rating; ?></label>
                  <select id="popup-ratingme" name="rating">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                  </select>
                  <script>
                   $(function() {
                    $('#quick-view #popup-ratingme').barrating({
                      theme: 'fontawesome-stars'
                    });
                  });
                </script>
              </div>
            </div>
            <?php if ($site_key) { ?>
            <div class="form-group">
              <div class="col-sm-12">
                <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
              </div>
            </div>
            <?php } ?>
            <?php if ($text_terms) { ?>
              <div>
                <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;display:inline-block;margin: 0;" />
              </div>
            <?php } ?>
            <div class="buttons clearfix">
              <div class="pull-right">
                <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
              </div>
            </div>
            <?php } else { ?>
            <?php echo $text_login; ?>
            <?php } ?>
          </form>
        </div>
        <?php } ?>
        <?php if ($oct_product_extra_tabs) { ?>
          <?php $tab_i=0; foreach ($oct_product_extra_tabs as $product_extra_tab) { ?>
            <div class="tab-pane" id="tab-extra-<?php echo $tab_i; ?>"><?php echo $product_extra_tab['text']; ?></div>
          <?php $tab_i++; } ?>
        <?php } ?>
        </div>
      </div>
    </div>
  </div>
  <button title="Close (Esc)" type="button" class="mfp-close" onclick="$.magnificPopup.close();">×</button>
  <div class="clearfix"></div>
<?php if ($options) { ?>
<script src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script>
<script src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<link href="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<script><!--
  $('#quick-view .date').datetimepicker({
    pickTime: false,
  });
   $('#quick-view .datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });
   $('#quick-view .time').datetimepicker({
    pickDate: false,
  });
   $(document).on('click', '#quick-view button[id^=\'button-upload\']', function() {
    var node = this;
    $('#quick-view #form-upload').remove();
    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
    $('#quick-view #form-upload input[name=\'file\']').trigger('click');
    if (typeof timer != 'undefined') {
      clearInterval(timer);
    }
    timer = setInterval(function() {
      if ($('#quick-view #form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);
        $.ajax({
          url: 'index.php?route=tool/upload',
          type: 'post',
          dataType: 'json',
          data: new FormData($('#quick-view #form-upload')[0]),
          cache: false,
          contentType: false,
          processData: false,
          beforeSend: function() {
            $(node).button('loading');
          },
          complete: function() {
            $(node).button('reset');
          },
          success: function(json) {
            $('#quick-view .text-danger').remove();
            if (json['error']) {
              $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            }
            if (json['success']) {
              alert(json['success']);
              $(node).parent().find('input').attr('value', json['code']);
            }
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
      }
    }, 500);
  });
  //--></script>
<?php } ?>
<script><!--
  $('#quick-view .image-additional').delay(240).css({ 'opacity': '1'});

  function masked(element, status) {
    if (status == true) {
      $('<div/>')
      .attr({ 'class':'masked' })
      .prependTo(element);
      $('<div class="masked_loading" />').insertAfter($('.masked'));
    } else {
      $('.masked').remove();
      $('.masked_loading').remove();
    }
  }

  <?php if ($oct_popup_view_data['quantity']) { ?>
    function validate(input) {
      input.value = input.value.replace(/[^\d,]/g, '');
    }
    function popup_update_prices(product_id) {
      masked('#quick-view', true);
      var input_val = $('#quick-view').find('input[name=quantity]').val();
      var quantity = parseInt(input_val);
      <?php if ($minimum > 1) { ?>
        if (quantity < <?php echo $minimum; ?>) {
          quantity = $('#quick-view').find('input[name=quantity]').val(<?php echo $minimum; ?>);
          masked('#quick-view', false);
          return;
        }
      <?php } else { ?>
        if (quantity == 0) {
          quantity = $('#quick-view').find('input[name=quantity]').val(1);
          masked('#quick-view', false);
          return;
        }
      <?php } ?>
      $.ajax({
        url: 'index.php?route=extension/module/oct_popup_view/update_prices&product_id=' + product_id + '&quantity=' + quantity,
        type: 'post',
        dataType: 'json',
        data: $('#quick-view #view-form').serialize(),
        success: function(json) {
          $('#quick-view #popup-main-price').html(json['price']);
          $('#quick-view #popup-special-price').html(json['special']);
          $('#quick-view #popup-main-tax').html(json['tax']);
          $('#quick-view #popup-you-save').html(json['you_save']);
          masked('#quick-view', false);
        }
      });
    }
  <?php } else { ?>
    function popup_update_prices(product_id) {}
    function validate(input) {}
  <?php } ?>
  <?php if (isset($oct_images_by_options_data['status']) && $oct_images_by_options_data['status']) { ?>
  $(function() {
    <?php if ($minimum > 1) { ?>
      oct_update_prices_opt();
    <?php } ?>
  });

  function oct_update_prices_opt() {
    masked('#quick-view', true);
      $.ajax({
        type: 'post',
        url:  'index.php?route=product/product/update_prices',
        data: $('#quick-view #view-form').serialize(),
        dataType: 'json',
        success: function(json) {
          $('#quick-view #popup-main-price').html(json['price']);
          $('#quick-view #popup-special-price').html(json['special']);
          $('#quick-view #popup-main-tax').html(json['tax']);
          $('#quick-view #popup-you-save').html(json['you_save']);
          masked('#quick-view', false);
        }
      });
    }
  <?php } ?>
  $('#quick-view #button-cart').on('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/cart/add',
      type: 'post',
      data: $('#quick-view #product_view input[type=\'text\'], #quick-view #product_view input[type=\'hidden\'], #quick-view #product_view input[type=\'radio\']:checked, #quick-view #product_view input[type=\'checkbox\']:checked, #quick-view #product_view select, #quick-view #product_view textarea'),
      dataType: 'json',
      beforeSend: function() {
        $('#quick-view #button-cart').button('loading');
      },
      complete: function() {
        $('#quick-view #button-cart').button('reset');
      },
      success: function(json) {
        $('#quick-view .alert, #quick-view .text-danger').remove();
        $('#quick-view .form-group').removeClass('has-error');
        $('#quick-view .success, #quick-view .warning, #quick-view .attention, #quick-view .information, #quick-view .error').remove();
        if (json['error']) {
          if (json['error']['option']) {
            for (i in json['error']['option']) {
              $('#quick-view #input-option' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
            }
          }
          if (json['error']['recurring']) {
            $('#quick-view select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
          }
          // Highlight any found errors
          $('#quick-view .text-danger').parent().addClass('has-error');
        }
        if (json['success']) {
          $.magnificPopup.open({
            tLoading: '<img src="catalog/view/theme/oct_luxury/image/ring-alt.svg" />',
            items: {
              src: 'index.php?route=extension/module/oct_popup_add_to_cart&product_id=<?php echo $product_id; ?>',
              type: 'ajax'
            },
            midClick: true,
            removalDelay: 200
          });
          $('#cart-total').html(json['total']);
          $('#cart > ul').load('index.php?route=common/cart/info ul li');
        }
      }
    });
  });
  <?php if ($oct_popup_view_data['review']) { ?>
    $('#quick-view #review').delegate('.pagination a', 'click', function(e) {
      e.preventDefault();
      $('#quick-view #review').fadeOut('slow');
      $('#quick-view #review').load(this.href);
      $('#quick-view #review').fadeIn('slow');
    });
    $('#quick-view #review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
    $('#quick-view #button-review').on('click', function() {
      $.ajax({
        url: 'index.php?route=extension/module/oct_popup_view/write&product_id=<?php echo $product_id; ?>',
        type: 'post',
        dataType: 'json',
        data: $("#form-review").serialize(),
        beforeSend: function() {
          $('#quick-view #button-review').button('loading');
        },
        complete: function() {
          $('#quick-view #button-review').button('reset');
        },
        success: function(json) {
          $('#quick-view .alert-success, #quick-view .alert-danger').remove();
          if (json['error']) {
            $('#quick-view #review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
          }
          if (json['success']) {
            $('#quick-view #review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
            $('#quick-view input[name=\'name\']').val('');
            $('#quick-view textarea[name=\'text\']').val('');
            $('#quick-view textarea[name=\'positive_text\']').val('');
            $('#quick-view textarea[name=\'negative_text\']').val('');
            $('#quick-view input[name=\'rating\']:checked').prop('checked', false);
            $('#quick-view input[name=\'terms\']:checked').prop('checked', false);
          }
        }
      });
    });
  <?php } ?>
  //--></script>
  <script><!--
    $('#quick-view select[name=\'recurring_id\'], #quick-view input[name="quantity"]').change(function(){
      $.ajax({
        url: 'index.php?route=product/product/getRecurringDescription',
        type: 'post',
        data: $('#quick-view input[name=\'product_id\'], #quick-view input[name=\'quantity\'], #quick-view select[name=\'recurring_id\']'),
        dataType: 'json',
        beforeSend: function() {
          $('#quick-view #popup-recurring-description').html('');
        },
        success: function(json) {
          $('#quick-view .alert, #quick-view .text-danger').remove();
          if (json['success']) {
            $('#quick-view #popup-recurring-description').html(json['success']);
          }
        }
      });
    });
  //--></script>
  <script>
  $('#product_view .radio-img').on('change', function() {
    $.ajax({
      url: 'index.php?route=product/product/getPImages&product_id=<?php echo $product_id; ?>' + '&image_width=<?php echo $image_width;?>&image_height=<?php echo $image_height;?>&image_additional_width=<?php echo $image_additional_width;?>&image_additional_height=<?php echo $image_additional_height;?>',
      type: 'post',
      data: $('#product_view input[type=\'radio\']:checked, #product_view input[type=\'checkbox\']:checked, #product_view select'),
      dataType: 'json',
      success: function(json) {
        var items2 = [];
        var img_key = 0;
        if (json['images']) {
          var patterns  = '<div class="thumbnails all-carousel">';
          $.each(json['images'], function(i,val) {
            patterns += '<div>';
            patterns += '<input type="radio" name="sub_images" value="'+val['popup']+'" id="sub-image-'+ img_key +'" style="display: none;" />';
            patterns += '<label title="<?php echo $product_name; ?>" for="sub-image-'+ img_key +'"><img src="'+val['thumb']+'" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" /></label>';
            patterns += '</div>';

            img_key++;
          });

          patterns += '</div>';
        }

        $('#quick-view #image-additional').html(patterns);

        $("#quick-view #image-additional .all-carousel").owlCarousel({
            items: 5,
            itemsDesktop : [1921,4],
            itemsDesktop : [1199,4],
            itemsDesktopSmall : [979,4],
            itemsTablet : [768,4],
            itemsMobile : [479,4],
            autoPlay: false,
            navigation: true,
            slideMargin: 10,
            navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
            stopOnHover:true,
            smartSpeed: 800,
            loop: true,
            pagination: false
        });

        $('#quick-view #image-additional .owl-wrapper .owl-item label:first').click();
      }
    });
  });
</script>
<script>
$(function() {
    $("#quick-view #image-additional .all-carousel").owlCarousel({
        items: 5,
        itemsDesktop : [1921,4],
        itemsDesktop : [1199,4],
        itemsDesktopSmall : [979,4],
        itemsTablet : [768,4],
        itemsMobile : [479,4],
        autoPlay: false,
        navigation: true,
        slideMargin: 10,
        navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
        stopOnHover:true,
        smartSpeed: 800,
        loop: true,
        pagination: false
    });
    
    	$('[data-toggle=\'tooltip\']').tooltipster({theme: 'tooltipster-shadow',
		trigger: 'custom',
		animation: 'fade',
		delay: 200,
		triggerOpen: {
			mouseenter: true,
			touchstart: true
		},
		triggerClose: {
			click: true,
			scroll: true,
			tap: true,
			mouseleave: true
		}
	});
    
});
</script>
<?php if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) { ?>
<script>
  function review_reputation(review_id, reputation_type) {
    $.ajax({
      url: 'index.php?route=product/product/oct_review_reputation&review_id='+review_id+'&reputation_type='+reputation_type,
      dataType: 'json',
      success: function(json) {
        $('#quick-view #form-review .alert-success, #quick-view #form-review .alert-danger').remove();

        if (json['error']) {
          alert(json['error']);
        }

        if (json['success']) {
          alert(json['success']);
          $('#quick-view #review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
        }
      }
    });
  }
</script>
<?php } ?>
</div>
