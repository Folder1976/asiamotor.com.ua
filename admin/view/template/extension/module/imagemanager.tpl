<?php if ($only_manager) { ?>
	<?php if (isset($styles)) { ?>
		<?php foreach ($styles as $style) { ?>
		<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
		<?php } ?>
	<?php } ?>
	<?php if (isset($scripts)) { ?>
		<?php foreach ($scripts as $script) { ?>
		<script type="text/javascript" src="<?php echo $script; ?>"></script>
		<?php } ?>
	<?php } ?>
	<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
			$('#elfinder').elfinder(
				// 1st Arg - options
				{	
					commandsOptions: {
						getfile: { multiple: <?php echo $multiple; ?> }
					},
					getFileCallback : function(file, fm) {
						<?php if ($thumb) { ?>
							 $.ajax({
							  url: 'index.php?route=extension/module/imagemanager/getthumb&thumb=' + encodeURIComponent(file.path) + '&token=' + getURLVar('token'),
							  dataType: 'text',
							  success: function(text) {
								$('#<?php echo $thumb; ?>').find('img').attr('src', text);
							  }
							});
						<?php } ?>
						<?php if ($target) { ?>
							$('#<?php echo $target; ?>').val(file.path);
						<?php } ?>
						<?php if ($editor) { ?>
							$('#<?php echo $editor; ?>').summernote('editor.insertImage', file.url);
						<?php } ?>
						//CKEditor
					    <?php if ($cke){ ?>
						  var cke_target = '<?php echo $cke; ?>' || null;
						  cke_target = cke_target.split( ':' ); //link,txtUrl
						  CKEDITOR.dialog.getCurrent().setValueOf(cke_target[0], cke_target[1], '/image/' + file.path);
						<?php } ?>
						<?php if ($multiple == 'true') { ?>
							file.forEach(function(item, i, file) {
								$.ajax({
								  url: 'index.php?route=extension/module/imagemanager/getthumb&thumb=' + encodeURIComponent(item.path) + '&token=' + getURLVar('token'),
								  dataType: 'text',
								  success: function(text) {
									html  = '<tr id="image-row' + image_row + '">';
									html += '  <td class="text-left"><a href="" id="thumb-image' + image_row + '"data-toggle="image" class="img-thumbnail"><img src="' + text + '" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="product_image[' + image_row + '][image]" value="' + item.path + '" id="input-image' + image_row + '" /></td>';
									html += '  <td class="text-right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="0" placeholder="0" class="form-control" /></td>';
									html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + image_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
									html += '</tr>';

									$('#images tbody').append(html);

									image_row++;
								  }
								});
								
							});
						<?php } ?>
						// close popup window
						$('#modal-image').modal('hide');
					},
					useBrowserHistory : false,
					resizable : false,
					cssAutoLoad : false,               // Disable CSS auto loading
					baseUrl : 'view/javascript/elfinder/',                    // Base URL to css/*, js/*
					url : '<?php echo $connector; ?>'  // connector URL (REQUIRED)
					// , lang: 'ru'                    // language (OPTIONAL)
				},
				// 2nd Arg - before boot up function
				function(fm, extraObj) {
					// `init` event callback function
					fm.bind('init', function() {

					});
					// Optional for set document.title dynamically.
					
					fm.bind('open', function() {
						var path = '',
							cwd  = fm.cwd();
						if (cwd) {
							path = fm.path(cwd.hash) || null;
						}
						
					}).bind('destroy', function() {
						
					});
				}
			);
		});
	</script>
	<div id="filemanager" class="modal-dialog modal-lg">
	  <div class="modal-content">
		<div class="modal-header">
		  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		  <h4 class="modal-title"><?php echo $heading_title; ?></h4>
		</div>
			<div id="elfinder"></div>
		
	  </div>
	</div>
<?php } else { ?>
	<?php echo $header; ?><?php echo $column_left; ?>
	<div id="content">
	  <div class="page-header">
		<div class="container-fluid">
		  <div class="pull-right">
			<button type="submit" form="form-imagemanager" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
			<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-imagemanager" class="form-horizontal">
			  <ul class="nav nav-tabs">
				<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
				<li><a href="#tab-watermark" data-toggle="tab"><?php echo $tab_watermark; ?></a></li>
			  </ul>
			  <div class="tab-content">
				<div class="tab-pane active" id="tab-general">
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-allow-mime"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_allow_mime; ?>"><?php echo $entry_allow_mime; ?></span></label>
					<div class="col-sm-10">
					  <input type="text" name="imagemanager_allow_mime" value="<?php echo $imagemanager_allow_mime; ?>" placeholder="<?php echo $entry_allow_mime; ?>" id="input-allow-mime" class="form-control" />
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
					<div class="col-sm-10">
					  <select name="imagemanager_status" id="input-status" class="form-control">
						<?php if ($imagemanager_status) { ?>
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
				<div class="tab-pane" id="tab-watermark">
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
					<div class="col-sm-10">
					  <select name="imagemanager_wm_status" id="input-status" class="form-control">
						<?php if ($imagemanager_wm_status) { ?>
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
					<label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
					<div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $wm_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
					  <input type="hidden" name="imagemanager_wm_image" value="<?php echo $imagemanager_wm_image; ?>" id="input-image" />
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-margin-right"><?php echo $entry_margin_right; ?></label>
					<div class="col-sm-10">
					  <input type="text" name="imagemanager_wm_mr" value="<?php echo $imagemanager_wm_mr; ?>" placeholder="<?php echo $entry_margin_right; ?>" id="input-margin-right" class="form-control" />
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-margin-bottom"><?php echo $entry_margin_bottom; ?></label>
					<div class="col-sm-10">
					  <input type="text" name="imagemanager_wm_mb" value="<?php echo $imagemanager_wm_mb; ?>" placeholder="<?php echo $entry_margin_bottom; ?>" id="input-margin-bottom" class="form-control" />
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-transparency"><span data-toggle="tooltip" data-container="#tab-watermark" title="<?php echo $help_transparency; ?>"><?php echo $entry_transparency; ?></span></label>
					<div class="col-sm-10">
					  <input type="text" name="imagemanager_wm_trans" value="<?php echo $imagemanager_wm_trans; ?>" placeholder="<?php echo $entry_transparency; ?>" id="input-transparency" class="form-control" />
					</div>
				  </div>
				</div>
			  </div>
			</form>
			
		  </div>
		</div>
	  </div>
	<?php echo $footer; ?>
<?php } ?>