<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-google-analytics" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-google-analytics" class="form-horizontal">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                <li><a href="#tab-google" data-toggle="tab"><?php echo $tab_google; ?></a></li>
                <li><a href="#tab-yandex" data-toggle="tab"><?php echo $tab_yandex; ?></a></li>
                <?php if ((isset($oct_analytics_google_status) && $oct_analytics_google_status) || (isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status)) { ?>
                <li><a href="#tab-targets" data-toggle="tab"><?php echo $tab_targets; ?></a></li>
                <?php } ?>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab-general">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                      <div class="col-sm-10">
                        <select name="oct_analytics_status" id="input-status" class="form-control">
                          <?php if ($oct_analytics_status) { ?>
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                          <?php } else { ?>
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="form-group" style="display:none">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_position; ?></label>
                        <div class="col-sm-10">
                          <select name="oct_analytics_position" id="input-status" class="form-control">
                            <option value="1" selected="selected"><?php echo $text_footer; ?></option>
                          </select>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab-google">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-google-status"><?php echo $entry_status; ?></label>
                      <div class="col-sm-10">
                        <select name="oct_analytics_google_status" id="input-google-status" class="form-control">
                          <?php if ($oct_analytics_google_status) { ?>
                              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                              <option value="0"><?php echo $text_disabled; ?></option>
                          <?php } else { ?>
                              <option value="1"><?php echo $text_enabled; ?></option>
                              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div id="google_block" <?php if (!isset($oct_analytics_google_status) || (isset($oct_analytics_google_status) && !$oct_analytics_google_status)) { ?>style="display:none" <?php } ?>>
                        <div class="form-group <?php if ($oct_analytics_google_status) { echo "required"; }?>">
                          <div class="col-sm-12">
                              <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_signup_google; ?>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                          </div>
                          <label class="col-sm-2 control-label" for="input-google-code"><?php echo $entry_google_code; ?></label>
                          <div class="col-sm-10">
                              <input type="text" name="oct_analytics_google_code" placeholder="UA-100995184-2" id="input-google-code" value="<?php echo $oct_analytics_google_code; ?>" class="form-control" />
                              <?php if ($error_google_code) { ?>
                                  <div class="text-danger"><?php echo $error_google_code; ?></div>
                              <?php } ?>
                          </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-yandex-webmaster">Google Webmaster</label>
                            <div class="col-sm-10">
                                <input type="text" name="oct_analytics_google_webmaster_code" value="<?php echo $oct_analytics_google_webmaster_code; ?>" placeholder="<meta name='google-site-verification' content='asdasdDSDSdscsdccsDS' />" id="input-oct_analytics_google_webmaster_code" class="form-control code" />
                            </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-status"><?php echo $text_google_ecommerce; ?></label>
                          <div class="col-sm-10">
                            <select name="oct_analytics_google_ecommerce" id="input-status" class="form-control">
                              <?php if ($oct_analytics_google_ecommerce) { ?>
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
                </div>
                <div class="tab-pane" id="tab-yandex">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-yandex-status"><?php echo $entry_status; ?></label>
                      <div class="col-sm-10">
                        <select name="oct_analytics_yandex_status" id="input-yandex-status" class="form-control">
                          <?php if ($oct_analytics_yandex_status) { ?>
                              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                              <option value="0"><?php echo $text_disabled; ?></option>
                          <?php } else { ?>
                              <option value="1"><?php echo $text_enabled; ?></option>
                              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div id="yandex_block" <?php if (!isset($oct_analytics_yandex_status) || (isset($oct_analytics_yandex_status) && !$oct_analytics_yandex_status)) { ?>style="display:none" <?php } ?>>
                        <div class="form-group <?php if ($oct_analytics_yandex_status) { echo "required"; }?>">
                          <div class="col-sm-12">
                              <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_signup_yandex; ?>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                          </div>
                          <label class="col-sm-2 control-label" for="input-yandex-code"><?php echo $entry_yandex_code; ?></label>
                          <div class="col-sm-10">
                              <input type="text" name="oct_analytics_yandex_code" placeholder="36790405" id="input-yandex-code" value="<?php echo $oct_analytics_yandex_code; ?>" class="form-control" />
                              <?php if ($error_yandex_code) { ?>
                                  <div class="text-danger"><?php echo $error_yandex_code; ?></div>
                              <?php } ?>
                          </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-yandex-webmaster">Yandex.Webmaster</label>
                            <div class="col-sm-10">
                                <input type="text" name="oct_analytics_yandex_webmaster_code" value="<?php echo $oct_analytics_yandex_webmaster_code; ?>" placeholder="<meta name='yandex-verification' content='456d4sa5d4sa65d4' />" id="input-oct_analytics_yandex_webmaster_code" class="form-control code">
                            </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-status"><?php echo $text_yandex_ecommerce; ?></label>
                          <div class="col-sm-10">
                            <select name="oct_analytics_yandex_ecommerce" id="input-status" class="form-control">
                              <?php if ($oct_analytics_yandex_ecommerce) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                              <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                              <?php } ?>
                            </select>
                          </div>
                        </div>
                        <div class="form-group <?php if ($oct_analytics_yandex_ecommerce) { echo "required"; }?>">
                          <label class="col-sm-2 control-label" for="input-yandex-code"><?php echo $entry_yandex_data_container; ?></label>
                          <div class="col-sm-10">
                              <input type="text" name="oct_analytics_yandex_container" placeholder="dataMetrikLayer" id="input-yandex-data-container" value="<?php echo (isset($oct_analytics_yandex_container) && !empty($oct_analytics_yandex_container)) ? $oct_analytics_yandex_container : "dataMetrikLayer"; ?>" class="form-control" />
                              <?php if ($error_yandex_container) { ?>
                                  <div class="text-danger"><?php echo $error_yandex_container; ?></div>
                              <?php } ?>
                          </div>
                        </div>
                    </div>
                </div>
                <?php if ((isset($oct_analytics_google_status) && $oct_analytics_google_status) || (isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status)) { ?>
                <div class="tab-pane" id="tab-targets">
                    <fieldset>
                        <legend><?php echo $tab_targets; ?></legend>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover" id="oct_targets">
                              <thead>
                                <tr>
                                  <td class="text-left"><?php echo $column_atribute; ?></td>
                                  <td class="text-left"><?php echo $column_category; ?></td>
                                  <td class="text-left"><?php echo $column_action; ?></td>
                                  <?php if (isset($oct_analytics_google_status) && $oct_analytics_google_status) { ?>
                                  <td class="text-left"><?php echo $column_google; ?></td>
                                  <?php } ?>
                                  <?php if (isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status) { ?>
                                  <td class="text-left"><?php echo $column_yandex; ?></td>
                                  <?php } ?>
                                  <td></td>
                                </tr>
                              </thead>
                              <tbody>
                                <?php $targets_field_row = 0; ?>
                                <?php if ($oct_analytics_targets) { ?>
                                <?php foreach ($oct_analytics_targets as $target) { ?>
                                <tr id="target_field-<?php echo $targets_field_row; ?>">
                                  <td class="text-left"><input type="text" name="oct_analytics_targets[<?php echo $targets_field_row?>][atribute]" placeholder=".button-cart, #button-cart" value="<?php echo $target->atribute; ?>" class="form-control" /></td>
                                  <td class="text-left"><input type="text" name="oct_analytics_targets[<?php echo $targets_field_row?>][category]" placeholder=".button-cart, #button-cart" value="<?php echo $target->category; ?>" class="form-control" /></td>
                                  <td class="text-left"><input type="text" name="oct_analytics_targets[<?php echo $targets_field_row?>][action]" placeholder=".button-cart, #button-cart" value="<?php echo $target->action; ?>" class="form-control" /></td>
                                  <?php if (isset($oct_analytics_google_status) && $oct_analytics_google_status) { ?>
                                  <td class="text-left">
                                      <select name="oct_analytics_targets[<?php echo $targets_field_row?>][google]" class="form-control">
                                        <?php if ($target->google) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                      </select>
                                  </td>
                                  <?php } ?>
                                  <?php if (isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status) { ?>
                                  <td class="text-left">
                                      <select name="oct_analytics_targets[<?php echo $targets_field_row?>][yandex]" class="form-control">
                                        <?php if ($target->yandex) { ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                            <option value="1"><?php echo $text_enabled; ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                      </select>
                                  </td>
                                  <?php } ?>
                                  <td class="text-right"><button type="button" onclick="$('#target_field-<?php echo $targets_field_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                </tr>
                                <?php $targets_field_row++; ?>
                                <?php } ?>
                                <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <?php
                                    $i = 0;
                                    if (isset($oct_analytics_google_status) && $oct_analytics_google_status) {
                                        $i++;
                                    }
                                    if (isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status) {
                                        $i++;
                                    }

                                    $k = $i + 3;
                                    ?>
                                    <td colspan="<?php echo $k; ?>"></td>
                                    <td class="text-right">
                                        <a href="javascript:;" onclick="addTargetField();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                                    </td>
                                </tr>
                            </tfoot>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <?php } ?>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
$(function() {
    $('select#input-google-status').change(function() {
        var v = $(this).val();

        if (v == 1) {
            $("#google_block").slideDown('slow');
        } else {
            $("#google_block").slideUp('slow');
        }
    });

    $('select#input-yandex-status').change(function() {
        var v = $(this).val();

        if (v == 1) {
            $("#yandex_block").slideDown('slow');
        } else {
            $("#yandex_block").slideUp('slow');
        }
    });
});
</script>

<script type="text/javascript"><!--
var targets_field_row = <?php echo isset($targets_field_row) ? $targets_field_row : 0; ?>;

function addTargetField() {
    html  = '<tr id="target_field-' + targets_field_row + '">';
    html += '  <td class="text-left"><input type="text" name="oct_analytics_targets[' + targets_field_row + '][atribute]" placeholder=".button-cart, #button-cart" value="" class="form-control" /></td>';
    html += '  <td class="text-left"><input type="text" name="oct_analytics_targets[' + targets_field_row + '][category]" placeholder="cart" value="" class="form-control" /></td>';
    html += '  <td class="text-left"><input type="text" name="oct_analytics_targets[' + targets_field_row + '][action]" placeholder="AddProduct" value="" class="form-control" /></td>';
    <?php if (isset($oct_analytics_google_status) && $oct_analytics_google_status) { ?>
    html += '<td class="text-left">';
    html += '<select name="oct_analytics_targets[' + targets_field_row + '][google]" class="form-control">';
    html += '<option value="1"><?php echo $text_enabled; ?></option>';
    html += '<option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
    html += '</select>';
    html += '</td>';
    <?php } ?>
    <?php if (isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status) { ?>
    html += '<td class="text-left">';
    html += '<select name="oct_analytics_targets[' + targets_field_row + '][yandex]" class="form-control">';
    html += '<option value="1"><?php echo $text_enabled; ?></option>';
    html += '<option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
    html += '</select>';
    html += '</td>';
    <?php } ?>
    html += '   <td class="text-right"><button type="button" onclick="$(\'#target_field-' + targets_field_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
    html += '</tr>';

    $('#oct_targets tbody').append(html);

    targets_field_row++;
}
//--></script>
<?php echo $footer; ?>
