<?php
/**
 * Module: AdvTags
 * Admin template
 */
?>
<?=$header?>
<?=$column_left?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-account" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-account" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="advtags_status" id="input-status" class="form-control">
                <?php if ($advtags_status) { ?>
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
        <label class="col-sm-2 control-label"><?='Активировать Facebook Pixel'?></label>
            <div class="col-sm-10">
              <select name="advtags_fbq_status" id="input-status" class="form-control">
                <?php if ($advtags_fbq_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
      </div>
          <div class="fbq-settings" style="display: none;">
            <div class="form-group">              
                <label class="col-sm-2 control-label"><?=$text_pixel?></label>
                <div class="col-sm-10">
                  <input type="text" name="advtags_fbq_pixel" class="form-control" value="<?=$advtags_fbq_pixel?>"/>
                </div>
            </div>
            <div class="form-group">              
                <label class="col-sm-2 control-label"><?=$text_send_fb_events?></label>
                <div class="col-sm-10">
                  <select name="advtags_fbq_events" class="form-control">
            <option value="0"<?=$advtags_fbq_events==0?' selected':''?>><?=$text_no?></option>
            <option value="1"<?=$advtags_fbq_events==1?' selected':''?>><?=$text_all?></option>
            <option value="2"<?=$advtags_fbq_events==2?' selected':''?>><?=$text_purchase_only?></option>
                  </select>
        </div>
            </div>
            <div class="form-group">              
                <label class="col-sm-2 control-label"><?=$text_fb_gen_feed?></label>
                <div class="col-sm-10">
                  <select name="advtags_fbq_gen_feed" class="form-control">
            <option value="0"<?=$advtags_fbq_gen_feed==0?' selected':''?>><?=$text_no?></option>
            <option value="1"<?=$advtags_fbq_gen_feed==1?' selected':''?>><?=$text_yes_direct?></option>
            <option value="2"<?=$advtags_fbq_gen_feed==2?' selected':''?>><?=$text_yes_file?></option>
                  </select>
        </div>
            </div>
          </div>
  
      <div class="form-group">
        <label class="col-sm-2 control-label"><?='Активировать Gtag'?></label>
            <div class="col-sm-10">
              <select name="advtags_gtag_status" id="input-status" class="form-control">
                <?php if ($advtags_gtag_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
      </div>
      <div class="gtag-settings">
        <div class="form-group">              
            <label class="col-sm-2 control-label"><?=$text_gtag_tracker?></label>
            <div class="col-sm-10">
              <input type="text" name="advtags_gtag_tracker" class="form-control" value="<?=$advtags_gtag_tracker?>"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label"><?=$text_gtag_conversion?></label>
            <div class="col-sm-10">
              <input type="text" name="advtags_gtag_conversion" class="form-control" value="<?=$advtags_gtag_conversion?>"/>
            </div>
        </div>
        <div class="form-group">              
            <label class="col-sm-2 control-label"><?=$text_send_gtag_events?></label>
            <div class="col-sm-10">
              <select name="advtags_gtag_events" class="form-control">
                <option value="0"<?=$advtags_gtag_events==0?' selected':''?>><?=$text_no?></option>
                <option value="1"<?=$advtags_gtag_events==1?' selected':''?>><?=$text_all?></option>
                <option value="2"<?=$advtags_gtag_events==2?' selected':''?>><?=$text_converion_only?></option>
              </select>
            </div>
        </div>
      </div>

        </form>
      </div>
    </div>
  </div>
</div>
<script>
  $(function(){
    $('select[name="advtags_fbq_status"]').change(function(){
      if($(this).val()==1) {
        $('.fbq-settings').show();
      } else {
        $('.fbq-settings').hide();
      }
    }).trigger('change');
    $('select[name="advtags_gtag_status"]').change(function(){
      if($(this).val()==1) {
        $('.gtag-settings').show();
      } else {
        $('.gtag-settings').hide();
      }
    }).trigger('change');

  });
</script>

<?=$footer?>