<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
<div class="page-header">
	<div class="container-fluid">
		<div class="pull-right">
			<button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
			<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
		</div>
		<h1><?php echo $heading_title; ?></h1>
		<ul class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
			<?php } ?>
		</ul>
	</div>
</div>
<div class="container-fluid">
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
	<button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
	</div>
	<div class="panel-body">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
		<ul class="nav nav-tabs" id="content-tabs">
		    <li><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
		    <li><a href="#tab-categories" data-toggle="tab"><?php echo $tab_categories; ?></a></li>
		    <li><a href="#tab-dop" data-toggle="tab"><?php echo $tab_dop; ?></a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane" id="tab-general">
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
					<div class="col-sm-10">
						<input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
						<?php if ($error_name) { ?>
						<div class="text-danger"><?php echo $error_name; ?></div>
						<?php } ?>
					</div>
				</div>
	            <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-title"><?php echo $entry_title; ?></label>
                    <div class="col-sm-10">
                    	<ul class="nav nav-tabs" id="content-language">
			                <?php foreach ($languages as $language) { ?>
			                	<li><a href="#content-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
			                <?php } ?>
			            </ul>
			            <div class="tab-content">
			                <?php foreach ($languages as $language) { ?>
			                <div class="tab-pane" id="content-language<?php echo $language['language_id']; ?>">
								<input type="text" class="form-control" name="oct_pfc_module[0][title][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($oct_pfc_module[0]['title'][$language['language_id']]) ? $oct_pfc_module[0]['title'][$language['language_id']] : ''); ?>" id="input-title" />
							</div>
							<?php } ?>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-titlelink"><?php echo $entry_titlelink; ?></label>
					<div class="col-sm-10">
						<input type="text" name="oct_pfc_module[0][titlelink]" value="<?php echo isset($oct_pfc_module[0]['titlelink']) ? $oct_pfc_module[0]['titlelink'] : ''; ?>" id="input-titlelink" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
					<div class="col-sm-10">
						<input type="text" name="width" value="<?php echo $width; ?>" id="input-width" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
					<div class="col-sm-10">
						<input type="text" name="height" value="<?php echo $height; ?>" id="input-height" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-autoplay"><?php echo $entry_view; ?></label>
					<div class="col-sm-10">
						<select name="view" id="input-autoplay" class="form-control">
							<?php if (isset($view) && $view == 'grid') { ?>
								<option value="grid" selected="selected"><?php echo $text_grid; ?></option>
								<option value="carousel"><?php echo $text_carousel; ?></option>
							<?php } else { ?>
								<option value="grid"><?php echo $text_grid; ?></option>
								<option value="carousel" selected="selected"><?php echo $text_carousel; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-autoplay"><?php echo $entry_autoplay; ?></label>
					<div class="col-sm-10">
						<select name="autoplay" id="input-autoplay" class="form-control">
							<?php if ($autoplay) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<div class="form-group">
						<label class="col-sm-2 control-label" for="input-sort_order"><?php echo $text_show_no_quantity_products; ?></label>
						<div class="col-sm-10">
							<select name="show_no_quantity_products" id="input-sort_order" class="form-control">
	                            <?php if (isset($show_no_quantity_products) && !$show_no_quantity_products) { ?>
		                            <option value="0" selected="selected"><?php echo $text_yes; ?></option>
		                            <option value="1"><?php echo $text_no; ?></option>
	                            <?php } else { ?>
		                            <option value="0"><?php echo $text_yes; ?></option>
		                            <option value="1" selected="selected"><?php echo $text_no; ?></option>
	                            <?php } ?>
	                        </select>
						</div>
					</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
					<div class="col-sm-10">
						<select name="status" id="input-status" class="form-control">
							<?php if ($status) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="tab-categories">
				<fieldset>
	                <legend><?php echo $text_product; ?></legend>
					<div class="form-group">
		                <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
		                <div class="col-sm-10">
		                  <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">
		                    <table class="table table-striped">
		                    <?php foreach ($categories as $category) { ?>
		                    <tr>
		                      <td class="checkbox">
		                        <label>
		                          <?php if (isset($oct_pfc_module[0]['category']) && in_array($category['category_id'], $oct_pfc_module[0]['category'] )) { ?>
		                          <input type="checkbox" name="oct_pfc_module[0][category][]" value="<?php echo $category['category_id']; ?>" checked="checked" />
		                          <?php echo $category['name']; ?>
		                          <?php } else { ?>
		                          <input type="checkbox" name="oct_pfc_module[0][category][]" value="<?php echo $category['category_id']; ?>" />
		                          <?php echo $category['name']; ?>
		                          <?php } ?>
		                        </label>
		                      </td>
		                    </tr>
		                    <?php } ?>
		                    </table>
		                </div>
		                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
		            </div>
		            <div class="form-group">
						<label class="col-sm-2 control-label" for="input-order_by"><?php echo $entry_order_by; ?></label>
						<div class="col-sm-10">
							<select name="oct_pfc_module[0][orderby]" id="input-sort_order" class="form-control">
	                            <?php if (isset($oct_pfc_module[0]['orderby']) && $oct_pfc_module[0]['orderby'] == 'pd.name') { ?>
		                            <option value="pd.name" selected="selected"><?php echo $text_sort_name; ?></option>
	                            <?php } else { ?>
		                            <option value="pd.name"><?php echo $text_sort_name; ?></option>
	                            <?php } ?>
	                            <?php if (isset($oct_pfc_module[0]['orderby']) && $oct_pfc_module[0]['orderby'] == 'p.model') { ?>
		                            <option value="p.model" selected="selected"><?php echo $text_sort_model; ?></option>
	                            <?php } else { ?>
		                            <option value="p.model"><?php echo $text_sort_model; ?></option>
	                            <?php } ?>
	                            <?php if (isset($oct_pfc_module[0]['orderby']) && $oct_pfc_module[0]['orderby'] == 'p.price') { ?>
		                            <option value="p.price" selected="selected"><?php echo $text_sort_price; ?></option>
	                            <?php } else { ?>
		                            <option value="p.price"><?php echo $text_sort_price; ?></option>
	                            <?php } ?>
	                            <?php if (isset($oct_pfc_module[0]['orderby']) && $oct_pfc_module[0]['orderby'] == 'rating') { ?>
		                            <option value="rating" selected="selected"><?php echo $text_sort_rating; ?></option>
	                            <?php } else { ?>
		                            <option value="rating"><?php echo $text_sort_rating; ?></option>
	                            <?php } ?>
	                            <?php if (isset($oct_pfc_module[0]['orderby']) && $oct_pfc_module[0]['orderby'] == 'p.date_added') { ?>
		                            <option value="p.date_added" selected="selected"><?php echo $text_sort_date; ?></option>
	                            <?php } else { ?>
		                            <option value="p.date_added"><?php echo $text_sort_date; ?></option>
	                            <?php } ?>
	                            <?php if (isset($oct_pfc_module[0]['orderby']) && $oct_pfc_module[0]['orderby'] == 'p.sort_order') { ?>
		                            <option value="p.sort_order" selected="selected"><?php echo $text_sort_sort; ?></option>
	                            <?php } else { ?>
		                            <option value="p.sort_order"><?php echo $text_sort_sort; ?></option>
	                            <?php } ?>
	                        </select>
						</div>
					</div>
		            <div class="form-group">
						<label class="col-sm-2 control-label" for="input-sort_order"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
							<select name="oct_pfc_module[0][sortorder]" id="input-sort_order" class="form-control">
	                            <?php if (isset($oct_pfc_module[0]['sortorder']) && $oct_pfc_module[0]['sortorder']=='desc') { ?>
		                            <option value="asc"><?php echo $text_asc; ?></option>
		                            <option value="desc" selected="selected"><?php echo $text_desc; ?></option>
	                            <?php } else { ?>
		                            <option value="asc" selected="selected"><?php echo $text_asc; ?></option>
		                            <option value="desc"><?php echo $text_desc; ?></option>
	                            <?php } ?>
	                        </select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
						<div class="col-sm-10">
							<input type="text" name="limit" size="33" value="<?php echo $limit; ?>" id="input-limit" class="form-control" />
						</div>
					</div>
				</fieldset>
			</div>
			<div class="tab-pane" id="tab-dop">
				<fieldset>
	                <legend><?php echo $text_dop_product; ?></legend>
		            <div class="form-group">
		                <label class="col-sm-2 control-label" for="input-related"><?php echo $entry_products; ?></label>
		                <div class="col-sm-10">
		                  <input type="text" value="" placeholder="<?php echo $entry_products; ?>" name="input-product" id="input-product" class="form-control" />
		                  <div id="product-product" class="well well-sm" style="height: 150px; overflow: auto;">
							<?php foreach ($products_list_sel as $products_list) { ?>
								<div id="product-item<?php echo $products_list['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $products_list['name']; ?>
									<input type="hidden" name="oct_pfc_module[0][products_list][]" value="<?php echo $products_list['product_id']; ?>" />
								</div>
							<?php } ?>
						  </div>
		                </div>
		            </div>
		            <div class="form-group">
						<label class="col-sm-2 control-label" for="input-latest_text"><?php echo $entry_latest_text; ?></label>
						<div class="col-sm-10">
							<input type="text" name="oct_pfc_module[0][latest]" value="<?php echo isset($oct_pfc_module[0]['latest']) ? $oct_pfc_module[0]['latest'] : 0; ?>" id="input-latest_text" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-specials_text"><?php echo $entry_specials_text; ?></label>
						<div class="col-sm-10">
							<input type="text" name="oct_pfc_module[0][specials]" value="<?php echo isset($oct_pfc_module[0]['specials']) ? $oct_pfc_module[0]['specials'] : 0; ?>" id="input-specials_text" class="form-control" />
						</div>
					</div>
				</fieldset>
			</div>
		</div>
		</form>
	</div>
</div>
</div>
<script type="text/javascript"><!--
	$('#input-product').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['product_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('#input-product').val('');		
			$('#product-item' + item['value']).remove();		
			$('#product-product').append('<div id="product-item' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="oct_pfc_module[0][products_list][]" value="' + item['value'] + '" /></div>');	
		}
	});
	
	$('#product-product').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});
	//-->
	$('#content-tabs a:first').tab('show');
	$('#content-language a:first').tab('show');
</script> 
<?php echo $footer; ?>