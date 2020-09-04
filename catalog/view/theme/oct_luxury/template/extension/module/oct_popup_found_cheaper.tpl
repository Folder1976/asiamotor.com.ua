<div id="cheaper-popup" class="white-popup mfp-with-anim">
  <h2 class="popup-header"><?php echo $heading_title; ?></h2>
  <div class="popup-center">
    <div class="popup-text">
      <?php if (isset($heading_title_product)) { ?>
      <h3><?php echo $heading_title_product; ?></h3>
      <?php } ?>
      <?php if (isset($thumb)) { ?>
      <img src="<?php echo $thumb; ?>" alt="" class="img-responsive" />
      <?php } ?>
      <?php if (isset($price) && isset($special)) { ?>
        <?php if (!$special) { ?>
        <p><?php echo $price; ?></p>
        <?php } else { ?>
        <p><span class="cheaper-price-old" style="text-decoration: line-through;"><?php echo $price; ?></span> <span class="cheaper-price-new"><?php echo $special; ?></span></p>
        <?php } ?>
      <?php } ?>
    </div>
    <form method="post" enctype="multipart/form-data" id="found-cheaper-form">
      <div class="popup-form-box">
        <?php if ($oct_popup_found_cheaper_data['name']) { ?>
          <input class="input-text" name="name" value="<?php echo $name;?>" placeholder="<?php echo $enter_name; ?>" />
        <?php } ?>
        <?php if ($oct_popup_found_cheaper_data['telephone']) { ?>
          <input class="input-text" name="telephone" value="<?php echo $telephone;?>" placeholder="<?php echo $enter_telephone; ?>" />
        <?php } ?>
        <?php if ($oct_popup_found_cheaper_data['link']) { ?>
          <input class="input-text" name="link" value="<?php echo $link;?>" placeholder="<?php echo $enter_link; ?>" class="datetime" />
        <?php } ?>
        <?php if ($oct_popup_found_cheaper_data['comment']) { ?>
          <textarea name="comment" placeholder="<?php echo $enter_comment; ?>"><?php echo $comment;?></textarea>
        <?php } ?>
        <?php if ($text_terms) { ?>
          <div class="oct-terms">
            <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width:auto;height:auto;display:inline-block;margin: 0;" />
          </div>
          <br/>
        <?php } ?>
        <button class="subscr-button" title="<?php echo $button_send; ?>" type="button" id="popup-send-button"><?php echo $button_send; ?></button>
      </div>
      <input type="hidden" name="pid" value="<?php echo $href; ?>">
      <input type="hidden" name="mid" value="<?php echo $model; ?>">
    </form>
  </div>
  <script><!--
  <?php if ($mask) { ?>
    $("#found-cheaper-form input[name=\'telephone\']").mask("<?php echo $mask; ?>", {placeholder: "<?php echo $mask; ?>"});
  <?php } ?>
  function masked(element, status) {
    if (status == true) {
      $('<div/>')
      .attr({ 'class':'masked' })
      .prependTo(element);
      $('<div class="masked_loading" />').insertAfter($('.masked'));
    } else {
      $('.masked').remove();
      $('.masked_loading').remove();
    }
  }
  $('#popup-send-button').on('click', function() {
    masked('#cheaper-popup', true);
    $.ajax({
      type: 'post',
      url:  'index.php?route=extension/module/oct_popup_found_cheaper/send',
      dataType: 'json',
      data: $('#found-cheaper-form').serialize(),
      success: function(json) {
        if (json['error']) {
          if (json['error']['field']) {
            masked('#cheaper-popup', false);
            $('#cheaper-popup .text-danger').remove();
            $.each(json['error']['field'], function(i, val) {
              $('#cheaper-popup [name="' + i + '"]').addClass('error_style').after('<div class="text-danger">' + val + '</div>');
            });
          }
        } else {
          if (json['output']) {
            masked('#cheaper-popup', false);
            $('#popup-send-button').remove();
            $('#cheaper-popup .popup-center').html(json['output']);
          }
        }
      }
    });
  });
  //--></script>
</div>
