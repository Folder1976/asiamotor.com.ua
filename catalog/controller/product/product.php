<?php
class ControllerProductProduct extends Controller {
	private $error = array();


	        public function update_prices() {
		        $json = array();
		        
				if (isset($this->request->request['product_id']) && isset($this->request->request['quantity'])) {
					$this->load->model('catalog/product');
					
					$json['special'] = 0;
					$json['you_save'] = false;
					
					$option_price = 0;
					$product_id = (int)$this->request->request['product_id'];
					$quantity = (int)$this->request->request['quantity'];
					$product_options = $this->model_catalog_product->getProductOptions($product_id);
					
					$product_info = $this->db->query("SELECT p.price, p.tax_class_id, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity <= '" . (int)$quantity . "' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.quantity DESC, pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");
					
					if (!empty($this->request->request['option'])) {
						$option = $this->request->request['option'];
					} else {
						$option = array();
					}
			
					foreach($product_options as $product_option) {
						if (is_array($product_option['product_option_value'])) {
							foreach($product_option['product_option_value'] as $option_value) {
								if (isset($option[$product_option['product_option_id']])) {
									if (($option[$product_option['product_option_id']] == $option_value['product_option_value_id']) || ((is_array($option[$product_option['product_option_id']])) && (in_array($option_value['product_option_value_id'], $option[$product_option['product_option_id']])))) {
										if ($option_value['price_prefix'] == '+') {
											$option_price+= $option_value['price'];
										} elseif ($option_value['price_prefix'] == '-') {
											$option_price-= $option_value['price'];
										}
									}
								}
							}
						}
					}
					
					$price = $product_info->row['discount'] ? (float)$product_info->row['discount'] * (int)$quantity + (float)$option_price * (int)$quantity : (float)$product_info->row['price'] * (int)$quantity + (float)$option_price * (int)$quantity;
					
					$special = $product_info->row['special'] ? (float)$product_info->row['special'] * (int)$quantity + (float)$option_price * (int)$quantity : 0;
					
					if ($special) {
						$json['special'] = $this->currency->format($this->tax->calculate($special, $product_info->row['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						$json['you_save'] =  '-' . number_format(((float)$price - (float)$special) / (float)$price * 100, 0) . '%';
					}
					
					$json['price'] = $this->currency->format($this->tax->calculate($price, $product_info->row['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					
					$json['tax'] = $this->currency->format((float)$special ? $special : $price, $this->session->data['currency']);
				}
			
				$this->response->addHeader('Content-Type: application/json');
				$this->response->setOutput(json_encode($json));
			}
			
			public function getPImages() {
				if (isset($this->request->get['product_id']) && $this->request->get['product_id']) {
					$json = array();
					$this->load->model('catalog/product');
					$this->load->model('tool/image');
					
					$product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);

        $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
      
					
					if (isset($this->request->get['image_width'])) {
						$popup_width = (int)$this->request->get['image_width'];
					} else {
						$popup_width = $this->config->get($this->config->get('config_theme') . '_image_popup_width');
					}
				
					if (isset($this->request->get['image_height'])) {
						$popup_height = (int)$this->request->get['image_height'];
					} else {
						$popup_height = $this->config->get($this->config->get('config_theme') . '_image_popup_height');
					}
				
					if (isset($this->request->get['image_additional_width'])) {
						$thumb_width = (int)$this->request->get['image_additional_width'];
					} else {
						$thumb_width = $this->config->get($this->config->get('config_theme') . '_image_additional_width');
					}
				
					if (isset($this->request->get['image_additional_height'])) {
						$thumb_height = (int)$this->request->get['image_additional_height'];
					} else {
						$thumb_height = $this->config->get($this->config->get('config_theme') . '_image_additional_height');
					}
					
					$main_img_width = $this->config->get($this->config->get('config_theme') . '_image_thumb_width');
			  		$main_img_height = $this->config->get($this->config->get('config_theme') . '_image_thumb_height');
					
					if (isset($this->request->post['option'])) {
						$opt_array = array();
						foreach($this->request->post['option'] as $value) {
							if (is_array($value)) {
								foreach($value as $val) {
									if ($val) {
										$opt_array[] = $this->model_catalog_product->getProductOptionValueId($this->request->get['product_id'], $val);
									}
								}
							} else {
								if ($value) {
									$opt_array[] = $this->model_catalog_product->getProductOptionValueId($this->request->get['product_id'], $value);
								}
							}
						}
				
						$results = $this->model_catalog_product->getProductImagesByOptionValueId($this->request->get['product_id'], $opt_array);
						
						foreach($results as $result) {
							$json['images'][] = array(
								'popup' => $this->model_tool_image->resize($result['image'], $popup_width, $popup_height),
								'thumb' => $this->model_tool_image->resize($result['image'], $thumb_width, $thumb_height),
								'main_img'   => $this->model_tool_image->resize($result['image'], $main_img_width, $main_img_height),
								'main_popup' => $this->model_tool_image->resize($result['image'], $popup_width, $popup_height)
							);
						}
					} else {
						$results = false;
					}
				
					if (!$results) {
						$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);
						
						$json['images'][] = array(
							'popup' => $this->model_tool_image->resize($product_info['image'], $popup_width, $popup_height),
							'thumb' => $this->model_tool_image->resize($product_info['image'], $thumb_width, $thumb_height),
							'main_img'   => $this->model_tool_image->resize($product_info['image'], $main_img_width, $main_img_height),
							'main_popup' => $this->model_tool_image->resize($product_info['image'], $popup_width, $popup_height)
						);
						
						foreach($results as $result) {
							$json['images'][] = array(
								'popup' => $this->model_tool_image->resize($result['image'], $popup_width, $popup_height),
								'thumb' => $this->model_tool_image->resize($result['image'], $thumb_width, $thumb_height),
								'main_img'   => $this->model_tool_image->resize($result['image'], $main_img_width, $main_img_height),
								'main_popup' => $this->model_tool_image->resize($result['image'], $popup_width, $popup_height)
							);
						}
					}
					
					if (isset($this->request->get['pr_gallery']) && $this->request->get['pr_gallery']) {
						$json['slick_index'] = 0;
						
						if ($product_info['meta_h1']) {
							$json['heading_title'] = $product_info['meta_h1'];
						} else {
							$json['heading_title'] = $product_info['name'];
						}
						
						if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
							$json['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						} else {
							$json['price'] = false;
						}
			
						if ((float)$product_info['special']) {
							$json['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						} else {
							$json['special'] = false;
						}
						
						if (isset($this->request->get['slick_index']) && $this->request->get['slick_index']) {
							$json['slick_index'] = $this->request->get['slick_index'];
						}
						
						$this->response->setOutput($this->load->view('product/product_gallery', $json));	
					} else {
						$this->response->addHeader('Content-Type: application/json');
						$this->response->setOutput(json_encode($json));
					}
				} else {
					$this->response->redirect($this->url->link('common/home', '', true));
				}
			}
			
	public function index() {

        // oct_product_reviews start
        $this->load->language('extension/module/oct_product_reviews');

        $data['oct_product_reviews_data'] = $this->config->get('oct_product_reviews_data');

        $data['entry_positive_text'] = $this->language->get('entry_positive_text');
        $data['entry_negative_text'] = $this->language->get('entry_negative_text');
        $data['text_where_bought'] = $this->language->get('text_where_bought');
        $data['text_where_bought_yes'] = $this->language->get('text_where_bought_yes');
        $data['text_where_bought_no'] = $this->language->get('text_where_bought_no');
        // oct_product_reviews end
      

        // oct_popup_purchase start
        $data['oct_popup_purchase_data'] = $this->config->get('oct_popup_purchase_data');
        // oct_popup_purchase end
      

        // oct_popup_found_cheaper start
        $data['oct_popup_found_cheaper_data'] = $this->config->get('oct_popup_found_cheaper_data');
        // oct_popup_found_cheaper end
      
		$this->load->language('product/product');

		$data['hide_trade_price'] = true;
		if ($this->customer->isLogged()) {	
			$data['hide_trade_price'] = false;
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('catalog/category');

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$url = '';

				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}

				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$data['breadcrumbs'][] = array(
					'text' => $category_info['name'],
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
			}
		}

		$this->load->model('catalog/manufacturer');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_brand'),
				'href' => $this->url->link('product/manufacturer')
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => $manufacturer_info['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('product/search', $url)
			);
		}

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}
		
		$data['text_primenimosti'] = $this->language->get('text_primenimosti');
		$data['text_primenimosti_header'] = $this->language->get('text_primenimosti_header');
		$data['primenimosti'] = array();
		
		$this->load->model('catalog/product');
		
		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			
			
			$data['primenimosti'] = $this->model_catalog_product->getProductPrimenimosti($product_info['tovarkey']);
			
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $product_info['name'],
				'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
			);

			if ($product_info['meta_title']) {
				$this->document->setTitle($product_info['meta_title']);
			} else {
				$this->document->setTitle($product_info['name']);
			}

			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			
			//$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
	        
			
	        //$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
	        
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->session->data['language'].'.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			if ($product_info['meta_h1']) {
				$data['heading_title'] = $product_info['meta_h1'];
			} else {
				$data['heading_title'] = $product_info['name'];
			}

			
			
			
			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);

			$oct_product_stickers_data = $this->config->get('oct_product_stickers_data');
			$data['oct_product_stickers'] = array();
			
			if (isset($oct_product_stickers_data['status']) && $oct_product_stickers_data['status']) {
				$this->load->model('catalog/oct_product_stickers');
				
				if (isset($product_info['oct_product_stickers']) && $product_info['oct_product_stickers']) {
					$data['oct_product_stickers'] = $this->model_catalog_oct_product_stickers->getProductStickers(unserialize($product_info['oct_product_stickers']));
				}
			}
			
			$data['model'] = $product_info['model'];
			$data['reward'] = $product_info['reward'];
			$data['points'] = $product_info['points'];
			
			$data['description'] = str_replace("<img", "<img class=\"img-responsive\"",  html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8'));
			

			$data['quantity'] = $product_info['quantity'];
			
			
        $data['disable_buy'] = 0;

        $oct_product_preorder_text = $this->config->get('oct_product_preorder_text');
        $oct_product_preorder_data = $this->config->get('oct_product_preorder_data');
        $oct_product_stock_checkout = $this->config->get('config_stock_checkout');

        if (isset($oct_product_preorder_data['status']) && $oct_product_preorder_data['status'] && isset($oct_product_preorder_data['stock_statuses']) && isset($product_info['oct_stock_status_id']) && in_array($product_info['oct_stock_status_id'], $oct_product_preorder_data['stock_statuses'])) {

        // oct_popup_found_cheaper start
        $data['text_oct_popup_found_cheaper'] = $this->language->get('text_oct_popup_found_cheaper');
        // oct_popup_found_cheaper end
      

        // oct_popup_purchase start
        $data['text_oct_popup_purchase'] = $this->language->get('text_oct_popup_purchase');
        // oct_popup_purchase end
      

        $oct_product_sizes_table_data = $this->config->get('oct_product_sizes_table_data');
        $data['text_show_product_sizes_table'] = $this->language->get('text_show_product_sizes_table');
        $data['lang_code'] = $this->session->data['language'];

        if (isset($oct_product_sizes_table_data['status']) && $oct_product_sizes_table_data['status'] && isset($this->request->get['route']) && isset($this->request->get['path']) && $this->request->get['route'] == 'product/product') {
          
          if (isset($oct_product_sizes_table_data['sections']) && !empty($oct_product_sizes_table_data['sections'])) {
            $data['product_sizes_table'] = $oct_product_sizes_table_data['sections'];  
          } else {
            $data['product_sizes_table'] = array();
          }

          $parts = explode('_', (string)$this->request->get['path']);
          $data['section_category_id'] = (int)array_pop($parts);

          if ($data['product_sizes_table']) {
            foreach($data['product_sizes_table'] as $block_section) {
              if (isset($block_section['categories']) && in_array($data['section_category_id'], $block_section['categories'])) {
                $data['show_product_sizes_table_status'] = true;
                break;
              } else {
                $data['show_product_sizes_table_status'] = false;
              }
            }
          } else {
            $data['show_product_sizes_table_status'] = false;
          }
        } else {
          $data['section_category_id'] = 0;
          $data['show_product_sizes_table_status'] = false;
          $data['product_sizes_table'] = array();
        }
      

        $oct_product_tabs_data = $this->config->get('oct_product_tabs_data');
        $data['oct_product_extra_tabs'] = array();

        if (isset($oct_product_tabs_data['status']) && $oct_product_tabs_data['status']) {
          $this->load->model('catalog/oct_product_tabs');

          $oct_product_extra_tabs = $this->model_catalog_oct_product_tabs->getProductTabs($product_id);

          if ($oct_product_extra_tabs) {            
            foreach ($oct_product_extra_tabs as $extra_tab) {
              $data['oct_product_extra_tabs'][] = array(
                'title' => $extra_tab['title'],
                'text'  => html_entity_decode($extra_tab['text'], ENT_QUOTES, 'UTF-8')
              );
            }
          }
        }
      
          if ($product_info['quantity'] <= 0) {
            $data['stock'] = $product_info['stock_status'];
            if ($oct_product_stock_checkout == 0) {
              $data['disable_buy'] = 1;
            }
            $data['stockbutton'] = $oct_product_preorder_text[$this->session->data['language']]['call_button'];
          } elseif ($this->config->get('config_stock_display')) {
            $data['stock'] = $product_info['quantity'];
          } elseif ($product_info['quantity'] >= 1 && $product_info['quantity'] <= 3) {
            $data['stock'] = $this->language->get('text_minstock');
          } else {
            $data['stock'] = $this->language->get('text_instock');
          }
        } else {

        // oct_popup_found_cheaper start
        $data['text_oct_popup_found_cheaper'] = $this->language->get('text_oct_popup_found_cheaper');
        // oct_popup_found_cheaper end
      

        // oct_popup_purchase start
        $data['text_oct_popup_purchase'] = $this->language->get('text_oct_popup_purchase');
        // oct_popup_purchase end
      

        $oct_product_sizes_table_data = $this->config->get('oct_product_sizes_table_data');
        $data['text_show_product_sizes_table'] = $this->language->get('text_show_product_sizes_table');
        $data['lang_code'] = $this->session->data['language'];

        if (isset($oct_product_sizes_table_data['status']) && $oct_product_sizes_table_data['status'] && isset($this->request->get['route']) && isset($this->request->get['path']) && $this->request->get['route'] == 'product/product') {
          
          if (isset($oct_product_sizes_table_data['sections']) && !empty($oct_product_sizes_table_data['sections'])) {
            $data['product_sizes_table'] = $oct_product_sizes_table_data['sections'];  
          } else {
            $data['product_sizes_table'] = array();
          }

          $parts = explode('_', (string)$this->request->get['path']);
          $data['section_category_id'] = (int)array_pop($parts);

          if ($data['product_sizes_table']) {
            foreach($data['product_sizes_table'] as $block_section) {
              if (isset($block_section['categories']) && in_array($data['section_category_id'], $block_section['categories'])) {
                $data['show_product_sizes_table_status'] = true;
                break;
              } else {
                $data['show_product_sizes_table_status'] = false;
              }
            }
          } else {
            $data['show_product_sizes_table_status'] = false;
          }
        } else {
          $data['section_category_id'] = 0;
          $data['show_product_sizes_table_status'] = false;
          $data['product_sizes_table'] = array();
        }
      

        $oct_product_tabs_data = $this->config->get('oct_product_tabs_data');
        $data['oct_product_extra_tabs'] = array();

        if (isset($oct_product_tabs_data['status']) && $oct_product_tabs_data['status']) {
          $this->load->model('catalog/oct_product_tabs');

          $oct_product_extra_tabs = $this->model_catalog_oct_product_tabs->getProductTabs($product_id);

          if ($oct_product_extra_tabs) {            
            foreach ($oct_product_extra_tabs as $extra_tab) {
              $data['oct_product_extra_tabs'][] = array(
                'title' => $extra_tab['title'],
                'text'  => html_entity_decode($extra_tab['text'], ENT_QUOTES, 'UTF-8')
              );
            }
          }
        }
      
          if ($product_info['quantity'] <= 0) {
            $data['stock'] = $product_info['stock_status'];
            $data['stockbutton'] = $product_info['stock_status'];
            if ($oct_product_stock_checkout == 0) {
              $data['disable_buy'] = 2;
            }
          } elseif ($this->config->get('config_stock_display')) {
            $data['stock'] = $product_info['quantity'];
            $data['stockbutton'] = $product_info['quantity'];
          } else {
            $data['stock'] = $this->language->get('text_instock');
            $data['stockbutton'] = $this->language->get('text_instock');
          }
        }
      

			$this->load->model('tool/image');

			if ($product_info['image']) {

        $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
      
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

		/* NeoSeo Exchange 1c - begin */
		$this->load->model("catalog/neoseo_warehouse");
        $data['warehouses'] = $this->model_catalog_neoseo_warehouse->getProductQuantity($this->request->get['product_id']);
		/* NeoSeo Exchange 1c - end */
			$data['images'] = array();

			
			$data['oct_images_by_options_data']= $oct_images_by_options_data = $this->config->get('oct_images_by_options_data');
			$oct_luxury_data = $this->config->get('oct_luxury_data');
			
	        $data['check_zoom'] = $check_zoom = (isset($oct_luxury_data['pr_zoom']) && $oct_luxury_data['pr_zoom'] == 'on') ? true : false;
	        $data['pr_gallery'] = $pr_gallery = isset($oct_luxury_data['pr_gallery']) ? $oct_luxury_data['pr_gallery'] : '0';
			
			$this->document->addScript('catalog/view/theme/oct_luxury/js/fancy-box/jquery.fancybox.min.js');
			$this->document->addStyle('catalog/view/theme/oct_luxury/js/fancy-box/jquery.fancybox.min.css');
			
			if ($check_zoom) {
		        $this->document->addScript('catalog/view/theme/oct_luxury/js/cloud-zoom/cloud-zoom.1.0.3.min.js');
		        $this->document->addStyle('catalog/view/theme/oct_luxury/js/cloud-zoom/cloud-zoom.css');
	        }
	
	        $results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);
	
			$data['images'][] = array(
	        	'popup' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
				'thumb' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height')),
				'main_img'   => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')),
	            'main_popup' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'))
			);
	
			foreach ($results as $result) {
	        	$data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height')),
					'main_img'   => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')),
					'main_popup' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'))
				);
			}
			
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				$data['discount_currency'] = $this->currency->format($this->tax->calculate($product_info['price']* 0.869565217391304, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				// $data['discount_price'] = $this->currency->format(round((round($product_info['price'], 2) * 0.86‬ ), 2), $this->session->data['currency']);

				

			} else {
				$data['price'] = false;
			}

			if ((float)$product_info['special']) {
				$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$data['special'] = false;
			}

			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
			} else {
				$data['tax'] = false;
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			$data['discounts'] = array();

			foreach ($discounts as $discount) {
				$data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
				);
			}


			$data['quantity'] = $product_info['quantity'];
			
			$data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					
			// oct_images_by_options start
			if (!$option_value['subtract'] || ($option_value['quantity'] >= 0)) {
			// if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
			// oct_images_by_options end
			
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],

			// oct_images_by_options start
			'quantity_status'         => ($option_value['quantity'] <= 0) ? false : true, //add
			// oct_images_by_options end
			
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							
			'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 100, 100) : '',
			
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}

				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}

			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$data['rating'] = (int)$product_info['rating'];

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}

			$data['share'] = $this->url->link('product/product', 'product_id=' . (int)$this->request->get['product_id']);

			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

			$data['products'] = array();

			
			$product_data_related = $this->cache->get('octemplates.oct_product_auto_related.product.' . (int) $this->config->get('config_store_id') . '.' . (int) $this->config->get('config_customer_group_id') . '.' . (int) $this->request->get['product_id'] . '.' . (int)$this->config->get('config_language_id'));

			$data['oct_rel_view'] = false;

			
		
			if (!$product_data_related) {
				$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

				$oct_product_auto_related_data = $this->config->get('oct_product_auto_related_data');

				if (isset($oct_product_auto_related_data) && $oct_product_auto_related_data['status'] != 0) {
					// $results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
					// oct_product_auto_related start

					$this->load->model('extension/module/oct_product_auto_related');

					$data_info = array(
						'product_id'          => $this->request->get['product_id'],
						'sort'                => 'p.product_id',
						'filter_category_id'  => (isset($category_id)) ? $category_id : 0,
						'filter_sub_category' => 1,
						'order'               => 'DESC',
						'start'               => 0,
						'limit'               => $oct_product_auto_related_data['limit']
					);

					$results += $this->model_extension_module_oct_product_auto_related->getProductAutoRelated($data_info);

					$data['oct_rel_view'] = true;
				}
				// oct_product_auto_related end
			

			foreach ($results as $result) {

			if (isset($oct_product_auto_related_data['status']) && $oct_product_auto_related_data['status']) {
				if ($result['image']) {
					$image_auto_related = $this->model_tool_image->resize($result['image'], $oct_product_auto_related_data['width'], $oct_product_auto_related_data['height']);
				} else {
					$image_auto_related = $this->model_tool_image->resize('placeholder.png', $oct_product_auto_related_data['width'], $oct_product_auto_related_data['height']);
				}
			} else {
				if ($result['image']) {
					$image_auto_related = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image_auto_related = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}
			}
			
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}


			if ((float)$result['special']) {
				$economy = round((($result['price'] - $result['special'])/($result['price'] + 0.01))*100, 0);
			} else {
				$economy = false;
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
					$rating = (int)$result['rating'];
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
					
			'thumb'  => $image_auto_related,
			
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
'economy'       => $economy,

        'quantity'       => $result['quantity'],
        'product_preorder_text' => $product_preorder_text,
        'product_preorder_status' => $product_preorder_status,
      
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}


			}
			
			$data['tags'] = array();

			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}

			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

        // oct_product_viewed start
        if (!isset($this->session->data['oct_product_viewed'])) {
          $this->session->data['oct_product_viewed'] = array();
        } else {
          $this->session->data['oct_product_viewed'][] = $this->request->get['product_id'];
        }
        // oct_product_viewed end
      

			$oct_data = $this->config->get('oct_luxury_data');
			$this->load->language('octemplates/oct_luxury');
			$data['you_save_text'] = $this->language->get('you_save');
			$data['text_gallery'] = $this->language->get('text_gallery');
			$data['oct_luxury_pr_micro'] = $oct_data['pr_micro'];
			$data['oct_luxury_currency_code_data'] = $this->session->data['currency'];
			$data['oct_luxury_pr_shortdesc'] = $oct_data['pr_shortdesc'];
			$data['oct_luxury_pr_logoman'] = $oct_data['pr_logoman'];
			$data['oct_home_text'] = $this->language->get('oct_home_text');
			$data['text_oct_option_disable'] = $this->language->get('oct_option_disable');

			$oct_luxury_pr_garantedtext = $oct_data['pr_garantedtext'];

			if(empty($oct_luxury_pr_garantedtext[$this->session->data['language']])) {
				$data['oct_luxury_pr_garantedtext'] = false;
			} else if (isset($oct_luxury_pr_garantedtext[$this->session->data['language']])) {
				$data['oct_luxury_pr_garantedtext'] = html_entity_decode($oct_luxury_pr_garantedtext[$this->session->data['language']], ENT_QUOTES, 'UTF-8');
			}

			if ((float)$product_info['special']) {
		        $data['economy'] = round((($product_info['price'] - $product_info['special'])/($product_info['price'] + 0.01))*100, 0);
		        $data['saver'] = round($product_info['price'] - $product_info['special']);
		        $data['you_save'] = $this->currency->format($this->tax->calculate($data['saver'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
		        $data['economy'] = false;
		        $data['you_save'] = false;
			}

			$oct_luxury_data = $this->config->get('oct_luxury_data');

			if (isset($oct_luxury_data['terms']) && $oct_luxury_data['terms']) {
				$this->load->model('catalog/information');

				$information_info = $this->model_catalog_information->getInformation($oct_luxury_data['terms']);

				if ($information_info) {
					$data['text_terms'] = sprintf($this->language->get('text_oct_terms'), $this->url->link('information/information', 'information_id=' . $oct_luxury_data['terms'], 'SSL'), $information_info['title'], $information_info['title']);
				} else {
					$data['text_terms'] = '';
				}
			} else {
				$data['text_terms'] = '';
			}
			

            if(isset($this->request->get['product_id']) && $this->config->get('oct_analytics_yandex_ecommerce')) {
                $data['oct_analytics_yandex_ecommerce'] = $this->config->get('oct_analytics_yandex_ecommerce');
                $data['oct_analytics_yandex_container'] = $this->config->get('oct_analytics_yandex_container');

                $data['oct_analytics_yandex_product_name'] = $product_info['name'];
                $data['oct_analytics_yandex_product_category'] = (isset($category_info) && $category_info) ? $category_info['name'] : "";
            }
            


        // oct_product_manufacturer_logo start
        $data['manufacturer_info'] = array();

        if ($product_info['manufacturer_id'] && $oct_data['pr_logoman'] == 'on') {
          $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product_info['manufacturer_id']);
          if ($manufacturer_info) {
              if ($manufacturer_info['image']) {
                $man_img = $this->model_tool_image->resize($manufacturer_info['image'], 150, 70);
              } else {
                $man_img = $this->model_tool_image->resize('placeholder.png', 150, 70);
              }

              $data['manufacturer_info'] = array(
                'name' => $manufacturer_info['name'],
                'image'=> $man_img,
                'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id'])
              );
          }
        }
		
		
			if($this->config->get('config_ceo_product_title') != ''){
				$this->document->setTitle(str_replace(array('@name@', '@price@'),array($product_info['name'], $data['price']), $this->config->get('config_ceo_product_title')));
			}
			if($this->config->get('config_ceo_product_description') != ''){
				$this->document->setDescription(str_replace(array('@name@', '@price@'),array($product_info['name'], $data['price']), $this->config->get('config_ceo_product_description')));
			}
			if($this->config->get('config_ceo_product_keywords') != ''){
				$this->document->setKeywords(str_replace(array('@name@', '@price@'),array($product_info['name'], $data['price']), $this->config->get('config_ceo_product_keywords')));
			}
			
			if($this->config->get('config_ceo_product_h1') != ''){
				$data['heading_title'] = str_replace(array('@name@', '@price@'),array($product_info['name'], $data['price']), $this->config->get('config_ceo_product_h1'));
			}
		
        // oct_product_manufacturer_logo end
      
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('product/product', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			
        // start: oct_404_page
        $oct_404_page_data = $this->config->get('oct_404_page_data');

        if (isset($oct_404_page_data) && $oct_404_page_data['status']) {
            if (!empty($oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['title'])) {
                $data['heading_title'] = $oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['title'];
            } else {
                $data['heading_title'] = $this->language->get('text_error');
            }

            if (isset($oct_404_page_data['image']) && !empty($oct_404_page_data['image'])) {
                if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
        			$data['oct_404_image'] = $this->config->get('config_ssl') . 'image/' . $oct_404_page_data['image'];
        		} else {
        			$data['oct_404_image'] = $this->config->get('config_url') . 'image/' . $oct_404_page_data['image'];
        		}
            } else {
                $data['oct_404_image'] = '';
            }
      

			
          if (!empty($oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['text'])) {
              $data['text_error'] = html_entity_decode($oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['text'], ENT_QUOTES, 'UTF-8');
          } else {
              $data['text_error'] = $this->language->get('text_error');
          }
        } else {
            $data['heading_title'] = $this->language->get('heading_title');
            $data['text_error'] = $this->language->get('text_error');
        }
      

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');


        // oct_product_manufacturer_logo start
        $data['manufacturer_info'] = array();

        if ($product_info['manufacturer_id'] && $oct_data['pr_logoman'] == 'on') {
          $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product_info['manufacturer_id']);
          if ($manufacturer_info) {
              if ($manufacturer_info['image']) {
                $man_img = $this->model_tool_image->resize($manufacturer_info['image'], 150, 70);
              } else {
                $man_img = $this->model_tool_image->resize('placeholder.png', 150, 70);
              }

              $data['manufacturer_info'] = array(
                'name' => $manufacturer_info['name'],
                'image'=> $man_img,
                'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id'])
              );
          }
        }
        // oct_product_manufacturer_logo end
     
	 
	 

	
	  
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}


	        public function getAutoRels() {
	    		$this->load->model('catalog/product');
	    		$this->load->model('tool/image');
	
	    		$data = array();
	            $data = array_merge($data, $this->load->language('product/product'));
	
	            $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
	            $data['button_popup_view'] = $this->language->get('button_popup_view');
	
	    		$resultss = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
	
	            $oct_product_auto_related_data = $this->config->get('oct_product_auto_related_data');
	
	            if (isset($oct_product_auto_related_data) && $oct_product_auto_related_data['status'] != 0) {
					$this->load->model('extension/module/oct_product_auto_related');
	
					$data_info = array(
	                	'product_id'          => $this->request->get['product_id'],
						'sort'                => 'p.product_id',
						'filter_category_id'  => (isset($category_id)) ? $category_id : 0,
						'filter_sub_category' => 1,
						'order'               => 'DESC',
						'start'               => 0,
						'limit'               => $oct_product_auto_related_data['limit']
					);
	
					$resultss += $this->model_extension_module_oct_product_auto_related->getProductAutoRelated($data_info);
	            }
	
	            $data['products'] = array();
	
	    		foreach ($resultss as $result) {

			if (isset($oct_product_auto_related_data['status']) && $oct_product_auto_related_data['status']) {
				if ($result['image']) {
					$image_auto_related = $this->model_tool_image->resize($result['image'], $oct_product_auto_related_data['width'], $oct_product_auto_related_data['height']);
				} else {
					$image_auto_related = $this->model_tool_image->resize('placeholder.png', $oct_product_auto_related_data['width'], $oct_product_auto_related_data['height']);
				}
			} else {
				if ($result['image']) {
					$image_auto_related = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image_auto_related = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}
			}
			
	    			if ($result['image']) {
	    				$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
	    			} else {
	    				$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
	    			}
	
	    			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
	    				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
	    			} else {
	    				$price = false;
	    			}
					
					if ((float)$result['special']) {
						$economy = round((($result['price'] - $result['special'])/($result['price'] + 0.01))*100, 0);
			        } else {
			        	$economy = false;
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
	    				$rating = (int)$result['rating'];
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
	    				
			'thumb'  => $image_auto_related,
			
	    				'name'        => $result['name'],
	    				'economy'     => $economy,
						'quantity'    => $result['quantity'],
						'product_preorder_text' => $product_preorder_text,
						'product_preorder_status' => $product_preorder_status,
	    				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
	    				'price'       => $price,
	    				'special'     => $special,
	    				'tax'         => $tax,
	    				'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
	    				'rating'      => $rating,
	    				'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
	    			);
	    		}
	
	    		$this->response->setOutput($this->load->view('product/product_related', $data));
	    	}
	        

        // oct_product_reviews start
        public function oct_review_reputation() {
          $json = array();

          $this->load->language('extension/module/oct_product_reviews');

          if (isset($this->request->get['review_id']) && isset($this->request->get['reputation_type'])) {

            $this->load->model('catalog/review');

            $check_ip = $this->model_catalog_review->checkOctUserIp($this->request->server['REMOTE_ADDR'], $this->request->get['review_id']);

            if ($check_ip) {
              $json['error'] = $this->language->get('error_ip_exist');
            }
            
            if (!isset($json['error'])) {

              $filter_data = array(
                'review_id' => (int)$this->request->get['review_id'],
                'ip' => $this->request->server['REMOTE_ADDR'],
                'reputation_type' => (int)$this->request->get['reputation_type']
              );

              $this->model_catalog_review->addOctProductReputation($filter_data);

              $json['success'] = $this->language->get('text_success');
            }
          }

          $this->response->addHeader('Content-Type: application/json');
          $this->response->setOutput(json_encode($json));
        }
        // oct_product_reviews end
      
	public function review() {

        // oct_product_reviews start
        $data['oct_product_reviews_data'] = $this->config->get('oct_product_reviews_data');
        // oct_product_reviews end
      
		$this->load->language('product/product');

		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

        // oct_product_reviews start
        $this->load->language('extension/module/oct_product_reviews');

        $oct_product_reviews_data = $this->config->get('oct_product_reviews_data');

        $data['entry_positive_text'] = $this->language->get('entry_positive_text');
        $data['entry_negative_text'] = $this->language->get('entry_negative_text');
        $data['text_where_bought'] = $this->language->get('text_where_bought');
        $data['text_where_bought_yes'] = $this->language->get('text_where_bought_yes');
        $data['text_where_bought_no'] = $this->language->get('text_where_bought_no');
        $data['text_admin_answer'] = $this->language->get('text_admin_answer');
        $data['text_my_assessment'] = $this->language->get('text_my_assessment');
        // oct_product_reviews end
      

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {

        // oct_product_reviews start
        if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) {
          $positive_text = html_entity_decode($result['positive_text'], ENT_QUOTES, 'UTF-8');
          $negative_text = html_entity_decode($result['negative_text'], ENT_QUOTES, 'UTF-8');
          $admin_answer = html_entity_decode($result['admin_answer'], ENT_QUOTES, 'UTF-8');
          $plus_reputation = (int)$result['plus_reputation'];
          $minus_reputation = (int)$result['minus_reputation'];
          $where_bought = ($result['where_bought']) ? $this->language->get('text_where_bought_yes') : $this->language->get('text_where_bought_no');
        } else {
          $positive_text = '';
          $negative_text = '';
          $admin_answer = '';
          $plus_reputation = FALSE;
          $minus_reputation = FALSE;
          $where_bought = FALSE;
        }
        // oct_product_reviews end
      
			$data['reviews'][] = array(

        // oct_product_reviews start
        'review_id'        => $result['review_id'],
        'positive_text'    => $positive_text,
        'negative_text'    => $negative_text,
        'admin_answer'     => $admin_answer,
        'plus_reputation'  => $plus_reputation,
        'minus_reputation' => $minus_reputation,
        'where_bought'     => $where_bought,
        // oct_product_reviews end
      
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

		$this->response->setOutput($this->load->view('product/review', $data));
	}

	public function write() {
		$this->load->language('product/product');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}


			$oct_luxury_data = $this->config->get('oct_luxury_data');

			if (isset($oct_luxury_data['terms']) && $oct_luxury_data['terms']) {
				if (!isset($this->request->post['terms'])) {
					$this->load->model('catalog/information');

					$information_info = $this->model_catalog_information->getInformation($oct_luxury_data['terms']);

					$json['error'] = sprintf($this->language->get('error_oct_terms'), $information_info['title']);
				}
			}
			
			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getRecurringDescription() {
		$this->load->language('product/product');
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
