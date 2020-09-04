<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModuleOctProductViewed extends Controller {
    public function index($setting) {

        $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
      
        static $module = 0;
        
        $this->load->language('extension/module/oct_product_viewed');
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_tax'] = $this->language->get('text_tax');
        
        $data['button_cart']       = $this->language->get('button_cart');
        $data['button_wishlist']   = $this->language->get('button_wishlist');
        $data['button_compare']    = $this->language->get('button_compare');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
        
        $this->load->model('catalog/product');
        
        $this->load->model('tool/image');
        
        $data['products'] = array();
        
        if (!$setting['limit']) {
            $setting['limit'] = 4;
        }
        
        $data['position'] = isset($setting['position']) ? $setting['position'] : '' ;
        
        if (!empty($this->session->data['oct_product_viewed']) && count($this->session->data['oct_product_viewed']) > 2) {
            
            $products = array_slice(array_unique($this->session->data['oct_product_viewed']), 0, $setting['limit']);
            
            krsort($products);
            
            foreach ($products as $product_id) {
                $product_info = $this->model_catalog_product->getProduct($product_id);
                
                if ($product_info) {
                    if ($product_info['image']) {
                        $image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
                    } else {
                        $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                    }
                    
                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                    } else {
                        $price = false;
                    }
                    
                    if ((float) $product_info['special']) {
                        $special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                    } else {
                        $special = false;
                    }
                    
                    if ($this->config->get('config_tax')) {
                        $tax = $this->currency->format((float) $product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
                    } else {
                        $tax = false;
                    }
                    
                    if ($this->config->get('config_review_status')) {
                        $rating = $product_info['rating'];
                    } else {
                        $rating = false;
                    }
                    
                    $oct_product_stickers_data = $this->config->get('oct_product_stickers_data');
					$oct_product_stickers = array();
					
			        if (isset($oct_product_stickers_data['status']) && $oct_product_stickers_data['status']) {
			          	$this->load->model('catalog/oct_product_stickers');
			
					  	if (isset($result['oct_product_stickers']) && $result['oct_product_stickers']) {
			            	$oct_product_stickers = $this->model_catalog_oct_product_stickers->getProductStickers(unserialize($result['oct_product_stickers']));
						}
			        }
                    
                    $oct_product_preorder_text     = $this->config->get('oct_product_preorder_text');
                    $oct_product_preorder_data     = $this->config->get('oct_product_preorder_data');
                    $oct_product_preorder_language = $this->load->language('extension/module/oct_product_preorder');
                    
                    $stockbutton = '';
                    
                    if (isset($oct_product_preorder_data['status']) && $oct_product_preorder_data['status'] && isset($oct_product_preorder_data['stock_statuses']) && isset($product_info['oct_stock_status_id']) && in_array($product_info['oct_stock_status_id'], $oct_product_preorder_data['stock_statuses'])) {
                        $product_preorder_text   = $oct_product_preorder_text[$this->session->data['language']]['call_button'];
                        $product_preorder_status = 1;
                    } else {
                        $product_preorder_text   = $oct_product_preorder_language['text_out_of_stock'];
                        $product_preorder_status = 2;
                    }
                    
                    $data['products'][] = array(
                        'oct_product_stickers' => $oct_product_stickers,
                        'product_id' => $product_info['product_id'],
                        'thumb' => $image,
                        'name' => $product_info['name'],
                        'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                        'quantity' => $product_info['quantity'],
                        'product_preorder_text' => $product_preorder_text,
                        'product_preorder_status' => $product_preorder_status,
                        'price' => $price,
                        'special' => $special,
                        'tax' => $tax,
                        'rating' => $rating,
                        'href' => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
                    );
                }
            }
        }
        
        $data['module'] = $module++;
        
        if ($data['products']) {
            return $this->load->view('extension/module/oct_product_viewed', $data);
        }
    }
}