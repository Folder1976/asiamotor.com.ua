<?php echo $header; ?>
<div class="container">
 <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $count=> $breadcrumb) { ?>
		<?php if($count == 0) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } elseif($count+1<count($breadcrumbs)) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } else { ?>
			<li><span><?php echo $breadcrumb['text']; ?></span></li>
		<?php } ?>
	<?php } ?>
  </ul>
</div>
<?php echo $content_top; ?>
<div class="container">
  <div class="row top-row search-top-row">
	  <div class="col-sm-12">
		  <h1 class="cat-header"><?php echo $heading_title; ?></h1>
	  </div>
  </div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <div class="row search-row">
	    <label class="control-label col-sm-12" for="input-search"><?php echo $entry_search; ?></label>
        <div class="col-sm-5">
          <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
        </div>
        <div class="col-sm-3 select-box">
            <select name="category_id" id="oct_search_category" class="form-control">
                <option value="0"><?php echo $text_category; ?></option>
                <?php foreach ($categories as $category_1) { ?>
                <?php if ($category_1['category_id'] == $category_id) { ?>
                <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                <?php } ?>
                <?php foreach ($category_1['children'] as $category_2) { ?>
                <?php if ($category_2['category_id'] == $category_id) { ?>
                <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                <?php } ?>
                <?php } ?>
                <?php } ?>
            </select>
        </div><div class="clearfix"></div>
        <div class="col-lg-4 col-md-12 checkbox-holder">
          <label class="checkbox-inline" id="checkbox-search-disabled">
            	<?php if ($sub_category) { ?>
	            <input type="checkbox" name="sub_category" value="1" checked="checked" />
	            <?php } else { ?>
	            <input type="checkbox" name="sub_category" value="1" />
	            <?php } ?>
	            <?php echo $text_sub_category; ?>
            </label>
            <label class="checkbox-inline">
	          <?php if ($description) { ?>
	          <input type="checkbox" name="description" value="1" id="description" checked="checked" />
	          <?php } else { ?>
	          <input type="checkbox" name="description" value="1" id="description" />
	          <?php } ?>
	          <?php echo $entry_description; ?>
	        </label>


        </div>
        <div class="col-sm-12"><input type="button" value="<?php echo $button_search; ?>" id="button-search" class="luxury-button" /></div>
      </div>
      
      <?php if ($products) { ?>
      <div class="row sort-row">
	    <div class="col-sm-12">
		    <div class="col-md-3 col-sm-6 col-xs-12 compare-box">
			    <a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a>
		    </div>
		  	<div class="col-md-2 hidden-sm col-xs-5 text-right">
	          <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
	        </div>
	        <div class="col-md-3 hidden-sm col-xs-7 text-right select-box">
	          <select id="input-sort" class="form-control" onchange="location = this.value;">
	            <?php foreach ($sorts as $sorts) { ?>
	            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
	            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
	            <?php } else { ?>
	            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
	            <?php } ?>
	            <?php } ?>
	          </select>
	        </div>
	        <div class="col-md-2 hidden-sm col-xs-5 text-right">
	          <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
	        </div>
	        <div class="col-md-1 hidden-sm col-xs-7 text-right select-box">
	          <select id="input-limit" class="form-control" onchange="location = this.value;">
	            <?php foreach ($limits as $limits) { ?>
	            <?php if ($limits['value'] == $limit) { ?>
	            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
	            <?php } else { ?>
	            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
	            <?php } ?>
	            <?php } ?>
	          </select>
	        </div>
	        <div class="col-md-1 col-sm-6 appearance">
	          <div class="btn-group hidden-xs">
	            <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
	            <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
	          </div>
	        </div>
	  	</div>
      </div>
      <?php } ?>
      <div id="res-products">
      <?php if ($products) { ?>
      <h2 class="cat-header"><?php echo $text_search; ?></h2>
      <div class="row filter-products">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-list col-xs-12">
          <div class="product-thumb<?php echo (isset($product['product_preorder_status']) && $product['product_preorder_status'] != 1 && $product['quantity'] <= 0) ? ' no_quantity' : ''?>">
			<?php if ($product['oct_product_stickers']) { ?>
				<div class="cat-sticker-box">
					<?php foreach ($product['oct_product_stickers'] as $product_sticker) { ?>
						<div style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;">
							<?php echo $product_sticker['text']; ?>
						</div>
					<?php } ?>
				</div>
			<?php } ?>
            <?php if ($product['economy']) { ?>
          	<div class="cat-discount">-<?php echo $product['economy']; ?>%</div>
            <?php } ?>
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div>
              <div class="caption">
                <div class="h4"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
               <p class="description"><?php echo $product['description']; ?></p>
                <?php if ($product['price']) { ?>
                <p class="price">
                  <?php if (!$product['special']) { ?>
                  <span class="price-new"><?php echo $product['price']; ?></span>
                  <?php } else { ?>
                  <span class="price-new"><?php echo $product['special']; ?></span> <br/><span class="price-old"><?php echo $product['price']; ?></span>
                  <?php } ?>
                </p>
                <?php } ?>
                <?php if ($product['rating']) { ?>
                <div class="rating">
                  <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($product['rating'] < $i) { ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } else { ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } ?>
                  <?php } ?>
                </div>
                <?php } ?>
                <?php if (isset($product['oct_options']) && $product['oct_options']) { ?>
                  <div class="cat-options">
                    <?php foreach ($product['oct_options'] as $option) { ?>
                      <?php if ($option['type'] == 'radio') { ?>
                        <div class="form-group">
                          <label class="control-label"><?php echo $option['name']; ?></label>
                          <br/>
                          <?php if ($option['product_option_value']) { ?>
                            <?php foreach ($option['product_option_value'] as $product_option_value) { ?>
                              <?php if ($product_option_value['image']) { ?>
                                <div class="radio">
                                  <label class="not-selected-img">
                                    <img src="<?php echo $product_option_value['image']; ?>" alt="<?php echo $product_option_value['name']; ?>" class="img-thumbnail" title="<?php echo $product_option_value['name']; ?>" />
                                  </label>
                                </div>
                              <?php } else { ?>
                                <div class="radio">
                                  <label class="not-selected"><?php echo $product_option_value['name']; ?></label>
                                </div>
                              <?php } ?> 
                            <?php } ?>
                          <?php } ?>
                        </div>
                      <?php } else { ?>
                        <div class="form-group size-box">
                          <label class="control-label"><?php echo $option['name']; ?></label>
                          <br/>
                          <?php if ($option['product_option_value']) { ?>
                            <?php foreach ($option['product_option_value'] as $product_option_value) { ?>
                              <div class="radio">
                                <label class="not-selected"><?php echo $product_option_value['name']; ?></label>
                              </div>
                            <?php } ?>
                          <?php } ?>
                        </div>
                      <?php } ?>
                    <?php } ?>
                  </div>
                <?php } ?>
                <div class="button-group">
                  <?php if ($product['quantity'] <= 0) { ?>
										<button class="button-cart" type="button" data-effect="mfp-zoom-out" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_oct_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><?php echo $product['product_preorder_text']; ?></button>
									<?php } else { ?>
										<button class="button-cart" type="button" data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_cart('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
									<?php } ?>
                  <?php if (isset($oct_popup_view_data['status']) && $oct_popup_view_data['status'] && $product['quantity'] > 0) { ?>
										<a data-effect="mfp-zoom-out" onclick="get_oct_popup_product_view('<?php echo $product['product_id']; ?>');" title="<?php echo $button_popup_view; ?>" class="more"><i class="fa fa-eye" aria-hidden="true"></i></a>
									<?php } else { ?>
										<a href="<?php echo $product['href']; ?>" title="<?php echo $button_popup_view; ?>" class="more"><i class="fa fa-eye" aria-hidden="true"></i></a>    
									<?php } ?>   
                  <button class="wishlist" type="button" title="<?php echo $button_wishlist; ?>" data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart" aria-hidden="true"></i></button>
                  <button class="compare" type="button" title="<?php echo $button_compare; ?>" data-effect="mfp-zoom-out" onclick="get_oct_popup_add_to_compare('<?php echo $product['product_id']; ?>');"><i class="fa fa-sliders" aria-hidden="true"></i></button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <?php } ?>
    <div class="clearfix"></div>
      </div>
      <div class="row pagination-row">
        <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
      </div>
      <?php } ?>
      </div>
      <?php if (!$products) { ?>
      <p class="oct-empty-search"><?php echo $text_empty; ?></p>
      <?php } ?>
    </div>
    <?php echo $column_right; ?>
    </div>
</div>

  <?php echo $content_bottom; ?>
  <script><!--
$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';

	var search = $('#content input[name=\'search\']').prop('value');

	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').prop('value');

	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
		$('.selected_oct_cat').val(category_id);
	}

	var sub_category = 1;

	if (sub_category) {
		url += '&sub_category=true';
	}

	var filter_description = $('#content input[name=\'description\']:checked').prop('value');

	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

var category_id = $('#content select[name=\'category_id\']').prop('value');

if (category_id > 0) {
	$('.selected_oct_cat').val(category_id);
	var selected_cat = "";
    $( "#oct_search_category option:selected" ).each(function() {
      selected_cat += $( this ).text() + " ";
    });
	$('.cats-button').html('<span class="category-name">' + selected_cat + '&nbsp;</span><i class="fa fa-caret-down" aria-hidden="true"></i>');
}

$('#content input[name=\'search\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', true);
	} else {
		$('input[name=\'sub_category\']').prop('disabled', false);
	}
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>
