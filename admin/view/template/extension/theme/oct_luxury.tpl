<?php echo $header; ?>
<link href="view/stylesheet/oct_luxury.css" rel="stylesheet" />
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onclick="$('#form').submit();" type="submit" form="form-carousel" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a class="btn btn-warning" onclick="$('#actionstay').val('1');$('#form').submit();"><i class="fa fa-external-link-square"></i> <?php echo $text_stay_in_module; ?></a>
        <a href="<?php echo $cache; ?>" data-toggle="tooltip" title="<?php echo $button_cache; ?>" class="btn btn-warning"><i class="fa fa-trash-o"></i></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-success"><i class="fa fa-reply"></i></a>
      </div>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <?php if ($error_warning) { ?>
    <div class="container-fluid">
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    </div>
  <?php } ?>
  <?php if ($success) { ?>
    <div class="container-fluid">
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    </div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3> 
      <div style="font-size: 22px; color: #ff0000;">v 5.1</div>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <?php if (isset($_SESSION['success'])) { ?>
          <div class="ok"><?php echo $_SESSION['success']; ?></div>
        <?php } ?>
        <input type="hidden" id="actionstay" name="actionstay" value="0" />
        
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab_main" data-toggle="tab"><i class="fa fa-cog"></i> <?php echo $text_tab_main; ?></a></li>
          <li><a href="#tab_header" data-toggle="tab"><i class="fa fa-arrow-up"></i> <?php echo $text_tab_header; ?></a></li>
          <li><a href="#tab_footer" data-toggle="tab"><i class="fa fa-arrow-down"></i> <?php echo $text_tab_footer; ?></a></li>
          <li><a href="#tab_category" data-toggle="tab"><i class="fa fa-folder-open"></i> <?php echo $text_tab_category; ?></a></li>
          <li><a href="#tab_product" data-toggle="tab"><i class="fa fa-tv"></i> <?php echo $text_tab_product; ?></a></li>
          <li><a href="#tab_mobile" data-toggle="tab"><i class="fa fa-mobile"></i> <?php echo $text_tab_mobile; ?></a></li>
          <li><a href="#tab_contacts" data-toggle="tab"><i class="fa fa-users"></i> <?php echo $text_tab_contacts; ?></a></li>
          <li><a href="#tab_payment_soc" data-toggle="tab"><i class="fa fa-list-alt"></i> <?php echo $text_tab_payment_soc; ?></a></li>
          <li><a href="#tab_cssjs" data-toggle="tab"><i class="fa fa-cog"></i> CSS - Javascript</a></li>
          <li><a href="#tab-limit-and-image" data-toggle="tab"><i class="fa fa-picture-o"></i> <?php echo $tab_limit_and_image; ?></a></li>
        </ul>

        <div class="tab-content">
          <!-- MAIN SETTINGS -->       
          <div id="tab_main" class="tab-pane active in">
            <div class="left-div">
              <table class="form">
                <tr>
                  <td><?php echo $text_status; ?></td>
                  <td>
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_status == '1' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_status"
                          value="1"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_status == '1' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_status == '0' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_status"
                          value="0"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_status == '0' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td><?php echo $text_showmanlogos; ?></td>
                  <td>
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['showmanlogos'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[showmanlogos]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['showmanlogos'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['showmanlogos'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[showmanlogos]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['showmanlogos'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td><?php echo $text_minifyjscss; ?></td>
                  <td>
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['minifyjscss'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[minifyjscss]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['minifyjscss'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['minifyjscss'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[minifyjscss]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['minifyjscss'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td><?php echo $text_terms; ?></td>
                  <td>
                    <select name="oct_luxury_data[terms]" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if (isset($oct_luxury_data['terms']) && $information['information_id'] == $oct_luxury_data['terms']) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>      
                  </td>
                </tr>
                <tr>
                  <td><span class="number">1</span> <?php echo $text_maincolor1; ?></td>
                  <td><input type="text" name="oct_luxury_data[maincolor1]" value="<?php echo $oct_luxury_data['maincolor1']; ?>" class="spectrum" /></td>
                </tr>
                <tr>
                  <td><span class="number">2</span> <?php echo $text_maincolor2; ?></td>
                  <td><input type="text" name="oct_luxury_data[maincolor2]" value="<?php echo $oct_luxury_data['maincolor2']; ?>" class="spectrum" /></td>
                </tr>                
                <tr>
                  <td><span class="number">3</span> <?php echo $text_maincolor3; ?></td>
                  <td><input type="text" name="oct_luxury_data[maincolor3]" value="<?php echo $oct_luxury_data['maincolor3']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><?php echo $text_license; ?></td>
                  <td><input type="text" name="oct_luxury_data[aOO]" value="<?php echo $oct_luxury_data['aOO']; ?>" class="form-control" /></td>
                </tr>
             </table>
            </div>
            <div class="right-div"><img src="../catalog/view/theme/oct_luxury/image/main.png" class="img-responsive" /></div>	
          </div>

          <!-- HEADER SETTINGS -->  
          <div class="tab-pane fade" id="tab_header">
            <div class="tab-content">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#sub_h_settings"><i class="fa fa-cog"></i> <?php echo $text_all_settings; ?></a></li>
                <li><a href="#sub_h_colors"><i class="fa fa-paint-brush"></i> <?php echo $text_all_colors; ?></a></li>
              </ul>

              <div class="tab-content">
                <div class="tab-pane fade active in" id="sub_h_settings">
                  <div class="left-div">
                    <table class="form">
                      <tr>
                        <td><span class="number">1</span> <?php echo $text_stick; ?></td>
                        <td width="30%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['stick'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[stick]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['stick'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['stick'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[stick]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['stick'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>
                        </td>
                      </tr>							
                      <tr>
                        <td><span class="number">2</span> <?php echo $text_shownews; ?></td>
                        <td>
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['shownews'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[shownews]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['shownews'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['shownews'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[shownews]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['shownews'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>
                        </td>
                      </tr>
                       <tr>
                        <td><span class="number">2</span> <?php echo $text_showcontacts; ?></td>
                        <td>
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['showcontacts'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[showcontacts]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['showcontacts'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['showcontacts'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[showcontacts]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['showcontacts'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>
                        </td>
                      </tr>

                      <tr>
                        <td><span class="number">3</span> <?php echo $text_infolinks; ?><?php echo $text_infolinks_info; ?></td>
                        <td>
                          <div class="form-group">
                            <div class="col-sm-10">
                              <div class="well well-sm">
                                <table class="table table-striped">
                                  <?php foreach ($informations as $information) { ?>
                                    <tr>
                                      <td class="checkbox">
                                        <label class="labelcheck">
                                          <input type="checkbox" name="oct_luxury_data[header_information_links][]" value="<?php echo $information['information_id']; ?>" <?php if (isset($oct_luxury_data['header_information_links']) && in_array($information['information_id'], $oct_luxury_data['header_information_links'])) { ?>checked="checked"<?php } ?> />
                                          <?php echo $information['title']; ?>
                                        </label>
                                      </td>
                                    </tr>
                                  <?php } ?>
                                </table>
                              </div>
                              <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </table>
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/header1.png" class="img-responsive" />
                    <img src="../catalog/view/theme/oct_luxury/image/header2.png" class="img-responsive" />
                  </div>	
                </div>
                <div class="tab-pane fade" id="sub_h_colors">
                  <div class="left-div">
                    <h2 class="titletd"><span><?php echo $text_head_1stline; ?></span></h2>	
                    <table class="form">
                      <tr>
                        <td><span class="number">1</span> <?php echo $text_head_1bg; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[head_1bge]" value="<?php echo $oct_luxury_data['head_1bge']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">2</span> <?php echo $text_head_1linkcolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_1linkcolore]" value="<?php echo $oct_luxury_data['head_1linkcolore']; ?>" class="spectrum" /></td>
                      </tr>	
                    </table>  
                    <h2 class="titletd"><span><?php echo $text_head_2ndline; ?></span></h2>
                    <table class="form">
                      <tr>
                        <td><span class="number">3</span> <?php echo $text_head_2bg; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[head_2bg]" value="<?php echo $oct_luxury_data['head_2bg']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">4</span> <?php echo $text_head_infocolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_infocolor]" value="<?php echo $oct_luxury_data['head_infocolor']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">5</span> <?php echo $text_head_linecolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_linecolor]" value="<?php echo $oct_luxury_data['head_linecolor']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">6</span> <?php echo $text_head_linecolor_hover; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_linecolor_hover]" value="<?php echo $oct_luxury_data['head_linecolor_hover']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">7</span> <?php echo $text_head_tooltiplinkcolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_tooltiplinkcolor]" value="<?php echo $oct_luxury_data['head_tooltiplinkcolor']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">8</span> <?php echo $text_head_tooltiplinkcolor_h; ?></td>
                        <td><input type="text" name="oct_luxury_data[text_head_tooltiplinkcolor_h]" value="<?php echo $oct_luxury_data['text_head_tooltiplinkcolor_h']; ?>" class="spectrum" /></td>
                      </tr>
                    </table>  
                    <h2 class="titletd"><span><?php echo $text_head_search; ?></span></h2>
                    <table class="form">	
                      <tr>
                        <td><span class="number">9</span> <?php echo $text_head_bgsrchcat; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[head_bgsrchcat]" value="<?php echo $oct_luxury_data['head_bgsrchcat']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">10</span> <?php echo $text_head_bgsrchcattext; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_bgsrchcattext]" value="<?php echo $oct_luxury_data['head_bgsrchcattext']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">11</span> <?php echo $text_head_srch; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_srch]" value="<?php echo $oct_luxury_data['head_srch']; ?>" class="spectrum" /></td>
                      </tr>							
                      <tr>
                        <td><span class="number">12</span> <?php echo $text_head_srchcolors; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_srchcolors]" value="<?php echo $oct_luxury_data['head_srchcolors']; ?>" class="spectrum" /></td>
                      </tr>
                    </table>  
                    <h2 class="titletd"><span><?php echo $text_head_cart; ?></span></h2>
                    <table class="form">							
                      <tr>
                        <td><span class="number">13</span> <?php echo $text_head_bgcart; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[head_bgcart]" value="<?php echo $oct_luxury_data['head_bgcart']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">14</span> <?php echo $text_head_bgcart2; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_bgcart2]" value="<?php echo $oct_luxury_data['head_bgcart2']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">15</span> <?php echo $text_head_textcart2; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_textcart2]" value="<?php echo $oct_luxury_data['head_textcart2']; ?>" class="spectrum" /></td>
                      </tr>	
                    </table>  
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/header3.png" class="img-responsive" />
                  </div>	
                  <div style="clear: both;"></div>
                  <div class="left-div">
                    <h2 class="titletd"><span><?php echo $text_head_nav; ?></span></h2>
                    <table class="form">							
                      <tr>
                        <td><span class="number">16</span> <?php echo $text_head_menu_text; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[head_menu_text]" value="<?php echo $oct_luxury_data['head_menu_text']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">17</span> <?php echo $text_head_bgmenu; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_bgmenu]" value="<?php echo $oct_luxury_data['head_bgmenu']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">18</span> <?php echo $text_head_maincolormenu; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_maincolormenu]" value="<?php echo $oct_luxury_data['head_maincolormenu']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">19</span> <?php echo $text_head_maincolormenu_h; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_maincolormenu_h]" value="<?php echo $oct_luxury_data['head_maincolormenu_h']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">20</span> <?php echo $text_head_bgchildmenu; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_bgchildmenu]" value="<?php echo $oct_luxury_data['head_bgchildmenu']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">21</span> <?php echo $text_head_parentcolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_parentcolor]" value="<?php echo $oct_luxury_data['head_parentcolor']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">22</span> <?php echo $text_head_parentcolor_hover; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_parentcolor_hover]" value="<?php echo $oct_luxury_data['head_parentcolor_hover']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">23</span> <?php echo $text_head_childcolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_childcolor]" value="<?php echo $oct_luxury_data['head_childcolor']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">24</span> <?php echo $text_head_childcolor_hover; ?></td>
                        <td><input type="text" name="oct_luxury_data[head_childcolor_hover]" value="<?php echo $oct_luxury_data['head_childcolor_hover']; ?>" class="spectrum" /></td>
                      </tr>																								
                    </table>  
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/header4.png" class="img-responsive" />
                  </div>	  
                </div>
              </div>
            </div>
          </div>

          <!-- FOOTER SETTINGS -->  
          <div class="tab-pane fade" id="tab_footer">
            <div class="tab-content">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#sub_f_settings"><i class="fa fa-cog"></i> <?php echo $text_all_settings; ?></a></li>
                <li><a href="#sub_f_colors"><i class="fa fa-paint-brush"></i> <?php echo $text_all_colors; ?></a></li>
              </ul>

              <div class="tab-content">
                <div class="tab-pane fade active in" id="sub_f_settings">
                  <div class="left-div">
                    <table class="form">
                      <tr>
                        <td><span class="number">1</span> <?php echo $text_foot_logo; ?></td>
                        <td width="25%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_logo'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_logo]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_logo'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_logo'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_logo]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_logo'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>
                        </td>
                      </tr>	
                      <tr>
                        <td><span class="number">2</span> <?php echo $text_foot_1stline; ?></td>
                        <td>
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_1stline'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_1stline]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_1stline'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_1stline'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_1stline]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_1stline'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>
                        </td>
                      </tr>	
                      <tr>
                        <td><span class="number">3</span> <?php echo $text_foot_2ndline; ?></td>
                        <td>
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_2ndline'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_2ndline]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_2ndline'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_2ndline'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_2ndline]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_2ndline'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div> 
                        </td>
                      </tr>	
                      <tr>
                        <td><span class="number">4</span> <?php echo $text_foot_3dline; ?></td>
                        <td>
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_3dline'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_3dline]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_3dline'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_3dline'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_3dline]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_3dline'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>   
                        </td>
                      </tr>	
                      <tr>
                        <td><span class="number">5</span> <?php echo $text_foot_infolinks; ?></td>
                        <td>
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_infolinks'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_infolinks]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_infolinks'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['foot_infolinks'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[foot_infolinks]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['foot_infolinks'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div>
                        </td>
                      </tr>							
                      <tr>
                        <td><span class="number">6</span> <?php echo $text_infolinks; ?></td>
                        <td>
                          <div class="form-group">
                            <div class="col-sm-10">
                              <div class="well well-sm">
                                <table class="table table-striped">
                                  <?php foreach ($informations as $information) { ?>
                                    <tr>
                                      <td class="checkbox">
                                        <label class="labelcheck">
                                          <input type="checkbox" name="oct_luxury_data[footer_information_links][]" value="<?php echo $information['information_id']; ?>" <?php if (isset($oct_luxury_data['footer_information_links']) && in_array($information['information_id'], $oct_luxury_data['footer_information_links'])) { ?>checked="checked"<?php } ?> />
                                          <?php echo $information['title']; ?>
                                        </label>
                                      </td>
                                    </tr>
                                  <?php } ?>
                                </table>
                              </div>
                              <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                            </div>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td><span class="number">7</span> <?php echo $text_foot_garanted; ?></td>
                        <td>
                          <?php foreach ($languages as $language) { ?>
                            <div class="input-group">
                              <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                              <textarea style="min-height: 100px; " name="oct_luxury_data[foot_garanted][<?php echo $language['code']; ?>]" id="oct_luxury_foot_garanted<?php echo $language['code']; ?>" class="form-control"><?php echo isset($oct_luxury_data['foot_garanted'][$language['code']]) ? $oct_luxury_data['foot_garanted'][$language['code']] : ''; ?></textarea>
                            </div><br />
                          <?php } ?>		
                        </td>
                      </tr> 
                    </table>
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/footer2.png" class="img-responsive" />
                  </div>
                </div>
                <div class="tab-pane fade" id="sub_f_colors">
                  <div class="left-div">
                    <table class="form">
                      <tr>
                        <td><span class="number">1</span> <?php echo $text_foot_1stlinebg; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[foot_1stlinebg]" value="<?php echo $oct_luxury_data['foot_1stlinebg']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">2</span> <?php echo $text_foot_linelogo; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_linelogo]" value="<?php echo $oct_luxury_data['foot_linelogo']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">3</span> <?php echo $text_foot_titlecolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_titlecolor]" value="<?php echo $oct_luxury_data['foot_titlecolor']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">4</span> <?php echo $text_foot_linkcolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_linkcolor]" value="<?php echo $oct_luxury_data['foot_linkcolor']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">5</span> <?php echo $text_foot_linelinks; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_linelinks]" value="<?php echo $oct_luxury_data['foot_linelinks']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">6</span> <?php echo $text_foot_garantedcolors; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_garantedcolors]" value="<?php echo $oct_luxury_data['foot_garantedcolors']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">7</span> <?php echo $text_foot_garantedtext; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_garantedtext]" value="<?php echo $oct_luxury_data['foot_garantedtext']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">8</span> <?php echo $text_foot_2ndlinebg; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_2ndlinebg]" value="<?php echo $oct_luxury_data['foot_2ndlinebg']; ?>" class="spectrum" /></td>
                      </tr>	                        
                      <tr>
                        <td><span class="number">9</span> <?php echo $text_foot_iconscolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_iconscolor]" value="<?php echo $oct_luxury_data['foot_iconscolor']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">10</span> <?php echo $text_foot_2ndlinetcolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_2ndlinetcolor]" value="<?php echo $oct_luxury_data['foot_2ndlinetcolor']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">11</span> <?php echo $text_foot_2linelink; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_2linelink]" value="<?php echo $oct_luxury_data['foot_2linelink']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">12</span> <?php echo $text_foot_3dlinebg; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_3dlinebg]" value="<?php echo $oct_luxury_data['foot_3dlinebg']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">13</span> <?php echo $text_foot_icocolor; ?></td>
                        <td><input type="text" name="oct_luxury_data[foot_icocolor]" value="<?php echo $oct_luxury_data['foot_icocolor']; ?>" class="spectrum" /></td>
                      </tr>	
                    </table>  
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/footer.png" class="img-responsive" />
                  </div>	
                </div>
              </div>
            </div>
          </div>

          <!-- CATEGORY SETTINGS -->  
          <div class="tab-pane fade" id="tab_category">
            <h2 class="titletd"><span><?php echo $text_cat_main; ?></span></h2>
            <div class="left-div">
              <table class="form">
                <tr>
                  <td><span class="number">1</span> <?php echo $text_cat_sorttype; ?></td>
                  <td width="25%">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['cat_sorttype'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[cat_sorttype]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['cat_sorttype'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['cat_sorttype'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[cat_sorttype]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['cat_sorttype'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td><span class="number">2</span> <?php echo $text_cat_sortcolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_sortcolor]" value="<?php echo $oct_luxury_data['cat_sortcolor']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">3</span> <?php echo $text_cat_hovercolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_hovercolor]" value="<?php echo $oct_luxury_data['cat_hovercolor']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">4</span> <?php echo $text_cat_discountbg; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_discountbg]" value="<?php echo $oct_luxury_data['cat_discountbg']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">5</span> <?php echo $text_cat_discountcolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_discountcolor]" value="<?php echo $oct_luxury_data['cat_discountcolor']; ?>" class="spectrum"  /></td>
                </tr>
              </table>
              <h2 class="titletd"><span><?php echo $text_cat_filterset; ?></span></h2>
              <table class="form">		
                <tr>
                  <td><span class="number">6</span> <?php echo $text_cat_boxtext; ?></td>
                  <td width="25%"><input type="text" name="oct_luxury_data[cat_boxtext]" value="<?php echo $oct_luxury_data['cat_boxtext']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">7</span> <?php echo $text_cat_boxbg; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_boxbg]" value="<?php echo $oct_luxury_data['cat_boxbg']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">8</span> <?php echo $text_cat_moduleborder; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_moduleborder]" value="<?php echo $oct_luxury_data['cat_moduleborder']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">9</span> <?php echo $text_cat_modulebg; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_modulebg]" value="<?php echo $oct_luxury_data['cat_modulebg']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">10</span> <?php echo $text_cat_itembg; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_itembg]" value="<?php echo $oct_luxury_data['cat_itembg']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">11</span> <?php echo $text_cat_plusminus; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_plusminus]" value="<?php echo $oct_luxury_data['cat_plusminus']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">12</span> <?php echo $text_cat_checkbox; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_checkbox]" value="<?php echo $oct_luxury_data['cat_checkbox']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">13</span> <?php echo $text_cat_checkboxactive; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_checkboxactive]" value="<?php echo $oct_luxury_data['cat_checkboxactive']; ?>" class="spectrum"  /></td>
                </tr>
              </table>
              <h2 class="titletd"><span><?php echo $text_cat_modulecat; ?></span></h2>
              <table class="form">	
                <tr>
                  <td><span class="number">14</span> <?php echo $text_cat_1levelbg; ?></td>
                  <td width="25%"><input type="text" name="oct_luxury_data[cat_1levelbg]" value="<?php echo $oct_luxury_data['cat_1levelbg']; ?>" class="spectrum"  /></td>
                </tr>					
                <tr>
                  <td><span class="number">15</span> <?php echo $text_cat_1levelcolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_1levelcolor]" value="<?php echo $oct_luxury_data['cat_1levelcolor']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">16</span> <?php echo $text_cat_2levelbg; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_2levelbg]" value="<?php echo $oct_luxury_data['cat_2levelbg']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">17</span> <?php echo $text_cat_2levelcolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_2levelcolor]" value="<?php echo $oct_luxury_data['cat_2levelcolor']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">18</span> <?php echo $text_cat_3levelbg; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_3levelbg]" value="<?php echo $oct_luxury_data['cat_3levelbg']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">19</span> <?php echo $text_cat_3levelcolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_3levelcolor]" value="<?php echo $oct_luxury_data['cat_3levelcolor']; ?>" class="spectrum"  /></td>
                </tr>
                <tr>
                  <td><span class="number">20</span> <?php echo $text_cat_3levelbgactive; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_3levelbgactive]" value="<?php echo $oct_luxury_data['cat_3levelbgactive']; ?>" class="spectrum"  /></td>
                </tr>	
                <tr>
                  <td><span class="number">20</span> <?php echo $text_cat_3leveltextactive; ?></td>
                  <td><input type="text" name="oct_luxury_data[cat_3leveltextactive]" value="<?php echo $oct_luxury_data['cat_3leveltextactive']; ?>" class="spectrum"  /></td>
                </tr>																					
              </table>
            </div>
            <div class="right-div">
              <img src="../catalog/view/theme/oct_luxury/image/category.png" class="img-responsive" />
            </div>	
          </div>

          <!-- PRODUCT SETTINGS -->  
          <div class="tab-pane fade" id="tab_product">
            <div class="tab-content">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#sub_p_settings"><i class="fa fa-cog"></i> <?php echo $text_all_settings; ?></a></li>
                <li><a href="#sub_p_colors"><i class="fa fa-paint-brush"></i> <?php echo $text_all_colors; ?></a></li>
              </ul>

              <div class="tab-content">
                <div class="tab-pane fade active in" id="sub_p_settings">
                  <div class="left-div">
                    <table class="form">
                      <tr>
                        <td><?php echo $text_pr_micro; ?></td>
                        <td width="30%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_micro'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_micro]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_micro'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_micro'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_micro]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_micro'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div> 
                        </td>
                      </tr>	
                      <tr>
                        <td><span class="number">1</span> <?php echo $text_pr_shortdesc; ?></td>
                        <td width="30%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_shortdesc'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_shortdesc]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_shortdesc'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_shortdesc'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_shortdesc]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_shortdesc'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div> 
                        </td>
                      </tr>	
                      <tr>
                        <td><span class="number">2</span> <?php echo $text_pr_logoman; ?></td>
                        <td width="30%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_logoman'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_logoman]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_logoman'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_logoman'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_logoman]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_logoman'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div> 
                        </td>
                      </tr>							
                      <tr>
                        <td><span class="number">3</span> <?php echo $text_pr_garantedtext; ?></td>
                        <td>
                          <?php foreach ($languages as $language) { ?>
                            <div class="input-group">
                              <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                              <textarea style="min-height: 100px; " name="oct_luxury_data[pr_garantedtext][<?php echo $language['code']; ?>]" id="oct_luxury_pr_garantedtext<?php echo $language['code']; ?>" class="form-control"><?php echo isset($oct_luxury_data['pr_garantedtext'][$language['code']]) ? $oct_luxury_data['pr_garantedtext'][$language['code']] : ''; ?></textarea>
                            </div><br />
                          <?php } ?>	
                        </td>
                      </tr>
                      <!--
                      <tr>
	                      <td><span class="number">4</span> <?php echo $text_pr_gallery; ?></td>
	                      <td width="30%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_gallery'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_gallery]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_gallery'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_gallery'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_gallery]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_gallery'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div> 
                        </td>
                      </tr>
                      -->
                      <tr>
	                      <td><span class="number">4</span> <?php echo $text_pr_zoom; ?></td>
	                      <td width="30%">
                          <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_zoom'] == 'on' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_zoom]"
                                value="on"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_zoom'] == 'on' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_yes; ?>
                            </label>
                            <label class="btn btn-info <?php echo $oct_luxury_data['pr_zoom'] == 'off' ? 'active' : ''; ?>">
                              <input type="radio"
                                name="oct_luxury_data[pr_zoom]"
                                value="off"
                                autocomplete="off"
                                style="display: none;"
                                <?php echo $oct_luxury_data['pr_zoom'] == 'off' ? 'checked="checked"' : ''; ?>
                              /><?php echo $text_no; ?>
                            </label>
                          </div> 
                        </td>
                      </tr>
                    </table>
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/product1.png" class="img-responsive" />
                  </div>	
                </div>
                <div class="tab-pane fade" id="sub_p_colors">
                  <div class="left-div">
                    <table class="form">
                      <tr>
                        <td><span class="number">1</span> <?php echo $text_pr_garantedcolor; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_garantedcolor]" value="<?php echo $oct_luxury_data['pr_garantedcolor']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">2</span> <?php echo $text_pr_garantedicon; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_garantedicon]" value="<?php echo $oct_luxury_data['pr_garantedicon']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">3</span> <?php echo $text_pr_photoborder; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_photoborder]" value="<?php echo $oct_luxury_data['pr_photoborder']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">4</span> <?php echo $text_pr_photoborderhover; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_photoborderhover]" value="<?php echo $oct_luxury_data['pr_photoborderhover']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">5</span> <?php echo $text_pr_bgright; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_bgright]" value="<?php echo $oct_luxury_data['pr_bgright']; ?>" class="spectrum" /></td>
                      </tr>	
                      <tr>
                        <td><span class="number">6</span> <?php echo $text_pr_activetabtext; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_activetabtext]" value="<?php echo $oct_luxury_data['pr_activetabtext']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">7</span> <?php echo $text_pr_activetabbg; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_activetabbg]" value="<?php echo $oct_luxury_data['pr_activetabbg']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">8</span> <?php echo $text_pr_activetabbgcont; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_activetabbgcont]" value="<?php echo $oct_luxury_data['pr_activetabbgcont']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">9</span> <?php echo $text_pr_activetabbgtext; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_activetabbgtext]" value="<?php echo $oct_luxury_data['pr_activetabbgtext']; ?>" class="spectrum" /></td>
                      </tr>							
                      <tr>
                        <td><span class="number">10</span> <?php echo $text_pr_tabtext; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_tabtext]" value="<?php echo $oct_luxury_data['pr_tabtext']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">11</span> <?php echo $text_pr_manufact_and_code; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_manufact_and_code]" value="<?php echo $oct_luxury_data['pr_manufact_and_code']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">12</span> <?php echo $text_pr_foundcheaper; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_foundcheaper]" value="<?php echo $oct_luxury_data['pr_foundcheaper']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">13</span> <?php echo $text_pr_buyoneclick; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_buyoneclick]" value="<?php echo $oct_luxury_data['pr_buyoneclick']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number">14</span> <?php echo $text_pr_pricecolor; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_pricecolor]" value="<?php echo $oct_luxury_data['pr_pricecolor']; ?>" class="spectrum" /></td>
                      </tr>
                      <tr>
                        <td><span class="number"></span> <?php echo $text_pr_oldpricecolor; ?></td>
                        <td width="25%"><input type="text" name="oct_luxury_data[pr_oldpricecolor]" value="<?php echo $oct_luxury_data['pr_oldpricecolor']; ?>" class="spectrum" /></td>
                      </tr>																																			                        
                    </table>  
                  </div>
                  <div class="right-div">
                    <img src="../catalog/view/theme/oct_luxury/image/product2.png" class="img-responsive" />
                  </div>	
                </div>
              </div>
            </div>
          </div>

          <!-- MOBILE SETTINGS -->       
          <div id="tab_mobile" class="tab-pane fade">
            <div class="left-div">
              <table class="form">
                <tr>
                  <td><span class="number">1</span> <?php echo $text_mob_mainlinebg; ?></td>
                  <td width="25%"><input type="text" name="oct_luxury_data[mob_mainlinebg]" value="<?php echo $oct_luxury_data['mob_mainlinebg']; ?>" class="spectrum"  /></td>
                </tr>              
                <tr>
                  <td><span class="number">2</span> <?php echo $text_mob_cartbg; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_cartbg]" value="<?php echo $oct_luxury_data['mob_cartbg']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">3</span> <?php echo $text_mob_carttexticocolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_carttexticocolor]" value="<?php echo $oct_luxury_data['mob_carttexticocolor']; ?>" class="spectrum" /></td>
                </tr> 		
                <tr>
                  <td><span class="number">4</span> <?php echo $text_mob_menubg; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_menubg]" value="<?php echo $oct_luxury_data['mob_menubg']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">5</span> <?php echo $text_mob_menucolor ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_menucolor]" value="<?php echo $oct_luxury_data['mob_menucolor']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">6</span> <?php echo $text_mob_sbbg; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sbbg]" value="<?php echo $oct_luxury_data['mob_sbbg']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">7</span> <?php echo $text_mob_sbh3; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sbh3]" value="<?php echo $oct_luxury_data['mob_sbh3']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">8</span> <?php echo $text_mob_sblinkcolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sblinkcolor]" value="<?php echo $oct_luxury_data['mob_sblinkcolor']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">9</span> <?php echo $text_mob_sbbuttoncolor; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sbbuttoncolor]" value="<?php echo $oct_luxury_data['mob_sbbuttoncolor']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">10</span> <?php echo $text_mob_sbbuttonicon; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sbbuttonicon]" value="<?php echo $oct_luxury_data['mob_sbbuttonicon']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">11</span> <?php echo $text_mob_sbbuttoncoloropened; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sbbuttoncoloropened]" value="<?php echo $oct_luxury_data['mob_sbbuttoncoloropened']; ?>" class="spectrum" /></td>
                </tr> 
                <tr>
                  <td><span class="number">12</span> <?php echo $text_mob_sbbuttoniconopened; ?></td>
                  <td><input type="text" name="oct_luxury_data[mob_sbbuttoniconopened]" value="<?php echo $oct_luxury_data['mob_sbbuttoniconopened']; ?>" class="spectrum" /></td>
                </tr> 					
              </table>
            </div>
            <div class="right-div">
              <img src="../catalog/view/theme/oct_luxury/image/mobile.png" class="img-responsive" />
            </div>	
          </div>

          <!-- CONTACT SETTINGS -->       
          <div id="tab_contacts" class="tab-pane fade">
            <div>
              <table class="form">
                <tr>
                  <td><?php echo $text_cont_phones; ?></td>
                  <td><textarea style="min-height: 100px;" name="oct_luxury_data[cont_phones]" id="oct_luxury_cont_phones" class="form-control"><?php echo $oct_luxury_data['cont_phones']; ?></textarea></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_whatsapp_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_whatsapp_id]" value="<?php echo (isset($oct_luxury_data['ps_whatsapp_id']) && $oct_luxury_data['ps_whatsapp_id']) ? $oct_luxury_data['ps_whatsapp_id'] : ''; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_telegram_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_telegram_id]" value="<?php echo (isset($oct_luxury_data['ps_telegram_id']) && $oct_luxury_data['ps_telegram_id']) ? $oct_luxury_data['ps_telegram_id'] : ''; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_viber_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_viber_id]" value="<?php echo (isset($oct_luxury_data['ps_viber_id']) && $oct_luxury_data['ps_viber_id']) ? $oct_luxury_data['ps_viber_id'] : ''; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_cont_skype; ?></td>
                  <td><input type="text" name="oct_luxury_data[cont_skype]" value="<?php echo $oct_luxury_data['cont_skype']; ?>"  style="width: 100%"/></td>
                </tr>      
                <tr>
                  <td><?php echo $text_cont_email; ?></td>
                  <td><input type="text" name="oct_luxury_data[cont_email]" value="<?php echo $oct_luxury_data['cont_email']; ?>"  style="width: 100%"/></td>
                </tr> 
                <tr>
                  <td><?php echo $text_cont_adress; ?></td>
                  <td>
                    <?php foreach ($languages as $language) { ?>
                      <div class="input-group">
                        <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <textarea style="min-height: 100px;" name="oct_luxury_data[cont_adress][<?php echo $language['code']; ?>]" id="oct_luxury_cont_adress<?php echo $language['code']; ?>" class="form-control"><?php echo isset($oct_luxury_data['cont_adress'][$language['code']]) ? $oct_luxury_data['cont_adress'][$language['code']] : ''; ?></textarea>
                      </div><br />
                    <?php } ?>	
                  </td>
                </tr>	
                <tr>
                  <td><?php echo $text_cont_clock; ?></td>
                  <td>
                    <?php foreach ($languages as $language) { ?>
                      <div class="input-group">
                        <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <textarea style="min-height: 100px;" name="oct_luxury_data[cont_clock][<?php echo $language['code']; ?>]" id="oct_luxury_cont_clock<?php echo $language['code']; ?>" class="form-control"><?php echo isset($oct_luxury_data['cont_clock'][$language['code']]) ? $oct_luxury_data['cont_clock'][$language['code']] : ''; ?></textarea>
                      </div><br />
                    <?php } ?>	
                  </td>
                </tr>										          	
                <tr>
                  <td><?php echo $text_cont_contacthtml; ?></td>
                  <td>
                    <?php foreach ($languages as $language) { ?>
                      <div class="input-group">
                        <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <textarea style="min-height: 100px;" name="oct_luxury_data[cont_contacthtml][<?php echo $language['code']; ?>]" id="oct_luxury_cont_contacthtml<?php echo $language['code']; ?>" class="form-control"><?php echo isset($oct_luxury_data['cont_contacthtml'][$language['code']]) ? $oct_luxury_data['cont_contacthtml'][$language['code']] : ''; ?></textarea>
                      </div><br />
                    <?php } ?>	
                  </td>
                </tr>	
                <tr>
                  <td><?php echo $text_cont_contactmap; ?></td>
                  <td><textarea style="min-height: 100px;" name="oct_luxury_data[cont_contactmap]" id="oct_luxury_cont_contactmap" class="form-control"><?php echo $oct_luxury_data['cont_contactmap']; ?></textarea></td>
                </tr>							
              </table>
            </div>
            	
          </div>

          <!-- PAYMENN SOCIALS SETTINGS -->       
          <div id="tab_payment_soc" class="tab-pane fade">
            <h2 class="titletd"><span><?php echo $text_ps_soc; ?></span></h2>	
            <div class="leftdivs">
              <table class="form">
                <tr>
                  <td style="width: 20%;"><?php echo $text_ps_facebook_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_facebook_id]" value="<?php echo $oct_luxury_data['ps_facebook_id']; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_vk_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_vk_id]" value="<?php echo $oct_luxury_data['ps_vk_id']; ?>" /></td>
                </tr>  
                <tr>
                  <td><?php echo $text_ps_gplus_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_gplus_id]" value="<?php echo $oct_luxury_data['ps_gplus_id']; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_odnoklass_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_odnoklass_id]" value="<?php echo $oct_luxury_data['ps_odnoklass_id']; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_twitter_username; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_twitter_username]" value="<?php echo $oct_luxury_data['ps_twitter_username']; ?>" /></td>
                </tr>
              </table>
            </div>
            <div class="leftdivs">
              <table class="form">
                <tr>
                  <td><?php echo $text_ps_vimeo_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_vimeo_id]" value="<?php echo $oct_luxury_data['ps_vimeo_id']; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_pinterest_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_pinterest_id]" value="<?php echo $oct_luxury_data['ps_pinterest_id']; ?>" /></td>
                </tr> 
                <tr>
                  <td><?php echo $text_ps_flick_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_flick_id]" value="<?php echo $oct_luxury_data['ps_flick_id']; ?>" /></td>
                </tr>
                <tr>
                  <td><?php echo $text_ps_instagram; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_instagram]" value="<?php echo $oct_luxury_data['ps_instagram']; ?>" /></td>
                </tr> 
                <tr>
                  <td><?php echo $text_ps_youtube_id; ?></td>
                  <td><input class="form-control" type="text" name="oct_luxury_data[ps_youtube_id]" value="<?php echo $oct_luxury_data['ps_youtube_id']; ?>" /></td>
                </tr>
              </table>		         
            </div>	      
            <h2 class="titletd" style="clear: both;"><span><?php echo $text_ps_methots; ?></span></h2>
            <table class="form">
              <tr>
                <td colspan="2">
                  <div class="pay-methods">
                    <img src="view/image/pay/sberbank.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_sberbank'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_sberbank]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_sberbank'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_sberbank'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_sberbank]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_sberbank'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div> 
                  </div>      
                  <div class="pay-methods">
                    <img src="view/image/pay/privat.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_privat'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_privat]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_privat'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_privat'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_privat]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_privat'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>     
                  <div class="pay-methods">
                    <img src="view/image/pay/yamoney.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_yamoney'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_yamoney]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_yamoney'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_yamoney'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_yamoney]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_yamoney'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div> 
                  <div class="pay-methods">
                    <img src="view/image/pay/webmoney.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_webmoney'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_webmoney]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_webmoney'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_webmoney'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_webmoney]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_webmoney'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>    
                  <div class="pay-methods">
                    <img src="view/image/pay/visa.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_visa'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_visa]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_visa'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_visa'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_visa]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_visa'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                  <div class="pay-methods">
                    <img src="view/image/pay/qiwi.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_qiwi'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_qiwi]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_qiwi'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_qiwi'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_qiwi]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_qiwi'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>   			                
                  <div class="pay-methods">
                    <img src="view/image/pay/skrill.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_skrill'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_skrill]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_skrill'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_skrill'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_skrill]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_skrill'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>                       	
                  <div class="pay-methods">
                    <img src="view/image/pay/interkassa.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_interkassa'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_interkassa]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_interkassa'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_interkassa'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_interkassa]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_interkassa'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>    	
                  <div class="pay-methods">
                    <img src="view/image/pay/liqpay.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_liqpay'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_liqpay]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_liqpay'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_liqpay'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_liqpay]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_liqpay'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>  	
                  <div class="pay-methods">
                    <img src="view/image/pay/paypal.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_paypal'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_paypal]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_paypal'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_paypal'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_paypal]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_paypal'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>                
                  <div class="pay-methods">
                    <img src="view/image/pay/robokassa.png" /><br />
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_robokassa'] == 'on' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_robokassa]"
                          value="on"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_robokassa'] == 'on' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-info <?php echo $oct_luxury_data['ps_robokassa'] == 'off' ? 'active' : ''; ?>">
                        <input type="radio"
                          name="oct_luxury_data[ps_robokassa]"
                          value="off"
                          autocomplete="off"
                          style="display: none;"
                          <?php echo $oct_luxury_data['ps_robokassa'] == 'off' ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div> 
                </td>  
              </tr>
            </table>
            <h2 class="titletd"><span>Дополнительные иконки платежных систем</span></h2>
            <div class="table-responsive">
              <table id="ps-additional-icons" class="form">
                <thead>
                  <tr>
                    <td class="text-left"><?php echo $entry_ps_additional_icon; ?></td>
                    <td class="text-right"><?php echo $entry_ps_additional_sort_order; ?></td>
                    <td></td>
                  </tr>
                </thead>
                <tbody>
                  <?php $ps_additional_icon_row = 0; ?>
                  <?php if ($ps_additional_icons) { ?>
                    <?php foreach ($ps_additional_icons as $ps_additional_icon) { ?>
                    <tr id="ps-additional-icon<?php echo $ps_additional_icon_row; ?>">
                      <td class="text-left"><a href="" id="thumb-image<?php echo $ps_additional_icon_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $ps_additional_icon['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="oct_luxury_data[ps_additional_icons][<?php echo $ps_additional_icon_row; ?>][image]" value="<?php echo $ps_additional_icon['image']; ?>" id="input-image<?php echo $ps_additional_icon_row; ?>" /></td>
                      <td class="text-right"><input type="text" name="oct_luxury_data[ps_additional_icons][<?php echo $ps_additional_icon_row; ?>][sort_order]" value="<?php echo $ps_additional_icon['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
                      <td class="text-left"><button type="button" onclick="$('#ps-additional-icon<?php echo $ps_additional_icon_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>
                    </tr>
                    <?php $ps_additional_icon_row++; ?>
                    <?php } ?>
                  <?php } ?>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="2"></td>
                    <td class="text-left"><button type="button" onclick="addPsAdditionalIcon();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_add; ?></button></td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>    
          
          <!-- CUSTOM CSS - JAVSCRIPT -->       
          <div id="tab_cssjs" class="tab-pane fade">
            
              <table class="form">
                   <tr>
                  <td><?php echo $text_css; ?></td>
                  <td><textarea style="min-height: 380px;" name="oct_luxury_data[customcss]" class="form-control"><?php echo $oct_luxury_data['customcss']; ?></textarea></td>
                </tr>
                <tr>
                  <td><?php echo $text_javascript; ?></td>
                  <td><textarea style="min-height: 380px;" name="oct_luxury_data[customjavascrip]" class="form-control"><?php echo $oct_luxury_data['customjavascrip']; ?></textarea></td>
                </tr>
              </table> 
          </div>
					<!-- IMAGES AND LIMITS --> 
          <div id="tab-limit-and-image" class="tab-pane">
	          <div class="panel panel-default">
		      <div class="panel-body">
              <fieldset>
                <legend><?php echo $text_product; ?></legend>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-catalog-limit"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>"><?php echo $entry_product_limit; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="oct_luxury_product_limit" value="<?php echo $oct_luxury_product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-catalog-limit" class="form-control" />
                    <?php if ($error_product_limit) { ?>
                    <div class="text-danger"><?php echo $error_product_limit; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-description-limit"><span data-toggle="tooltip" title="<?php echo $help_product_description_length; ?>"><?php echo $entry_product_description_length; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="oct_luxury_product_description_length" value="<?php echo $oct_luxury_product_description_length; ?>" placeholder="<?php echo $entry_product_description_length; ?>" id="input-description-limit" class="form-control" />
                    <?php if ($error_product_description_length) { ?>
                    <div class="text-danger"><?php echo $error_product_description_length; ?></div>
                    <?php } ?>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_image; ?></legend>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_category_width" value="<?php echo $oct_luxury_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-category-width" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_category_height" value="<?php echo $oct_luxury_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_category) { ?>
                    <div class="text-danger"><?php echo $error_image_category; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_thumb_width" value="<?php echo $oct_luxury_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-thumb-width" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_thumb_height" value="<?php echo $oct_luxury_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_thumb) { ?>
                    <div class="text-danger"><?php echo $error_image_thumb; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_popup_width" value="<?php echo $oct_luxury_image_popup_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-popup-width" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_popup_height" value="<?php echo $oct_luxury_image_popup_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_popup) { ?>
                    <div class="text-danger"><?php echo $error_image_popup; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_product_width" value="<?php echo $oct_luxury_image_product_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-product-width" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_product_height" value="<?php echo $oct_luxury_image_product_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_product) { ?>
                    <div class="text-danger"><?php echo $error_image_product; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_additional_width" value="<?php echo $oct_luxury_image_additional_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-additional-width" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_additional_height" value="<?php echo $oct_luxury_image_additional_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_additional) { ?>
                    <div class="text-danger"><?php echo $error_image_additional; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-related"><?php echo $entry_image_related; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_related_width" value="<?php echo $oct_luxury_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-related" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_related_height" value="<?php echo $oct_luxury_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_related) { ?>
                    <div class="text-danger"><?php echo $error_image_related; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_compare_width" value="<?php echo $oct_luxury_image_compare_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-compare" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_compare_height" value="<?php echo $oct_luxury_image_compare_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_compare) { ?>
                    <div class="text-danger"><?php echo $error_image_compare; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_wishlist_width" value="<?php echo $oct_luxury_image_wishlist_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wishlist" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_wishlist_height" value="<?php echo $oct_luxury_image_wishlist_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_wishlist) { ?>
                    <div class="text-danger"><?php echo $error_image_wishlist; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_cart_width" value="<?php echo $oct_luxury_image_cart_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_cart_height" value="<?php echo $oct_luxury_image_cart_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_cart) { ?>
                    <div class="text-danger"><?php echo $error_image_cart; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-image-location"><?php echo $entry_image_location; ?></label>
                  <div class="col-sm-10">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_location_width" value="<?php echo $oct_luxury_image_location_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control" />
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="oct_luxury_image_location_height" value="<?php echo $oct_luxury_image_location_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                      </div>
                    </div>
                    <?php if ($error_image_location) { ?>
                    <div class="text-danger"><?php echo $error_image_location; ?></div>
                    <?php } ?>
                  </div>
                </div>
              </fieldset>
              </div>
              </div>
            </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>
<script type="text/javascript">
$(".spectrum").spectrum({
	preferredFormat: "rgb",
	showInitial: true,
	showInput: true,
	showAlpha: true,
	showPalette: true,
	palette: [["red", "rgba(0, 255, 0, .5)", "rgb(0, 0, 255)"]]
});
</script>
<script type="text/javascript"><!--
$("ul.nav-tabs a").click(function (e) {
  e.preventDefault();  
  $(this).tab('show');
}); 

$('.summernote').summernote({
  height: 200
});

<?php foreach ($languages as $language) { ?>
  $('#oct_luxury_yamap_text<?php echo $language['code']; ?>').summernote({
    height: 200
  });
  $('#oct_luxury_cont_abouttext<?php echo $language['code']; ?>').summernote({
    height: 140
  });
<?php } ?>

function image_upload(field, preview) {
  $('#dialog').remove();

  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

  $('#dialog').dialog({
      title: '<?php echo $text_image_manager; ?>',
      close: function (event, ui) {
        if ($('#' + field).attr('value')) {
          $.ajax({
            url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
            dataType: 'text',
            success: function(data) {
            $('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: 800,
    height: 400,
    resizable: false,
    modal: false
  });
}
//--></script>
<script type="text/javascript"><!--
var ps_additional_icon_row = <?php echo $ps_additional_icon_row; ?>;

function addPsAdditionalIcon() {
  html  = '<tr id="ps-additional-icon-row' + ps_additional_icon_row + '">';
  html += '  <td class="text-left"><a href="" id="thumb-image' + ps_additional_icon_row + '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="oct_luxury_data[ps_additional_icons][' + ps_additional_icon_row + '][image]" value="" id="input-image' + ps_additional_icon_row + '" /></td>';
  html += '  <td class="text-right"><input type="text" name="oct_luxury_data[ps_additional_icons][' + ps_additional_icon_row + '][sort_order]" value="0" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
  html += '  <td class="text-left"><button type="button" onclick="$(\'#ps-additional-icon-row' + ps_additional_icon_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $button_remove; ?></button></td>';
  html += '</tr>';

  $('#ps-additional-icons tbody').append(html);

  ps_additional_icon_row++;
}
//--></script>
<?php echo $footer; ?>