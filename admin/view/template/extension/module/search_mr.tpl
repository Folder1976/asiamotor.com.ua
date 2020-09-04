
<!--author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)-->
<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-product" data-toggle="tooltip_" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip_" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-search-mr" class="form-horizontal">
          <ul class="nav nav-tabs">            
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-relevance" data-toggle="tab"><?php echo $tab_relevance; ?></a></li>
						<li><a href="#tab-add-fields" data-toggle="tab"><?php echo $tab_add_fields; ?></a></li>
						<li><a href="#tab-exclude-words" data-toggle="tab"><?php echo $tab_exclude_words; ?></a></li>
            <li><a href="#tab-replace-words" data-toggle="tab"><?php echo $tab_replace_words; ?></a></li>
            <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
          </ul>
          <div class="tab-content">

            <div id="tab-general" class="tab-pane active">

              <div class="form-group">
                <label class="col-sm-2 control-label" for="key"><?php echo $entry_key; ?></label>                    
                <div class="col-sm-10">
                  <input type="text" size="70" name="search_mr_options[key]" value="<?php echo isset($options['key']) ? $options['key'] : ''; ?>" id="key" class="form-control">
                </div>
              </div>

              <table id="general" class="table table-striped table-bordered table-hover">
                <thead>
                  <tr height="25">
                    <td><?php echo $entry_fields_name; ?></td>
                    <td><?php echo $entry_search; ?></td>
                    <td><?php echo $entry_phrase; ?></td>
                    <td><?php echo $entry_use_morphology; ?></td>
                    <td><?php echo $entry_use_relevance; ?></td>
                    <td><?php echo $entry_exclude_characters; ?></td>
                    <td><?php echo $entry_search_logic; ?></td> 
                  </tr>
                </thead>

                <tbody >

									<?php foreach ($fields as $field): ?>

	                  <tr>

	                    <td>
												<?php echo isset(${"field_" . $field}) ? ${"field_" . $field} : $field; ?>
	                    </td>

	                    <td>
	                      <select name="search_mr_options[fields][<?php echo $field; ?>][search]" class="form-control">
	                        <option value="0" <?php echo (isset($options['fields'][$field]['search']) && $options['fields'][$field]['search'] == '0') ? 'selected="selected"' : ""; ?>><?php echo $text_search_dont_search; ?></option>												
	                        <option value="equally"  <?php echo (isset($options['fields'][$field]['search']) && $options['fields'][$field]['search'] == 'equally') ? 'selected="selected"' : ""; ?>><?php echo $text_search_equally; ?></option>
	                        <option value="contains" <?php echo (isset($options['fields'][$field]['search']) && $options['fields'][$field]['search'] == 'contains') ? 'selected="selected"' : ""; ?>><?php echo $text_search_contains; ?></option>
	                        <option value="start"    <?php echo (isset($options['fields'][$field]['search']) && $options['fields'][$field]['search'] == 'start') ? 'selected="selected"' : ""; ?>><?php echo $text_search_start; ?></option>
	                      </select>
	                    </td>

	                    <td>
	                      <select name="search_mr_options[fields][<?php echo $field; ?>][phrase]" class="form-control">
	                        <option value="cut"  <?php echo (isset($options['fields'][$field]['phrase']) && $options['fields'][$field]['phrase'] == 'cut') ? 'selected="selected"' : ""; ?>><?php echo $text_phrase_cut; ?></option>
	                        <option value="dont_cut"  <?php echo (isset($options['fields'][$field]['phrase']) && $options['fields'][$field]['phrase'] == 'dont_cut') ? 'selected="selected"' : ""; ?>><?php echo $text_phrase_dont_cut; ?></option>
	                      </select>
	                    </td>

	                    <td>
	                      <input type="checkbox" name="search_mr_options[fields][<?php echo $field; ?>][use_morphology]" value="1" <?php echo isset($options['fields'][$field]['use_morphology']) && $options['fields'][$field]['use_morphology'] ? "checked=checked" : ""; ?>  class="form-control"/>
	                    </td>              

	                    <td>
	                      <input type="checkbox" name="search_mr_options[fields][<?php echo $field; ?>][use_relevance]" value="1" <?php echo isset($options['fields'][$field]['use_relevance']) && $options['fields'][$field]['use_relevance'] ? "checked=checked" : ""; ?>  class="form-control"/>
	                    </td>              

	                    <td>
	                      <input type="text" name="search_mr_options[fields][<?php echo $field; ?>][exclude_characters]" value="<?php echo isset($options['fields'][$field]['exclude_characters']) ? $options['fields'][$field]['exclude_characters'] : ''; ?>" size="10" class="form-control"/>
	                    </td>                              

	                    <td>
	                      <select name="search_mr_options[fields][<?php echo $field; ?>][logic]" class="form-control">
	                        <option value="OR"   <?php echo (isset($options['fields'][$field]['logic']) && $options['fields'][$field]['logic'] == 'OR') ? 'selected="selected"' : ""; ?>><?php echo $text_logic_or; ?></option>
	                        <option value="AND"  <?php echo (isset($options['fields'][$field]['logic']) && $options['fields'][$field]['logic'] == 'AND') ? 'selected="selected"' : ""; ?>><?php echo $text_logic_and; ?></option>
	                      </select>
	                    </td>

	                  </tr>

									<?php endforeach; ?>

                </tbody>  

              </table>

              <br />          
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_min_word_length; ?></label>                    
                <div class="col-sm-10">
                  <input type="text" name="search_mr_options[min_word_length]" value="<?php echo isset($options['min_word_length']) ? $options['min_word_length'] : ''; ?>" class="form-control"/>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_cache_results; ?></label>                    
                <div class="col-sm-10">
                  <input type="checkbox" name="search_mr_options[cache_results]" value="1" <?php echo isset($options['cache_results']) && $options['cache_results'] ? "checked=checked" : ""; ?>  class="form-control"/>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_keyboard_layout; ?>"><?php echo $entry_fix_keyboard_layout; ?></span></label>                    
                <div class="col-sm-10">
                  <select name="search_mr_options[fix_keyboard_layout]" class="form-control">
                    <option value="0"   <?php echo (isset($options['fix_keyboard_layout']) && $options['fix_keyboard_layout'] == '0') ? 'selected="selected"' : ""; ?>><?php echo $text_disabled; ?></option>
                    <option value="always"   <?php echo (isset($options['fix_keyboard_layout']) && $options['fix_keyboard_layout'] == 'always') ? 'selected="selected"' : ""; ?>><?php echo $text_always; ?></option>
                    <option value="nothing_found"   <?php echo (isset($options['fix_keyboard_layout']) && $options['fix_keyboard_layout'] == 'nothing_found') ? 'selected="selected"' : ""; ?>><?php echo $text_nothing_found; ?></option>
                  </select>									
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_sort_order_stock; ?>"><?php echo $entry_sort_order_stock; ?></span></label>                    
                <div class="col-sm-10">
                  <select name="search_mr_options[sort_order_stock]" class="form-control">
                    <option value="0"   <?php echo (isset($options['sort_order_stock']) && $options['sort_order_stock'] == '0') ? 'selected="selected"' : ""; ?>><?php echo $text_disabled; ?></option>
                    <option value="1"   <?php echo (isset($options['sort_order_stock']) && $options['sort_order_stock'] == '1') ? 'selected="selected"' : ""; ?>><?php echo $text_enabled; ?></option>
                  </select>									
                </div>
              </div>

							<?php echo $help_tab_general; ?>
            </div>

            <div id="tab-relevance" class="tab-pane">

              <table id="relevance"  class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <td><?php echo $entry_fields_name; ?></td>
                    <td><?php echo $entry_relevance_start; ?></td>
                    <td><?php echo $entry_relevance_phrase; ?></td>
                    <td><?php echo $entry_relevance_word; ?></td>
                  </tr>
                </thead>

                <tbody >

									<?php foreach ($fields as $field): ?>

	                  <tr>

	                    <td>
												<?php echo isset(${"field_" . $field}) ? ${"field_" . $field} : $field; ?>
	                    </td>

	                    <td>
	                      <input type="text" name="search_mr_options[fields][<?php echo $field; ?>][relevance][start]" value="<?php echo isset($options['fields'][$field]['relevance']['start']) ? $options['fields'][$field]['relevance']['start'] : 0; ?>" class="form-control"/>
	                    </td>              

	                    <td>
	                      <input type="text" name="search_mr_options[fields][<?php echo $field; ?>][relevance][phrase]" value="<?php echo isset($options['fields'][$field]['relevance']['phrase']) ? $options['fields'][$field]['relevance']['phrase'] : 0; ?>" class="form-control"/>
	                    </td>              

	                    <td>
	                      <input type="text" name="search_mr_options[fields][<?php echo $field; ?>][relevance][word]" value="<?php echo isset($options['fields'][$field]['relevance']['word']) ? $options['fields'][$field]['relevance']['word'] : 0; ?>" class="form-control"/>
	                    </td>              

	                  </tr>

									<?php endforeach; ?>

                </tbody>  

              </table>
							<?php echo $help_tab_relevance; ?>
            </div>

            <div id="tab-add-fields" class="tab-pane">
              <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <td class="text-left required"><?php echo $entry_field; ?></td>
											<td class="text-left"><?php echo $entry_join; ?></td>
											<td class="text-left"><?php echo $entry_where; ?></td>
                      <td class="text-left"></td>
                    </tr>
                  </thead>
                  <tbody>
										<?php $fields_row = 0; ?>
										<?php if (!empty($options['new_fields'])) { ?>
											<?php foreach ($options['new_fields'] as $field) { ?>

												<tr id="fields-row<?php echo $fields_row; ?>">
													<td class="text-left">
														<input type="text" name="search_mr_options[new_fields][<?php echo $fields_row; ?>][field]" value="<?php echo $field['field']; ?>" class="form-control"/>
														<?php if (isset($error_new_fields[$field['field']])) { ?>
															<div class="text-danger"><?php echo $error_new_fields[$field['field']]; ?></div>
														<?php } ?>
													</td>
													<td class="text-left"><input type="text" name="search_mr_options[new_fields][<?php echo $fields_row; ?>][join]" value="<?php echo $field['join']; ?>" class="form-control"/></td>
													<td class="text-left"><input type="text" name="search_mr_options[new_fields][<?php echo $fields_row; ?>][where]" value="<?php echo $field['where']; ?>" class="form-control"/></td>
													<td class="text-left"><button type="button" onclick="$('#fields-row<?php echo $fields_row; ?>').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
												</tr>
												<?php $fields_row++; ?>
											<?php } ?>
										<?php } ?>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="3"></td>
                      <td class="text-left"><button type="button" onclick="addField()" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                    </tr>
                  </tfoot>
                </table>
              </div>

							<?php echo $help_tab_add_fields; ?>
            </div>

            <div id="tab-exclude-words" class="tab-pane">

              <ul id="exclude-words-languages" class="nav nav-tabs">
								<?php foreach ($languages as $language) { ?>
	                <li><a href="#exclude-words-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
								<?php } ?>
              </ul>

              <div class="tab-content">                            
								<?php foreach ($languages as $language) { ?>
	                <div id="exclude-words-language<?php echo $language['language_id']; ?>" class="tab-pane">

	                  <div class="form-group">
	                    <label class="col-sm-2 control-label" for="exclude-words<?php echo $language['language_id']; ?>">
	                      <span data-toggle="tooltip" title="" data-original-title="<?php echo $help_tab_exclude_words; ?>"><?php echo $entry_exclude_words; ?></span>
	                    </label>                    
	                    <div class="col-sm-10">
	                      <textarea name="search_mr_options[exclude_words][<?php echo $language['language_id']; ?>]" rows="5" id="exclude-words<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($options['exclude_words'][$language['language_id']]) ? $options['exclude_words'][$language['language_id']] : ''; ?></textarea>
	                    </div>
	                  </div>

	                </div>
								<?php } ?>
              </div>

            </div>

            <div id="tab-replace-words" class="tab-pane">

              <ul id="replace-words-languages" class="nav nav-tabs">
								<?php foreach ($languages as $language) { ?>
	                <li><a href="#replace-words-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
								<?php } ?>
              </ul>

              <div class="tab-content">                            
								<?php foreach ($languages as $language) { ?>
	                <div id="replace-words-language<?php echo $language['language_id']; ?>" class="tab-pane">

	                  <div class="form-group">
	                    <label class="col-sm-2 control-label" for="replace-words<?php echo $language['language_id']; ?>">
	                      <span data-toggle="tooltip" title="" data-original-title="<?php echo $help_tab_replace_words; ?>"><?php echo $entry_replace_words; ?></span>
	                    </label>                    
	                    <div class="col-sm-10">
	                      <textarea name="search_mr_options[replace_words][<?php echo $language['language_id']; ?>]" rows="5" id="replace-words<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($options['replace_words'][$language['language_id']]) ? $options['replace_words'][$language['language_id']] : ''; ?></textarea>
	                    </div>
	                  </div>

	                </div>
								<?php } ?>
              </div>

            </div>

            <div id="tab-support" class="tab-pane">
							<?php echo $help_support; ?>
            </div>

					</div>
        </form>
      </div>
    </div>
  </div>

  <div id="copyright">author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)</div>

</div>

<script type="text/javascript"><!--
	$('#tab-replace-words .nav-tabs a:first').tab('show');
	$('#tab-exclude-words .nav-tabs a:first').tab('show');
	//--></script>	
<script type="text/javascript"><!--
var fields_row = <?php echo $fields_row; ?>;

function addField() {
	fields_row++;

	html  = '';
	html += '<tr id="fields-row' + fields_row + '">';
	html += '  <td class="text-left">';
	html += '    <input type="text" name="search_mr_options[new_fields][' + fields_row + '][field]" value="" class="form-control"/>';
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '    <input type="text" name="search_mr_options[new_fields][' + fields_row + '][join]" value="" class="form-control"/>';
	html += '  </td>';
	html += '  <td class="text-left">';
	html += '    <input type="text" name="search_mr_options[new_fields][' + fields_row + '][where]" value="" class="form-control"/>';
	html += '  </td>';
	html += '  <td class="left">';
	html += '    <a onclick="$(\'#fields-row' + fields_row + '\').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a>';
	html += '  </td>';
	html += '</tr>';

	$('#tab-add-fields table tbody').append(html);
}
//--></script>

<?php echo $footer; ?>