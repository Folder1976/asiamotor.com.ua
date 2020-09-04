
<!--author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)-->
<?php echo $header; ?> 

<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui.min.js"></script>
<script>
/*** Handle jQuery plugin naming conflict between jQuery UI and Bootstrap 
 *   see https://stackoverflow.com/questions/13731400/jqueryui-tooltips-are-competing-with-twitter-bootstrap
 * ***/
$.widget.bridge('uibutton', $.ui.button);
$.widget.bridge('uitooltip', $.ui.tooltip);
</script>
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/ui/jquery-ui.theme.min.css" />
<!-- need to add bootstrap after jquery-ui-->
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.min.js"></script>

<?php echo $column_left; ?> 

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-product" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb )  { ?> 
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning)  { ?> 
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?> 
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
    <?php } ?> 
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-search-suggestion" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li>
            <li><a href="#tab-category" data-toggle="tab"><?php echo $tab_category; ?></a></li>
            <li><a href="#tab-manufacturer" data-toggle="tab"><?php echo $tab_manufacturer; ?></a></li>
            <li><a href="#tab-information" data-toggle="tab"><?php echo $tab_information; ?></a></li>            
            <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
          </ul>
          <div class="tab-content">
            
            <div class="tab-pane active" id="tab-general">

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="search_suggestion_status" class="form-control">
                    <?php if ($search_suggestion_status)  { ?> 
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?> 
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?> 
                  </select>
                </div>
              </div>          
                  
              <!--<div class="form-group">
                <label class="col-sm-2 control-label" >
                  <?php echo $entry_autocomplete; ?> 
                </label>
                <div class="col-sm-10">
                  <select name="search_suggestion_options[autocomplete]"  class="form-control">
                    <option value="theme" <?php echo isset($options['autocomplete']) && $options['autocomplete'] == 'theme' ? 'selected="selected"' : ""; ?>><?php echo $text_autocomplete_theme; ?></option>
                    <option value="module" <?php echo isset($options['autocomplete']) && $options['autocomplete'] == 'module' ? 'selected="selected"' : ""; ?>><?php echo $text_autocomplete_module; ?></option>
                  </select>              
                </div>
              </div>-->          
                  
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_search_type_order; ?></label>
                <div class="col-sm-3">                  
                  
                  <table id="search-order" class="table table-striped table-bordered table-hover sorted_table">
                    <thead>
                      <tr>
                        <td class="text-left"><?php echo $column_search_type; ?></td>
                        <td class="text-left"><?php echo $column_search_type_sort; ?></td>  
                      </tr>
                    </thead>
                    <tbody>
                      <?php foreach ($options['types_order'] as $type_name => $type_options) { ?>
                      <tr>
                        <td class="text-left"><?php echo ${'tab_' . $type_name}; ?></td>              
                        <td class="text-left">                          
                          <input type="text" name="search_suggestion_options[types_order][<?php echo $type_name; ?>][sort]" value="<?php echo isset($type_options['sort']) ? $type_options['sort'] : 0; ?>" class="form-control">
                        </td>  
                      </tr>      
											<?php } ?>
                    </tbody>
                  </table>              
                  
                </div>
              </div>          

              <div class="form-group">
                <label class="col-sm-2 control-label" ><?php echo $entry_element; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="search_suggestion_options[element]" value="<?php echo isset($options['element']) ? $options['element'] : ''; ?>" class="form-control">
                </div>
              </div>          

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_width; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="search_suggestion_options[width]" value="<?php echo isset($options['width']) ? $options['width'] : ''; ?>"  class="form-control">
                </div>
              </div>          

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_css; ?></label>
                <div class="col-sm-10">
                  <textarea name="search_suggestion_options[css]" rows="8" cols="60" class="form-control"><?php echo isset($options['css']) ? $options['css'] : ''; ?></textarea>                  
                </div>
              </div>                        

              <input type="hidden" name="search_suggestion_module[0][search_suggestion]" value="1"/>

            </div>
                
            <div class="tab-pane" id="tab-product">
              
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-product-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
                <li><a href="#tab-product-search-by" data-toggle="tab"><?php echo $tab_search_by; ?></a></li>
                <li><a href="#tab-product-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
              </ul>
              <div class="tab-content">

                <div class="tab-pane active" id="tab-product-settings">

                  <div class="form-group">
                    <label class="col-sm-2 control-label" ><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[product][status]" class="form-control">
                        <?php if ($options['product']['status'])  { ?> 
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
                    <label class="col-sm-2 control-label" ><?php echo $entry_title; ?></label>
                    <div class="col-sm-10">
                      <?php foreach ($languages as $language )  { ?>                      
                      <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <input type="text" name="search_suggestion_options[product][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($options['product']['title'][$language['language_id']]) ? $options['product']['title'][$language['language_id']] : ''; ?>" class="form-control">
                      </div>
											<?php } ?>
                    </div>
                  </div>
                                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label">
                      <span data-toggle="tooltip" title="<?php echo $help_product_order; ?>">
                        <?php echo $entry_order; ?> 
                      </span>
                    </label>
                    <div class="col-sm-10">
                      <div class="row">
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[product][order]" class="form-control">
                            <option value="name" <?php echo isset($options['product']['order']) && $options['product']['order'] == 'name' ? 'selected="selected"' : ""; ?>><?php echo $text_order_name; ?></option>
                            <option value="rating" <?php echo isset($options['product']['order']) && $options['product']['order'] == 'rating' ? 'selected="selected"' : ""; ?>><?php echo $text_order_rating; ?></option>
                            <option value="relevance" <?php echo isset($options['product']['order']) && $options['product']['order'] == 'relevance' ? 'selected="selected"' : ""; ?>><?php echo $text_order_relevance; ?></option>
                          </select>
                        </div>
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[product][order_dir]" id="input-search-order-dir" class="form-control">
                            <option value="asc" <?php echo isset($options['product']['order_dir']) && $options['product']['order_dir'] == 'asc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_asc; ?></option>
                            <option value="desc" <?php echo isset($options['product']['order_dir'])  && $options['product']['order_dir'] == 'desc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_desc; ?></option>
                          </select>              
                        </div>
                      </div>
                    </div>
                  </div>          

                  <div class="form-group">
                    <label class="col-sm-2 control-label">
                      <span data-toggle="tooltip" title="<?php echo $help_product_logic; ?>">  
                        <?php echo $entry_logic; ?> 
                      </span>
                    </label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[product][logic]"  class="form-control">
                        <option value="or" <?php echo isset($options['product']['logic']) && $options['product']['logic'] == 'or' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_or; ?></option>
                        <option value="and" <?php echo isset($options['product']['logic']) && $options['product']['logic'] == 'and' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_and; ?></option>
                      </select>              
                    </div>
                  </div>          
                      
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_limit; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="search_suggestion_options[product][limit]" value="<?php echo isset($options['product']['limit'])  ?  $options['product']['limit'] : 0; ?>" class="form-control">
                    </div>
                  </div>  
                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_keyboard_layout; ?>"><?php echo $entry_fix_keyboard_layout; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[product][fix_keyboard_layout]" class="form-control">
                        <?php if ($options['product']['fix_keyboard_layout'])  { ?> 
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
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_transliteration; ?>"><?php echo $entry_fix_transliteration; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[product][fix_transliteration]" class="form-control">
                        <?php if ($options['product']['fix_transliteration'])  { ?> 
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
                    <label class="col-sm-2 control-label"><?php echo $entry_more; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[product][more]" class="form-control">
                        <?php if ($options['product']['more'])  { ?> 
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

                <div class="tab-pane" id="tab-product-search-by">
                  
                  <table id="where" class="table table-striped table-bordered table-hover">
                    <thead>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" onclick="$('input[type=checkbox][name*=\'search_suggestion_options[product][search_by]\']').prop('checked', this.checked);" />
                        </td>
                        <td class="text-left"><?php echo $column_search_by; ?></td>  
                        <td class="text-left"><?php echo $column_relevance_weight; ?></td>
                      </tr>
                    </thead>
                    <tbody >
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][name]" value="1" <?php echo isset($options['product']['search_by']['name']) && $options['product']['search_by']['name'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_name; ?></td>  
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][tags]" value="1" <?php echo isset($options['product']['search_by']['tags']) && $options['product']['search_by']['tags'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_tag; ?></td>
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][description]" value="1" <?php echo isset($options['product']['search_by']['description']) && $options['product']['search_by']['description'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_description; ?></td>  
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][model]" value="1" <?php echo isset($options['product']['search_by']['model']) && $options['product']['search_by']['model'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_model; ?></td> 
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>              
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][sku]" value="1" <?php echo isset($options['product']['search_by']['sku']) && $options['product']['search_by']['sku'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_sku; ?></td>  
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>              
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][more]" value="1"  disabled />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_more; ?></td>  
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>              
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[product][search_by][custom]" value="1"  disabled />
                        </td>
                        <td class="text-left"><?php echo $text_product_field_custom; ?></td>  
                        <td class="text-left"><?php echo $text_relevance_weight_mr; ?></td>              
                      </tr>

                    </tbody>
                  </table>
                  <?php echo $help_tab_product_search_by; ?>  
                  
                </div>

                <div class="tab-pane" id="tab-product-fields">

                  <table id="fields" class="table table-striped table-bordered table-hover sorted_table">
                    <thead>
                      <tr>
                        <td class="text-left"><?php echo $column_fields_show; ?></td>
                        <td class="text-left"><?php echo $column_fields; ?></td>              
                        <td class="text-left"><?php echo $column_fields_show_field_name; ?></td>  
                        <td class="text-left"><?php echo $column_fields_settings; ?></td>  
                        <td class="text-left"><?php echo $column_fields_location; ?></td>  
                        <td class="text-left"><?php echo $column_fields_sort; ?></td>  
                        <td class="text-left"><?php echo $column_fields_css; ?></td>  
                      </tr>
                    </thead>
                    <tbody>

                      <?php foreach ($options['product']['fields'] as $field_name => $field_options)  { ?> 
                        <tr>
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[product][fields][<?php echo $field_name; ?>][show]" value="1" <?php echo isset($field_options['show']) && $field_options['show'] ? "checked=checked" : ""; ?> />
                          </td>
													<td class="text-left"><?php echo ${'text_product_field_' . $field_name}; ?></td>              
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[product][fields][<?php echo $field_name; ?>][show_field_name]" value="1" <?php echo isset($field_options['show_field_name']) && $field_options['show_field_name'] ? "checked=checked" : ""; ?> />
                          </td>
                          <td class="text-left">
                            <?php if ($field_name == 'attributes')  { ?> 
                              <?php echo $text_fields_cut; ?>: <input type="text" name="search_suggestion_options[product][fields][attributes][cut]" value="<?php echo isset($field_options['cut'])  ?  $field_options['cut'] : 0; ?>" size="4" class="form-control">
                              <?php echo $text_fields_separator; ?>: <input type="text" name="search_suggestion_options[product][fields][attributes][separator]" value="<?php echo isset($field_options['separator'])  ?  $field_options['separator'] : '/'; ?>" size="2" class="form-control">
                            <?php } elseif ($field_name == 'image')  { ?> 
                              <?php echo $text_field_image_width; ?>: <input type="text" name="search_suggestion_options[product][fields][image][width]" value="<?php echo isset($field_options['width'])  ?  $field_options['width'] : 0; ?>" size="3" class="form-control">  
                              <?php echo $text_field_image_height; ?>: <input type="text" name="search_suggestion_options[product][fields][image][height]" value="<?php echo isset($field_options['height'])  ?  $field_options['height'] : 0; ?>" size="3" class="form-control">                
                            <?php } elseif ($field_name == 'description')  { ?> 
                              <?php echo $text_fields_cut; ?>: <input type="text" name="search_suggestion_options[product][fields][description][cut]" value="<?php echo isset($field_options['cut'])  ?  $field_options['cut'] : 0; ?>" size="4" class="form-control">
                            <?php } elseif ($field_name == 'cart')  { ?> 
                              <?php echo $text_product_field_cart_code; ?>: <br />
															<textarea name="search_suggestion_options[product][fields][cart][code]" rows="5" cols="40" class="form-control"><?php echo isset($field_options['code'])  ?  $field_options['code'] : ""; ?></textarea>
                            <?php } ?> 
                          </td>  
                          <td class="text-left">
                            <select name="search_suggestion_options[product][fields][<?php echo $field_name; ?>][location]" class="form-control">
                              <option value="newline" <?php echo isset($field_options['location']) && $field_options['location'] == 'newline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_newline; ?> 
                              </option>            
                              <option value="inline" <?php echo isset($field_options['location']) && $field_options['location'] == 'inline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_inline; ?> 
                              </option>
                            </select>  
                          </td>  
                          <td class="text-left">
                            <input type="text" name="search_suggestion_options[product][fields][<?php echo $field_name; ?>][sort]" value="<?php echo isset($field_options['sort'])  ?  $field_options['sort'] : 0; ?>" size="3" class="form-control"/>
                          </td>  
                          <td class="text-left">
                            .<?php echo $field_name; ?> {<br />
                            <textarea name="search_suggestion_options[product][fields][<?php echo $field_name; ?>][css]" rows="4" cols="40" class="form-control"><?php echo isset($field_options['css'])  ?  $field_options['css'] : ''; ?></textarea>}
                          </td>
                        </tr>      
                      <?php } ?>

                    </tbody>
                  </table>              

                  <table id="fields_attributes" class="table table-striped table-bordered table-hover">
                    <thead>
                      <tr>
                        <td class="text-left"><?php echo $column_fields_attributes; ?></td>              
                        <td class="text-left"><?php echo $column_fields_attributes_show; ?></td>
                        <td class="text-left"><?php echo $column_fields_attributes_replace_text; ?></td>  
                      </tr>
                    </thead>
                    <tbody>

                      <?php foreach ($attributes as $attribute)  { ?> 
                        <tr>
                          <td class="text-left"><?php echo $attribute['name']; ?></td>              
                          <td>

                            <select name="search_suggestion_options[product][fields][attributes][<?php echo $attribute['attribute_id']; ?>][show]" class="form-control">

                              <option value="0" <?php echo isset($options['product']['fields']['attributes'][$attribute['attribute_id']]['show']) && $options['product']['fields']['attributes'][$attribute['attribute_id']]['show'] == '0' ? 'selected="selected"' : ""; ?>><?php echo $text_fields_attributes_hide; ?></option>
                              <option value="1" <?php echo isset($options['product']['field']['attributes'][$attribute['attribute_id']]['show']) && $options['product']['fields']['attributes'][$attribute['attribute_id']]['show'] == '1' ? 'selected="selected"' : ""; ?>><?php echo $text_fields_attributes_show; ?></option>
                              <option value="2" <?php echo isset($options['product']['field']['attributes'][$attribute['attribute_id']]['show']) && $options['product']['fields']['attributes'][$attribute['attribute_id']]['show'] == '2' ? 'selected="selected"' : ""; ?>><?php echo $text_fields_attributes_replace; ?></option>

                            </select>

                          </td>

                          <td class="text-left">
                            <input type="text" name="search_suggestion_options[product][fields][attributes][<?php echo $attribute['attribute_id']; ?>][replace]" value="<?php echo isset($options['product']['fields']['attributes'][$attribute['attribute_id']]['replace'])  ?  $options['product']['fields']['attributes'][$attribute['attribute_id']]['replace'] : ''; ?>" class="form-control">
                          </td>  

                        </tr>
                      <?php } ?>
                    </tbody>
                  </table>
                  
                </div>

              </div>  
                                          
            </div>
                
            <div class="tab-pane" id="tab-category">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-category-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
                <li><a href="#tab-category-search-by" data-toggle="tab"><?php echo $tab_search_by; ?></a></li>
                <li><a href="#tab-category-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
              </ul>
              <div class="tab-content">

                <div class="tab-pane active" id="tab-category-settings">

                  <div class="form-group">
                    <label class="col-sm-2 control-label" ><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[category][status]" class="form-control">
                        <?php if ($options['category']['status'])  { ?> 
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
                    <label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
                    <div class="col-sm-10">
                      <?php foreach ($languages as $language )  { ?>                      
                      <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <input type="text" name="search_suggestion_options[category][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($options['category']['title'][$language['language_id']]) ? $options['category']['title'][$language['language_id']] : ''; ?>" class="form-control">
                      </div>
											<?php } ?>
                    </div>
                  </div>
                                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label">
                      <?php echo $entry_order; ?> 
                    </label>
                    <div class="col-sm-10">
                      <div class="row">
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[category][order]" class="form-control">
                            <option value="name" <?php echo isset($options['category']['order']) && $options['category']['order'] == 'name' ? 'selected="selected"' : ""; ?>><?php echo $text_order_name; ?></option>
                            <option value="relevance" <?php echo isset($options['category']['order']) && $options['category']['order'] == 'relevance' ? 'selected="selected"' : ""; ?>><?php echo $text_order_relevance; ?></option>
                          </select>
                        </div>
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[category][order_dir]" id="input-search-order-dir" class="form-control">
                            <option value="asc" <?php echo isset($options['category']['order_dir']) && $options['category']['order_dir'] == 'asc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_asc; ?></option>
                            <option value="desc" <?php echo isset($options['category']['order_dir']) && $options['category']['order_dir'] == 'desc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_desc; ?></option>
                          </select>              
                        </div>
                      </div>
                    </div>
                  </div>          

                  <div class="form-group">
                    <label class="col-sm-2 control-label">
                      <?php echo $entry_logic; ?> 
                    </label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[category][logic]" class="form-control">
                        <option value="or" <?php echo isset($options['category']['logic']) && $options['category']['logic'] == 'or' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_or; ?></option>
                        <option value="and" <?php echo isset($options['category']['logic']) && $options['category']['logic'] == 'and' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_and; ?></option>
                      </select>              
                    </div>
                  </div>          
                      
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_limit; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="search_suggestion_options[category][limit]" value="<?php echo isset($options['category']['limit'])  ?  $options['category']['limit'] : 0; ?>" class="form-control">
                    </div>
                  </div>          
                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_keyboard_layout; ?>"><?php echo $entry_fix_keyboard_layout; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[category][fix_keyboard_layout]" class="form-control">
                        <?php if ($options['category']['fix_keyboard_layout'])  { ?> 
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
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_transliteration; ?>"><?php echo $entry_fix_transliteration; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[category][fix_transliteration]" class="form-control">
                        <?php if ($options['category']['fix_transliteration'])  { ?> 
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?> 
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?> 
                      </select>
                    </div>
                  </div>
                      
                  <!--<div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_more; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[category][more]" class="form-control">
                        <?php if ($options['category']['more'])  { ?> 
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?> 
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?> 
                      </select>
                    </div>
                  </div>-->

                </div>

                <div class="tab-pane" id="tab-category-search-by">
                  
                  <table id="where" class="table table-striped table-bordered table-hover">
                    <thead>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" onclick="$('input[type=checkbox][name*=\'search_suggestion_options[category][search_by]\']').prop('checked', this.checked);" />
                        </td>
                        <td class="text-left"><?php echo $column_search_by; ?></td>  
                        <td class="text-left"><?php echo $column_relevance_weight; ?></td>
                      </tr>
                    </thead>
                    <tbody >
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[category][search_by][name][status]" value="1" <?php echo isset($options['category']['search_by']['name']['status']) && $options['category']['search_by']['name']['status'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_category_field_name; ?></td>  
                        <td class="text-left">
                          <input type="text" name="search_suggestion_options[category][search_by][name][weight]" value="<?php echo isset($options['category']['search_by']['name']['weight'])  ?  $options['category']['search_by']['name']['weight'] : 0; ?>" class="form-control">
                        </td>
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[category][search_by][description][status]" value="1" <?php echo isset($options['category']['search_by']['description']['status']) && $options['category']['search_by']['description']['status'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_category_field_description; ?></td>  
                        <td class="text-left">
                          <input type="text" name="search_suggestion_options[category][search_by][description][weight]" value="<?php echo isset($options['category']['search_by']['description']['weight'])  ?  $options['category']['search_by']['description']['weight'] : 0; ?>" class="form-control">
                        </td>
                      </tr>

                    </tbody>
                  </table>
                  
                </div>

                <div class="tab-pane" id="tab-category-fields">

                  <table id="fields" class="table table-striped table-bordered table-hover sorted_table">
                    <thead>
                      <tr>
                        <td class="text-left"><?php echo $column_fields_show; ?></td>
                        <td class="text-left"><?php echo $column_fields; ?></td>              
                        <td class="text-left"><?php echo $column_fields_show_field_name; ?></td>  
                        <td class="text-left"><?php echo $column_fields_settings; ?></td>  
                        <td class="text-left"><?php echo $column_fields_location; ?></td>  
                        <td class="text-left"><?php echo $column_fields_sort; ?></td>  
                        <td class="text-left"><?php echo $column_fields_css; ?></td>  
                      </tr>
                    </thead>
                    <tbody>

                      <?php foreach ($options['category']['fields'] as $field_name => $field_options)  { ?> 
                        <tr>
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[category][fields][<?php echo $field_name; ?>][show]" value="1" <?php echo isset($field_options['show']) && $field_options['show'] ? "checked=checked" : ""; ?> />
                          </td>
													<td class="text-left"><?php echo ${'text_category_field_' . $field_name}; ?></td>              
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[category][fields][<?php echo $field_name; ?>][show_field_name]" value="1" <?php echo isset($field_options['show_field_name']) && $field_options['show_field_name'] ? "checked=checked" : ""; ?> />
                          </td>
                          <td class="text-left">
                            <?php if ($field_name == 'image')  { ?> 
                              <?php echo $text_field_image_width; ?>: <input type="text" name="search_suggestion_options[category][fields][image][width]" value="<?php echo isset($field_options['width'])  ?  $field_options['width'] : 0; ?>" size="3" class="form-control">  
                              <?php echo $text_field_image_height; ?>: <input type="text" name="search_suggestion_options[category][fields][image][height]" value="<?php echo isset($field_options['height'])  ?  $field_options['height'] : 0; ?>" size="3" class="form-control">                
                            <?php } elseif ($field_name == 'description')  { ?> 
                              <?php echo $text_fields_cut; ?>: <input type="text" name="search_suggestion_options[category][fields][description][cut]" value="<?php echo isset($field_options['cut'])  ?  $field_options['cut'] : 0; ?>" size="4" class="form-control">
                            <?php } ?> 
                          </td>  
                          <td class="text-left">
                            <select name="search_suggestion_options[category][fields][<?php echo $field_name; ?>][location]" class="form-control">
                              <option value="newline" <?php echo isset($field_options['location']) && $field_options['location'] == 'newline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_newline; ?> 
                              </option>            
                              <option value="inline" <?php echo isset($field_options['location']) && $field_options['location'] == 'inline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_inline; ?> 
                              </option>
                            </select>  
                          </td>  
                          <td class="text-left">
                            <input type="text" name="search_suggestion_options[category][fields][<?php echo $field_name; ?>][sort]" value="<?php echo isset($field_options['sort'])  ?  $field_options['sort'] : 0; ?>" size="3" class="form-control"/>
                          </td>  
                          <td class="text-left">
                            .<?php echo $field_name; ?> {<br />
                            <textarea name="search_suggestion_options[category][fields][<?php echo $field_name; ?>][css]" rows="4" cols="40" class="form-control"><?php echo isset($field_options['css'])  ?  $field_options['css'] : ''; ?></textarea>}
                          </td>
                        </tr>      
                      <?php } ?>

                    </tbody>
                  </table>              

                </div>

              </div>  
              
            </div>
                
            <div class="tab-pane" id="tab-manufacturer">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-manufacturer-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
                <li><a href="#tab-manufacturer-search-by" data-toggle="tab"><?php echo $tab_search_by; ?></a></li>
                <li><a href="#tab-manufacturer-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
              </ul>
              <div class="tab-content">

                <div class="tab-pane active" id="tab-manufacturer-settings">

                  <div class="form-group">
                    <label class="col-sm-2 control-label" ><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[manufacturer][status]" class="form-control">
                        <?php if ($options['manufacturer']['status'])  { ?> 
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
                    <label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
                    <div class="col-sm-10">
                      <?php foreach ($languages as $language )  { ?>                      
                      <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <input type="text" name="search_suggestion_options[manufacturer][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($options['manufacturer']['title'][$language['language_id']]) ? $options['manufacturer']['title'][$language['language_id']] : ''; ?>" class="form-control">
                      </div>
											<?php } ?>
                    </div>
                  </div>
                                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_order; ?></label>
                    <div class="col-sm-10">
                      <div class="row">
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[manufacturer][order]" class="form-control">
                            <option value="name" <?php echo isset($options['manufacturer']['order']) && $options['manufacturer']['order'] == 'name' ? 'selected="selected"' : ""; ?>><?php echo $text_order_name; ?></option>
                          </select>
                        </div>
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[manufacturer][order_dir]" id="input-search-order-dir" class="form-control">
                            <option value="asc" <?php echo isset($options['manufacturer']['order_dir']) && $options['manufacturer']['order_dir'] == 'asc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_asc; ?></option>
                            <option value="desc" <?php echo isset($options['manufacturer']['order_dir']) && $options['manufacturer']['order_dir'] == 'desc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_desc; ?></option>
                          </select>              
                        </div>
                      </div>
                    </div>
                  </div>          

                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[manufacturer][logic]"  class="form-control">
                        <option value="or" <?php echo isset($options['manufacturer']['logic']) && $options['manufacturer']['logic'] == 'or' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_or; ?></option>
                        <option value="and" <?php echo isset($options['manufacturer']['logic']) && $options['manufacturer']['logic'] == 'and' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_and; ?></option>
                      </select>              
                    </div>
                  </div>          
                      
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_limit; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="search_suggestion_options[manufacturer][limit]" value="<?php echo isset($options['manufacturer']['limit'])  ?  $options['manufacturer']['limit'] : 0; ?>" class="form-control">
                    </div>
                  </div>          
                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_keyboard_layout; ?>"><?php echo $entry_fix_keyboard_layout; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[manufacturer][fix_keyboard_layout]" class="form-control">
                        <?php if ($options['manufacturer']['fix_keyboard_layout'])  { ?> 
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
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_transliteration; ?>"><?php echo $entry_fix_transliteration; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[manufacturer][fix_transliteration]" class="form-control">
                        <?php if ($options['manufacturer']['fix_transliteration'])  { ?> 
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?> 
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?> 
                      </select>
                    </div>
                  </div>
                      
                  <!--<div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_more; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[manufacturer][more]" class="form-control">
                        <?php if ($options['manufacturer']['more'])  { ?> 
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?> 
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?> 
                      </select>
                    </div>
                  </div>-->

                </div>

                <div class="tab-pane" id="tab-manufacturer-search-by">
                  
                  <table id="where" class="table table-striped table-bordered table-hover">
                    <thead>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" onclick="$('input[type=checkbox][name*=\'search_suggestion_options[manufacturer][search_by]\']').prop('checked', this.checked);" />
                        </td>
                        <td class="text-left"><?php echo $column_search_by; ?></td>  
                      </tr>
                    </thead>
                    <tbody >
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[manufacturer][search_by][name]" value="1" <?php echo isset($options['manufacturer']['search_by']['name']) && $options['manufacturer']['search_by']['name'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_manufacturer_field_name; ?></td>  
                      </tr>
                    </tbody>
                  </table>
                  
                </div>

                <div class="tab-pane" id="tab-manufacturer-fields">

                  <table id="fields" class="table table-striped table-bordered table-hover sorted_table">
                    <thead>
                      <tr>
                        <td class="text-left"><?php echo $column_fields_show; ?></td>
                        <td class="text-left"><?php echo $column_fields; ?></td>              
                        <td class="text-left"><?php echo $column_fields_show_field_name; ?></td>  
                        <td class="text-left"><?php echo $column_fields_settings; ?></td>  
                        <td class="text-left"><?php echo $column_fields_location; ?></td>  
                        <td class="text-left"><?php echo $column_fields_sort; ?></td>  
                        <td class="text-left"><?php echo $column_fields_css; ?></td>  
                      </tr>
                    </thead>
                    <tbody>

                      <?php foreach ($options['manufacturer']['fields'] as $field_name => $field_options)  { ?> 
                        <tr>
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[manufacturer][fields][<?php echo $field_name; ?>][show]" value="1" <?php echo isset($field_options['show']) && $field_options['show'] ? "checked=checked" : ""; ?> />
                          </td>
													<td class="text-left"><?php echo ${'text_manufacturer_field_' . $field_name}; ?></td>              
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[manufacturer][fields][<?php echo $field_name; ?>][show_field_name]" value="1" <?php echo isset($field_options['show_field_name']) && $field_options['show_field_name'] ? "checked=checked" : ""; ?> />
                          </td>
                          <td class="text-left">
                            <?php if ($field_name == 'image')  { ?> 
                              <?php echo $text_field_image_width; ?>: <input type="text" name="search_suggestion_options[manufacturer][fields][image][width]" value="<?php echo isset($field_options['width'])  ?  $field_options['width'] : 0; ?>" size="3" class="form-control">  
                              <?php echo $text_field_image_height; ?>: <input type="text" name="search_suggestion_options[manufacturer][fields][image][height]" value="<?php echo isset($field_options['height'])  ?  $field_options['height'] : 0; ?>" size="3" class="form-control">                
                            <?php } ?> 
                          </td>  
                          <td class="text-left">
                            <select name="search_suggestion_options[manufacturer][fields][<?php echo $field_name; ?>][location]" class="form-control">
                              <option value="newline" <?php echo isset($field_options['location']) && $field_options['location'] == 'newline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_newline; ?> 
                              </option>            
                              <option value="inline" <?php echo isset($field_options['location']) && $field_options['location'] == 'inline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_inline; ?> 
                              </option>
                            </select>  
                          </td>  
                          <td class="text-left">
                            <input type="text" name="search_suggestion_options[manufacturer][fields][<?php echo $field_name; ?>][sort]" value="<?php echo isset($field_options['sort'])  ?  $field_options['sort'] : 0; ?>" size="3" class="form-control"/>
                          </td>  
                          <td class="text-left">
                            .<?php echo $field_name; ?> {<br />
                            <textarea name="search_suggestion_options[manufacturer][fields][<?php echo $field_name; ?>][css]" rows="4" cols="40" class="form-control"><?php echo isset($field_options['css'])  ?  $field_options['css'] : ''; ?></textarea>}
                          </td>
                        </tr>      
                      <?php } ?>

                    </tbody>
                  </table>              

                </div>

              </div>  

            </div>
                
            <div class="tab-pane" id="tab-information">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-information-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
                <li><a href="#tab-information-search-by" data-toggle="tab"><?php echo $tab_search_by; ?></a></li>
                <li><a href="#tab-information-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
              </ul>
              <div class="tab-content">

                <div class="tab-pane active" id="tab-information-settings">

                  <div class="form-group">
                    <label class="col-sm-2 control-label" ><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[information][status]" class="form-control">
                        <?php if ($options['information']['status'])  { ?> 
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
                    <label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
                    <div class="col-sm-10">
                      <?php foreach ($languages as $language )  { ?>                      
                      <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <input type="text" name="search_suggestion_options[information][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($options['information']['title'][$language['language_id']]) ? $options['information']['title'][$language['language_id']] : ''; ?>" class="form-control">
                      </div>
											<?php } ?>
                    </div>
                  </div>
                                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_order; ?></label>
                    <div class="col-sm-10">
                      <div class="row">
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[information][order]" class="form-control">
                            <option value="name" <?php echo isset($options['information']['order']) && $options['information']['order'] == 'name' ? 'selected="selected"' : ""; ?>><?php echo $text_order_name; ?></option>
                            <option value="relevance" <?php echo isset($options['information']['order']) && $options['information']['order'] == 'relevance' ? 'selected="selected"' : ""; ?>><?php echo $text_order_relevance; ?></option>
                          </select>
                        </div>
                        <div class="col-sm-6">
                          <select name="search_suggestion_options[information][order_dir]" id="input-search-order-dir" class="form-control">
                            <option value="asc" <?php echo isset($options['information']['order_dir']) && $options['information']['order_dir'] == 'asc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_asc; ?></option>
                            <option value="desc" <?php echo isset($options['information']['order_dir']) && $options['information']['order_dir'] == 'desc' ? 'selected="selected"' : ""; ?>><?php echo $text_order_dir_desc; ?></option>
                          </select>              
                        </div>
                      </div>
                    </div>
                  </div>          

                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_logic; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[information][logic]" class="form-control">
                        <option value="or" <?php echo isset($options['information']['logic']) && $options['information']['logic'] == 'or' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_or; ?></option>
                        <option value="and" <?php echo isset($options['information']['logic']) && $options['information']['logic'] == 'and' ? 'selected="selected"' : ""; ?>><?php echo $text_logic_and; ?></option>
                      </select>              
                    </div>
                  </div>          
                      
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_limit; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="search_suggestion_options[information][limit]" value="<?php echo isset($options['information']['limit'])  ?  $options['information']['limit'] : 0; ?>" class="form-control">
                    </div>
                  </div>          
                    
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_keyboard_layout; ?>"><?php echo $entry_fix_keyboard_layout; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[information][fix_keyboard_layout]" class="form-control">
                        <?php if ($options['information']['fix_keyboard_layout'])  { ?> 
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
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_fix_transliteration; ?>"><?php echo $entry_fix_transliteration; ?></span></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[information][fix_transliteration]" class="form-control">
                        <?php if ($options['information']['fix_transliteration'])  { ?> 
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?> 
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?> 
                      </select>
                    </div>
                  </div>
                      
                  <!--<div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_more; ?></label>
                    <div class="col-sm-10">
                      <select name="search_suggestion_options[information][more]" class="form-control">
                        <?php if ($options['information']['more'])  { ?> 
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?> 
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?> 
                      </select>
                    </div>
                  </div>-->

                </div>

                <div class="tab-pane" id="tab-information-search-by">
                  
                  <table id="where" class="table table-striped table-bordered table-hover">
                    <thead>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" onclick="$('input[type=checkbox][name*=\'search_suggestion_options[information][search_by]\']').prop('checked', this.checked);" />
                        </td>
                        <td class="text-left"><?php echo $column_search_by; ?></td>  
                        <td class="text-left"><?php echo $column_relevance_weight; ?></td>
                      </tr>
                    </thead>
                    <tbody >
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[information][search_by][title][status]" value="1" <?php echo isset($options['information']['search_by']['title']['status']) && $options['information']['search_by']['title']['status'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_information_field_title; ?></td>  
                        <td class="text-left">
                          <input type="text" name="search_suggestion_options[information][search_by][title][weight]" value="<?php echo isset($options['information']['search_by']['title']['weight'])  ?  $options['information']['search_by']['title']['weight'] : 0; ?>" class="form-control">
                        </td>
                      </tr>
                      <tr>
                        <td class="text-center">
                          <input type="checkbox" name="search_suggestion_options[information][search_by][description][status]" value="1" <?php echo isset($options['information']['search_by']['description']['status']) && $options['information']['search_by']['description']['status'] ? "checked=checked" : ""; ?> />
                        </td>
                        <td class="text-left"><?php echo $text_information_field_description; ?></td>  
                        <td class="text-left">
                          <input type="text" name="search_suggestion_options[information][search_by][description][weight]" value="<?php echo isset($options['information']['search_by']['description']['weight'])  ?  $options['information']['search_by']['description']['weight'] : 0; ?>" class="form-control">
                        </td>
                      </tr>

                    </tbody>
                  </table>
                  
                </div>

                <div class="tab-pane" id="tab-information-fields">

                  <table id="fields" class="table table-striped table-bordered table-hover sorted_table">
                    <thead>
                      <tr>
                        <td class="text-left"><?php echo $column_fields_show; ?></td>
                        <td class="text-left"><?php echo $column_fields; ?></td>              
                        <td class="text-left"><?php echo $column_fields_show_field_name; ?></td>  
                        <td class="text-left"><?php echo $column_fields_settings; ?></td>  
                        <td class="text-left"><?php echo $column_fields_location; ?></td>  
                        <td class="text-left"><?php echo $column_fields_sort; ?></td>  
                        <td class="text-left"><?php echo $column_fields_css; ?></td>  
                      </tr>
                    </thead>
                    <tbody>

                      <?php foreach ($options['information']['fields'] as $field_name => $field_options)  { ?> 
                        <tr>
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[information][fields][<?php echo $field_name; ?>][show]" value="1" <?php echo isset($field_options['show']) && $field_options['show'] ? "checked=checked" : ""; ?> />
                          </td>
													<td class="text-left"><?php echo ${'text_information_field_' . $field_name}; ?></td>              
                          <td class="text-center">
                            <input type="checkbox" name="search_suggestion_options[information][fields][<?php echo $field_name; ?>][show_field_name]" value="1" <?php echo isset($field_options['show_field_name']) && $field_options['show_field_name'] ? "checked=checked" : ""; ?> />
                          </td>
                          <td class="text-left">
                            <?php if ($field_name == 'description')  { ?> 
                              <?php echo $text_fields_cut; ?>: <input type="text" name="search_suggestion_options[information][fields][description][cut]" value="<?php echo isset($field_options['cut'])  ?  $field_options['cut'] : 0; ?>" size="4" class="form-control">
                            <?php } ?> 
                          </td>  
                          <td class="text-left">
                            <select name="search_suggestion_options[information][fields][<?php echo $field_name; ?>][location]" class="form-control">
                              <option value="newline" <?php echo isset($field_options['location']) && $field_options['location'] == 'newline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_newline; ?> 
                              </option>            
                              <option value="inline" <?php echo isset($field_options['location']) && $field_options['location'] == 'inline' ? "selected='selected'" : ""; ?>>
                                <?php echo $text_field_location_inline; ?> 
                              </option>
                            </select>  
                          </td>  
                          <td class="text-left">
                            <input type="text" name="search_suggestion_options[information][fields][<?php echo $field_name; ?>][sort]" value="<?php echo isset($field_options['sort'])  ?  $field_options['sort'] : 0; ?>" size="3" class="form-control"/>
                          </td>  
                          <td class="text-left">
                            .<?php echo $field_name; ?> {<br />
                            <textarea name="search_suggestion_options[information][fields][<?php echo $field_name; ?>][css]" rows="4" cols="40" class="form-control"><?php echo isset($field_options['css'])  ?  $field_options['css'] : ''; ?></textarea>}
                          </td>
                        </tr>      
                      <?php } ?>

                    </tbody>
                  </table>              

                </div>

              </div>  
              
            </div>
                
            <div class="tab-pane" id="tab-support">
              <?php echo $support_text; ?> 
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div id="copyright">author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)</div>

  <style type="text/css">
    .sorted_table tbody tr {
      cursor: move;
    }
  </style>

  <script type="text/javascript"><!--

    $(document).ready(function () {

      // Sortable rows
      $('.sorted_table tbody').sortable({
        cursor: 'move',
        update: function (event, ui) {
          ui.item.parent().find('tr').each(function (i, row) {
            $(row).find('input[name*="[sort]"]').val(i);
          });
        }
      });

      // Hide attributes
      if ($('input[name=\'search_suggestion_options[product][fields][attributes][show]\']').is(':not(:checked)')) {
        $('#fields_attributes').hide();
      }
    });

    $('input[name=\'search_suggestion_options[product][fields][attributes][show]\']').on('change', function () {
      if ($(this).is(':checked')) {
        $('#fields_attributes').show();
      } else {
        $('#fields_attributes').hide();
      }
            
    });
    
    //--></script> 
    
</div>
<?php echo $footer; ?>
