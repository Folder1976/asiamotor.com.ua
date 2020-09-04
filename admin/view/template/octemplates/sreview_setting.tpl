<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#setting-tab" data-toggle="tab"><?php echo $tab_setting; ?></a></li>
            <li><a href="#data-tab" data-toggle="tab"><?php echo $tab_data; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="setting-tab">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="oct_sreview_setting_data[status]" id="input-status" class="form-control">
                    <?php if ($oct_sreview_setting_data['status']) { ?>
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
                <label class="col-sm-2 control-label" for="input-review_admin_email"><?php echo $entry_review_admin_email; ?></label>
                <div class="col-sm-10">
                  <select name="oct_sreview_setting_data[review_admin_email]" id="input-review_admin_email" class="form-control">
                    <?php if (isset($oct_sreview_setting_data['review_admin_email']) && $oct_sreview_setting_data['review_admin_email']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div id="email_to" <?php if (isset($oct_sreview_setting_data['review_admin_email']) && !$oct_sreview_setting_data['review_admin_email']) { ?>style="display:none" <?php } ?>>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-review_email_to"><?php echo $entry_review_email_to; ?></label>
                    <div class="col-sm-10">
                         <input type="text" name="oct_sreview_setting_data[review_email_to]" value="<?php echo isset($oct_sreview_setting_data['review_email_to']) ? $oct_sreview_setting_data['review_email_to'] : $config_email; ?>" id="input-review_email_to" placeholder="<?php echo $entry_review_email_to; ?>" class="form-control" />
                    </div>
                  </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-review_moderation"><?php echo $entry_review_moderation; ?></label>
                <div class="col-sm-10">
                  <select name="oct_sreview_setting_data[review_moderation]" id="input-review_moderation" class="form-control">
                    <?php if ($oct_sreview_setting_data['review_moderation']) { ?>
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
            <div class="tab-pane" id="data-tab">
                <ul class="nav nav-tabs" id="language">
                  <?php foreach ($languages as $language) { ?>
                  <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                  <?php } ?>
                </ul>
                <div class="tab-content">
                    <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                            <div class="form-group">
                                 <label class="col-sm-2 control-label"><?php echo $text_seo_title; ?></label>
                                 <div class="col-sm-10">
                                     <input type="text" name="oct_sreview_setting_data[language][<?php echo $language['language_id']; ?>][seo_title]" value="<?php echo isset($oct_sreview_setting_data['language'][$language['language_id']]) ? $oct_sreview_setting_data['language'][$language['language_id']]['seo_title'] : ''; ?>" class="form-control" />
                                 </div>
                            </div>
                            <div class="form-group">
                                 <label class="col-sm-2 control-label"><?php echo $text_seo_h1; ?></label>
                                 <div class="col-sm-10">
                                     <input type="text" name="oct_sreview_setting_data[language][<?php echo $language['language_id']; ?>][seo_h1]" value="<?php echo isset($oct_sreview_setting_data['language'][$language['language_id']]) ? $oct_sreview_setting_data['language'][$language['language_id']]['seo_h1'] : ''; ?>" class="form-control" />
                                 </div>
                            </div>
                            <div class="form-group">
                                 <label class="col-sm-2 control-label"><?php echo $text_seo_meta_description; ?></label>
                                 <div class="col-sm-10">
                                     <textarea name="oct_sreview_setting_data[language][<?php echo $language['language_id']; ?>][seo_meta_description]" class="form-control"><?php echo isset($oct_sreview_setting_data['language'][$language['language_id']]) ? $oct_sreview_setting_data['language'][$language['language_id']]['seo_meta_description'] : ''; ?></textarea>
                                 </div>
                            </div>
                            <div class="form-group">
                                 <label class="col-sm-2 control-label"><?php echo $text_seo_meta_keywords; ?></label>
                                 <div class="col-sm-10">
                                     <textarea name="oct_sreview_setting_data[language][<?php echo $language['language_id']; ?>][seo_meta_keywords]" class="form-control"><?php echo isset($oct_sreview_setting_data['language'][$language['language_id']]) ? $oct_sreview_setting_data['language'][$language['language_id']]['seo_meta_keywords'] : ''; ?></textarea>
                                 </div>
                            </div>
                            <div class="form-group">
                                 <label class="col-sm-2 control-label"><?php echo $text_seo_description; ?></label>
                                 <div class="col-sm-10">
                                     <textarea id="seo_description<?php echo $language['language_id']; ?>" name="oct_sreview_setting_data[language][<?php echo $language['language_id']; ?>][seo_description]" class="form-control summernote"><?php echo isset($oct_sreview_setting_data['language'][$language['language_id']]) ? $oct_sreview_setting_data['language'][$language['language_id']]['seo_description'] : ''; ?></textarea>
                                 </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
  <?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
      ckeditorInit('seo_description<?php echo $language['language_id']; ?>', getURLVar('token'));
    <?php } ?>
  <?php } ?>
</script>
<script>
    $('#language a:first').tab('show');
</script>
<script>
$(function() {
    $('select#input-review_admin_email').change(function() {
        var v = $(this).val();

        if (v == 1) {
            $("#email_to").slideDown('slow');
        } else {
            $("#email_to").slideUp('slow');
        }
    });
});
</script>
<?php echo $footer; ?>