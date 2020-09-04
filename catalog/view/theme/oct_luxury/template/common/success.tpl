<?php echo $header; ?><?php echo $content_top; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $count=> $breadcrumb) { ?>
		<?php if($count == 0) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } elseif($count+1<count($breadcrumbs)) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } else { ?>
			<li><span><?php echo $breadcrumb['text']; ?></span></li>
		<?php } ?>
	<?php } ?>
  </ul>
  <div class="content">
	  <article id="content" class="account-content">
      <h2><i class="fa fa-check-square"></i><?php echo $heading_title; ?></h2>
      <?php echo $text_message; ?>
      <div class="buttons">
        <div><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
      </div>
      </article>
      <div class="clearfix"></div>
    </div>
  </div>
      <?php echo $content_bottom; ?>
<?php if((isset($oct_analytics_yandex_ecommerce) && $oct_analytics_yandex_ecommerce) && (isset($oct_analytics_yandex_container) && $oct_analytics_yandex_container) && (isset($oct_analytics_order_id) && $oct_analytics_order_id)) { ?>
  <script>
      window.<?php echo $oct_analytics_yandex_container; ?> = window.<?php echo $oct_analytics_yandex_container; ?> || [];
      if(typeof <?php echo $oct_analytics_yandex_container; ?> != 'undefined') {
          <?php echo $oct_analytics_yandex_container; ?>.push({
              "ecommerce": {
                  "purchase": {
                      "actionField": {
                          "id" : "<?php echo $oct_analytics_order_id; ?>"
                      },
                      "products": [
                          <?php foreach($oct_analytics_order_products as $product) { ?>
                          {
                              "id": "<?php echo $product["id"]; ?>",
                              "name": "<?php echo $product["name"]; ?>",
                              "price": <?php echo $product["price"]; ?>,
                              "quantity": <?php echo $product["quantity"]; ?>,
                              <?php if (isset($product["brand"]) && !empty($product["brand"])) { ?>
                              "brand": "<?php echo $product["brand"]; ?>",
                              <?php } ?>
                              <?php if (isset($product["category"]) && !empty($product["category"])) { ?>
                              "category": "<?php echo $product["category"];?>",
                              <?php } ?>
                              <?php if (isset($product["variant"]) && !empty($product["variant"])) { ?>
                              "variant": "<?php echo $product["variant"];?>"
                              <?php } ?>
                          },
                          <?php } ?>
                      ]
                  }
              }
          });
      }
  </script>
  <?php } ?>
  <?php if((isset($oct_analytics_google_ecommerce) && $oct_analytics_google_ecommerce) && (isset($oct_analytics_order_id) && $oct_analytics_order_id)) {
      $google_data = array(
          'transaction_id' => $oct_analytics_order_id,
          'affiliation' => $affiliation,
          'value' => (float)$total,
          'currency' => $currency_code,
          'shipping' => $shipping,
          'items' => $oct_analytics_order_products
      );

      $toGoogle = json_encode($google_data);
  ?>
  <script>
      window.dataGoogleLayer = window.dataGoogleLayer || [];
      dataGoogleLayer = <?php echo $toGoogle; ?>;
  </script>
  <?php } ?>      
<?php echo $footer; ?>