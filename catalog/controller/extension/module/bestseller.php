<?php
class ControllerExtensionModuleBestSeller extends Controller {
	public function index($setting) {

        $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
      
		$this->load->language('extension/module/bestseller');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		// ===================================================

		$data['heading_title'] = $setting['name'];



		$this->load->model('catalog/category');
		$addons_title = '';
		if(isset($this->session->data['mark_id']) AND (int)$this->session->data['mark_id'] > 0){
			$mark = $this->model_catalog_category->getMark((int)$this->session->data['mark_id']);
			$addons_title .= ' для '.$mark['mark_name'];
		}
		if(isset($this->session->data['model_id']) AND (int)$this->session->data['model_id'] > 0){
			$model = $this->model_catalog_category->getModel((int)$this->session->data['mark_id'], (int)$this->session->data['model_id']);
			$addons_title .= ' '.$model['model_name'];
		}

		if(isset($this->session->data['year_id'])){
			$addons_title .= ' '.$this->session->data['year_id'];
		}

		if(isset($this->session->data['dvigun_id']) AND $this->session->data['dvigun_id'] != ''){
			$dvigun = $this->model_catalog_category->getDvigun($this->session->data['dvigun_id']);
			$addons_title .= ', '.$dvigun['dvigun'];
		}
		$data['heading_title'] .= $addons_title;
		// ===================================================
		
		$this->load->model('catalog/product');

			$data['position'] = isset($setting['position']) ? $setting['position'] : '';
			

		$this->load->model('tool/image');

		$data['products'] = array();

		if($setting['name'] == 'Популярные'){
			$results = $this->model_catalog_product->getPopularProducts($setting['limit']);
		}else{
			$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);
		}

		if ($results) {
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}


        $oct_product_preorder_text = $this->config->get('oct_product_preorder_text');
        $oct_product_preorder_data = $this->config->get('oct_product_preorder_data');
        $oct_product_preorder_language = $this->load->language('extension/module/oct_product_preorder');

        if (isset($oct_product_preorder_data['status']) && $oct_product_preorder_data['status'] && isset($oct_product_preorder_data['stock_statuses']) && isset($result['oct_stock_status_id']) && in_array($result['oct_stock_status_id'], $oct_product_preorder_data['stock_statuses'])) {
          $product_preorder_text = $oct_product_preorder_text[$this->session->data['language']]['call_button'];
          $product_preorder_status = 1;
        } else {
          $product_preorder_text = $oct_product_preorder_language['text_out_of_stock'];
          $product_preorder_status = 2;
        }
      

			$oct_product_stickers_data = $this->config->get('oct_product_stickers_data');
			$oct_product_stickers = array();
			
			if (isset($oct_product_stickers_data['status']) && $oct_product_stickers_data['status']) {
				$this->load->model('catalog/oct_product_stickers');
				
				if (isset($result['oct_product_stickers']) && $result['oct_product_stickers']) {
					$oct_product_stickers = $this->model_catalog_oct_product_stickers->getProductStickers(unserialize($result['oct_product_stickers']));
				}
			}
			
				$data['products'][] = array(

			'oct_product_stickers' => $oct_product_stickers,
			
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',

        'quantity'       => $result['quantity'],
        'product_preorder_text' => $product_preorder_text,
        'product_preorder_status' => $product_preorder_status,
      
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			return $this->load->view('extension/module/bestseller', $data);
		}
	}
}
