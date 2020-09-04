<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-oct-product-sizes-table" formaction="<?php echo $action; ?>" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form method="post" enctype="multipart/form-data" id="form-oct-product-sizes-table" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#setting-tab" data-toggle="tab"><?php echo $tab_setting; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="setting-tab">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="oct_product_sizes_table_data[status]" id="input-status" class="form-control">
                    <?php if ($oct_product_sizes_table_data['status']) { ?>
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
                <div class="col-sm-2">
                  <ul class="nav nav-pills nav-stacked" id="section">
                    <?php $section_row = 1; ?>
                    <?php if (isset($oct_product_sizes_table_data['sections']) && $oct_product_sizes_table_data['sections']) { ?>
                    <?php foreach ($oct_product_sizes_table_data['sections'] as $section) { ?>
                      <li><a href="#tab-section-<?php echo $section_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-section-<?php echo $section_row; ?>\']').parent().remove(); $('#tab-section-<?php echo $section_row; ?>').remove(); $('#section a:first').tab('show');"></i> <?php echo $entry_size_sect . ' ' . $section_row; ?></a></li>
                    <?php $section_row++; } ?>
                    <?php } ?>
                    <li id="section-add" style="cursor:pointer"><a onclick="addSection();"><i class="fa fa-plus-circle"></i> <?php echo $entry_size_add; ?></a></li> 
                  </ul>
                </div>
                <div class="col-sm-10">
                  <div class="tab-content first">
                    <?php $section_row = 1; ?>
                    <?php if (isset($oct_product_sizes_table_data['sections']) && $oct_product_sizes_table_data['sections']) { ?>
                    <?php foreach ($oct_product_sizes_table_data['sections'] as $section) { ?>
                      <div class="tab-pane" id="tab-section-<?php echo $section_row; ?>">
                        <div class="tab-content">
                          <div class="form-group">
                            <label class="col-sm-2 control-label"><?php echo $entry_category_block; ?></label>
                            <div class="col-sm-10">
                              <div class="well well-sm" style="height: 150px; overflow: auto; padding: 0 9px;">
                                <?php foreach ($categories as $category) { ?>
                                <div class="checkbox">
                                  <label>
                                    <?php if (isset($section['categories']) && in_array($category['category_id'], $section['categories'])) { ?>
                                    <input type="checkbox" name="oct_product_sizes_table_data[sections][<?php echo $section_row; ?>][categories][]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                                    <?php echo $category['name']; ?>
                                    <?php } else { ?>
                                    <input type="checkbox" name="oct_product_sizes_table_data[sections][<?php echo $section_row; ?>][categories][]" value="<?php echo $category['category_id']; ?>" />
                                    <?php echo $category['name']; ?>
                                    <?php } ?>
                                  </label>
                                </div>
                                <?php } ?>
                              </div>
                              <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                            </div>
                          </div>
                          <ul class="nav nav-tabs" id="language<?php echo $section_row; ?>">
                            <?php foreach ($languages as $language) { ?>
                              <li><a href="#tab-section-<?php echo $section_row; ?>-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                            <?php } ?>
                          </ul>
                          <div class="tab-content">
                            <?php foreach ($languages as $language) { ?>
                              <div class="tab-pane" id="tab-section-<?php echo $section_row; ?>-<?php echo $language['language_id']; ?>">
                                <div class="form-vertical">
                                  <div class="control-group">
                                    <label class="control-label"><?php echo $entry_size_title; ?></label>
                                    <div class="controls">
                                      <input type="text" class="form-control" name="oct_product_sizes_table_data[sections][<?php echo $section_row; ?>][title][<?php echo $language['code']; ?>]" value="<?php echo isset($section['title'][$language['code']]) ? $section['title'][$language['code']] : ''; ?>" />         
                                    </div>
                                  </div> 
                                  <div class="control-group">
                                    <label class="control-label"><?php echo $entry_size_block; ?></label>
                                    <div class="controls">
                                      <textarea class="form-control custom-control summernote" cols="3" name="oct_product_sizes_table_data[sections][<?php echo $section_row; ?>][block][<?php echo $language['code']; ?>]" id="description-<?php echo $section_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($section['block'][$language['code']]) ? $section['block'][$language['code']] : ''; ?></textarea>
                                    </div>
                                  </div> 
                                </div> 
                              </div>
                            <?php } ?>
                          </div>
                        </div> 
                      </div>
                    <?php $section_row++; } ?>
                    <?php } ?>
                  </div>
                </div> 
              </div>  
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
var section_row = <?php echo $section_row; ?>;

function addSection() { 

  html  = '<div class="tab-pane" id="tab-section-' + section_row + '">';
  html += '<div class="tab-content">';

    html += '<div class="form-group">';
    html += '<label class="col-sm-2 control-label"><?php echo $entry_category_block; ?></label>';
    html += '<div class="col-sm-10">';
    html += '<div class="well well-sm" style="height: 150px; overflow: auto; padding: 0 9px;">';
        <?php foreach ($categories as $category) { ?>
        html += '<div class="checkbox">';
          html += '<label><input type="checkbox" name="oct_product_sizes_table_data[sections][' + section_row + '][categories][]" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?></label>';
        html += '</div>';
        <?php } ?>
    html += '</div>';
    html += '<a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', false);"><?php echo $text_unselect_all; ?></a>';
    html += '</div>';
    html += '</div>';


  html += '<ul class="nav nav-tabs" id="language' + section_row + '">';
  <?php foreach ($languages as $language) { ?>
  html += '<li><a href="#tab-section-' + section_row + '-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
  <?php } ?>
  html += '</ul>';

  html += '<div class="tab-content">';
  <?php foreach ($languages as $language) { ?>
  html += '<div class="tab-pane" id="tab-section-' + section_row + '-<?php echo $language['language_id']; ?>">';
  html += '<div class="form-vertical">';
  html += '<div class="control-group">';
  html += '<label class="control-label"><?php echo $entry_size_title; ?></label>';
  html += '<div class="controls">';
  html += '<input type="text" name="oct_product_sizes_table_data[sections][' + section_row + '][title][<?php echo $language['code']; ?>]" class="form-control"/>';
  html += '</div>';
  html += '</div>';
  html += '<div class="control-group">';
  html += '<label class="control-label"><?php echo $entry_size_block; ?></label>';
  html += '<div class="controls">';
  html += '<textarea name="oct_product_sizes_table_data[sections][' + section_row + '][block][<?php echo $language['code']; ?>]" id="description-' + section_row + '-<?php echo $language['language_id']; ?>" class="form-control custom-control summernote" cols="3"></textarea>';
  html += '</div>';
  html += '</div>';
  html += '</div>';
  html += '</div>';
  <?php } ?>
  html += '</div>';
  html += '</div>';
  html += '</div>';        

  $('.tab-content.first').append(html);

  $('#section-add').before('<li><a href="#tab-section-' + section_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-section-' + section_row + '\\\']\').parent().remove(); $(\'#tab-section-' + section_row + '\').remove(); $(\'#section a:first\').tab(\'show\');"></i> <?php echo $entry_size_sect; ?> ' + section_row + '</a></li>');
  
  $('#section a[href=\'#tab-section-' + section_row + '\']').tab('show');

  $('#language' + section_row + ' li:first-child a').tab('show');
  
	<?php if ($ckeditor) { ?>
		<?php foreach ($languages as $language) { ?>
			ckeditorInit('description-' + section_row + '-<?php echo $language['language_id']; ?>', getURLVar('token'));
		<?php } ?>
	<?php } else { ?>
		<?php foreach ($languages as $language) { ?>
			$('#description-' + section_row + '-<?php echo $language['language_id']; ?>' ).summernote({ 
		 height: 200,
		});
		<?php } ?>
	<?php } ?>

  section_row++;
}

<?php $section_row = 1; ?>
<?php if (isset($oct_product_sizes_table_data['sections'])) { ?>
<?php foreach ( $oct_product_sizes_table_data['sections'] as $section ) { ?>
  $( '#language<?php echo $section_row; ?> li:first-child a' ).tab( 'show' );
	<?php if ($ckeditor) { ?>
		<?php foreach ($languages as $language) { ?>
			ckeditorInit('description-<?php echo $section_row; ?>-<?php echo $language['language_id']; ?>', getURLVar('token'));
		<?php } ?>
	<?php } ?>																																			 
<?php $section_row++; ?>
<?php } ?>
<?php } ?>

$('#section li:first-child a').tab('show');
</script>
</div>
<?php echo $footer; ?>
