<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModuleOctProductsFromCategory extends Controller {
    public function index($setting) {
	    if (isset($setting['position']) && ($setting['position'] == 'column_left' || $setting['position'] == 'column_right')) {
		    return false;
	    }
	    
	    static $module = 0;
		
        $this->load->language('octemplates/oct_luxury');
        $this->load->model('catalog/oct_products_from_category');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        
        $data['titlelink']       = $setting['oct_pfc_module'][0]['titlelink'];
        $data['heading_title']   = $this->language->get('heading_title');
        $data['title']           = $setting['oct_pfc_module'][0]['title'][$this->config->get('config_language_id')];
        
        $data['button_cart']     = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare']  = $this->language->get('button_compare');        
        $data['button_popup_view'] = $this->language->get('button_popup_view');
        $data['button_view_more'] = $this->language->get('button_view_more');
            
        $data['position']			 = isset($setting['position']) ? $setting['position'] : '';
        
        $data['products']            = array();
        
        $data['view']                = isset($setting['view']) ? $setting['view'] : 'carousel';    
        
        if ($data['view'] == 'grid') {
	        $this->document->addScript('catalog/view/theme/oct_luxury/js/octShowProducts.js');
	    }
        
        $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
        
        $width = isset($setting['width']) ? $setting['width'] : 200;
        $height = isset($setting['height']) ? $setting['height'] : 200;
        
        if ($setting['autoplay']) {
            $data['play'] = "true";
        } else {
            $data['play'] = "false";
        }
        
        $category = (isset($setting['oct_pfc_module'][0]['category'])) ? $setting['oct_pfc_module'][0]['category'] : array();
        
        if (isset($setting['limit']) && $setting['limit'] != 0) {
            $limit = $setting['limit'];
        } else {
            $limit = 20;
        }
        
        $filter_data = array(
	        'category' => $category,
	        'sub_category' => true,
	        'sort' => (isset($setting['oct_pfc_module'][0]['orderby']) ? $setting['oct_pfc_module'][0]['orderby'] : ''),
	        'order' => (isset($setting['oct_pfc_module'][0]['sortorder']) ? $setting['oct_pfc_module'][0]['sortorder'] : ''),
	        'start' => 0,
	        'limit' => $limit,
	        'show_no_quantity_products' => isset($setting['show_no_quantity_products']) ? $setting['show_no_quantity_products'] : 0,
	        'latest' => isset($setting['oct_pfc_module'][0]['latest']) ? $setting['oct_pfc_module'][0]['latest'] : 0,
			'specials' => isset($setting['oct_pfc_module'][0]['specials']) ? $setting['oct_pfc_module'][0]['specials'] : 0,
        );
        
        $results = $this->model_catalog_oct_products_from_category->getProductsID($filter_data);
        
        if (isset($setting['oct_pfc_module'][0]['products_list']) && !empty($setting['oct_pfc_module'][0]['products_list'])) {
            $results = array_merge($results, $setting['oct_pfc_module'][0]['products_list']);
        }        
        
        foreach ($results as $pid) {
            $result = $this->model_catalog_product->getProduct($pid);
            
            if ($result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $width, $height);
                } else {
                    $image = false;
                }
                
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }
                
                if ((float)$result['special']) {
					$economy = round((($result['price'] - $result['special'])/($result['price'] + 0.01))*100, 0);
		        } else {
		        	$economy = false;
		        }
                
                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = $result['rating'];
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
                
                if (isset($oct_product_preorder_data['status']) && $oct_product_preorder_data['status'] && isset($oct_product_preorder_data['stock_statuses']) && isset($result['oct_stock_status_id']) && in_array($result['oct_stock_status_id'], $oct_product_preorder_data['stock_statuses'])) {
                    $product_preorder_text   = $oct_product_preorder_text[$this->session->data['language']]['call_button'];
                    $product_preorder_status = 1;
                } else {
                    $product_preorder_text   = $oct_product_preorder_language['text_out_of_stock'];
                    $product_preorder_status = 2;
                }
                
                $data['products'][] = array(
                    'oct_product_stickers' => $oct_product_stickers,
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'quantity' => $result['quantity'],
                    'product_preorder_text' => $product_preorder_text,
                    'product_preorder_status' => $product_preorder_status,
                    'economy' => $economy,
                    'price' => $price,
                    'special' => $special,
                    'rating' => $rating,
                    'description' => $result['description'],
                    'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }
        }
        
        $data['module'] = $module++;
        
        return $this->load->view('extension/module/oct_products_from_category', $data);
    }
}