<?php
class ControllerCheckoutSuccess extends Controller {
	public function index() {

        if (isset($this->session->data['order_id']) && (!empty($this->session->data['order_id']))) {
          $this->session->data['recent_order_id'] = $this->session->data['order_id'];
        }

        if (isset($this->session->data['guest']['firstname']) && (!empty($this->session->data['guest']['firstname']))) {
          $this->session->data['recent_firstname'] = $this->session->data['guest']['firstname'];
        } elseif ($this->customer->isLogged()) {
          $this->session->data['recent_firstname'] = $this->customer->getFirstName();
        } else {
          $this->session->data['recent_firstname'] = false;
        }
      
		$this->load->language('checkout/success');

		if (isset($this->session->data['order_id'])) {

            //https://yandex.ru/support/metrika/data/e-commerce.html
            //https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-ecommerce?hl=ru
            if($this->config->get('oct_analytics_yandex_ecommerce') || $this->config->get('oct_analytics_google_ecommerce')) {
                $data['oct_analytics_yandex_ecommerce'] = $this->config->get('oct_analytics_yandex_ecommerce');
                $data['oct_analytics_yandex_container'] = $this->config->get('oct_analytics_yandex_container');

                $data['oct_analytics_google_ecommerce'] = $this->config->get('oct_analytics_google_ecommerce');

                $this->load->model('account/order');
                $this->load->model('catalog/category');
                $this->load->model('catalog/product');

                $data['oct_analytics_order_id'] = $this->session->data['order_id'];

                $order_products = $this->model_account_order->getOrderProducts($this->session->data['order_id']);

                $data['oct_analytics_yandex_order_products'] = array();

                $data['currency_id'] = $currency_id = $this->currency->getId($this->session->data['currency']);
    			$data['currency_code'] = $currency_code = $this->session->data['currency'];
    			$data['currency_value'] = $currency_value = $this->currency->getValue($this->session->data['currency']);

                $shipping = 0;
                $totals = 0;

                $query_total = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$this->session->data['order_id'] . "' ORDER BY sort_order ASC");

                foreach ($query_total->rows as $total) {
                    if ($total['value'] > 0) {
                        if ($total['code'] == "shipping") {
                            $shipping += $total['value'];
                        }

                        if ($total['code'] == "total") {
                            $totals += $total['value'];
                        }
                    }
                }

                $data['total'] = $totals * $currency_value;
                $data['shipping'] = $shipping * $currency_value;
                $data['affiliation'] = $this->config->get('config_name');

                foreach ($this->model_account_order->getOrderProducts($this->session->data['order_id']) as $product) {
                    $product_info = $this->model_catalog_product->getProduct($product["product_id"]);

                    if($product_info) {
                        $categories_data = '';

                        $query_category = $this->db->query("SELECT cd.name FROM `" . DB_PREFIX . "product_to_category` pc INNER JOIN `" . DB_PREFIX . "category_description` cd ON pc.category_id = cd.category_id WHERE pc.product_id = '" . (int)$product['product_id'] . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

                        foreach ($query_category->rows as $key=>$category) {
                            $key++;
                            if ($key <= 5) {
                                $categories_data .= $category['name'] . '/';
                            }
                        }

                        $categories_data = rtrim($categories_data, '/');

                        $options_data = '';
                        $options_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$this->session->data['order_id'] . "' AND order_product_id = '" . (int)$product['product_id'] . "'");

                        foreach ($options_query->rows as $option) {
                            if ($option['type'] != 'file') {
                                $options_data .= $option['name'] . ': ' . (utf8_strlen($option['value']) > 20 ? utf8_substr($option['value'], 0, 20) . '..' : $option['value']) . ' - ';
                            }
                        }

                        $options_data = rtrim($options_data, ' - ');

                        $price = (((float)$product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0)) * $currency_value);

                        $data['oct_analytics_order_products'][] = array(
                            'id' => $product['product_id'],
                            'name' => $product['name'],
                            'price' => $price,
                            'quantity' => $product['quantity'],
                            'brand' => $product_info['manufacturer'],
                            'category' => $categories_data,
                            'variant' => $options_data
                        );
                    }
                }
            }
			
			$this->cart->clear();

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				if ($this->customer->isLogged()) {
					$activity_data = array(
						'customer_id' => $this->customer->getId(),
						'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
						'order_id'    => $this->session->data['order_id']
					);

					$this->model_account_activity->addActivity('order_account', $activity_data);
				} else {
					$activity_data = array(
						'name'     => $this->session->data['guest']['firstname'] . ' ' . $this->session->data['guest']['lastname'],
						'order_id' => $this->session->data['order_id']
					);

					$this->model_account_activity->addActivity('order_guest', $activity_data);
				}
			}

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
			unset($this->session->data['totals']);
		}

		
        // $this->document->setTitle($this->language->get('heading_title'));
      


        if (!empty($this->session->data['recent_order_id'])) {
          $this->document->setTitle(sprintf($this->language->get('heading_title_order'), $this->session->data['recent_order_id']));
        } else {
          $this->document->setTitle($this->language->get('heading_title'));
        }
        
        if (!empty($this->session->data['recent_order_id'])) {
          $data['heading_title'] = sprintf($this->language->get('heading_title_order'), $this->session->data['recent_order_id']);
        } else {
          $data['heading_title'] = $this->language->get('heading_title');
        }

        if (!empty($this->session->data['recent_order_id'])) {
          $this->load->model('checkout/order');

          $order_info = $this->model_checkout_order->getOrder($this->session->data['recent_order_id']);
          
          $order_history_comment = $this->db->query("SELECT comment FROM " . DB_PREFIX . "order_history WHERE order_id = '" . (int)$order_info['order_id'] . "'");

          if ($order_history_comment->row['comment']) {
            $order_history_comment = nl2br($order_history_comment->row['comment']);
          } else {
            $order_history_comment = '';
          }
        }
      
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_basket'),
			'href' => $this->url->link('checkout/cart')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_checkout'),
			'href' => $this->url->link('checkout/checkout', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_success'),
			'href' => $this->url->link('checkout/success')
		);

		
        // $data['heading_title'] = $this->language->get('heading_title');
      

		if ($this->customer->isLogged()) {
			$data['text_message'] = sprintf($this->language->get('text_customer'), $this->url->link('account/account', '', true), $this->url->link('account/order', '', true), $this->url->link('account/download', '', true), $this->url->link('information/contact'));
		} else {
			$data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'));
		}


        if (isset($this->session->data['recent_order_id'])) {
          if ($this->customer->isLogged()) {
            if (!empty($this->session->data['recent_firstname'])) {
              $data['text_message'] = sprintf($this->language->get('text_customer_ordervs_firstname'), $this->session->data['recent_firstname'], $this->session->data['recent_order_id'], $this->url->link('account/account', '', 'SSL'), $this->url->link('account/order', '', 'SSL'), $this->url->link('account/download', '', 'SSL'),  $this->url->link('information/contact'));
            } else {
              $data['text_message'] = sprintf($this->language->get('text_customer_order'), $this->session->data['recent_order_id'], $this->url->link('account/account', '', 'SSL'), $this->url->link('account/order', '', 'SSL'), $this->url->link('account/download', '', 'SSL'),  $this->url->link('information/contact'));
            }
          } else {
            if (!empty($this->session->data['recent_firstname'])) {
              $data['text_message'] = sprintf($this->language->get('text_guest_order_vs_firstname'), $this->session->data['recent_firstname'], $this->session->data['recent_order_id'], $this->url->link('information/contact'));
            } else {
              $data['text_message'] = sprintf($this->language->get('text_guest_order'), $this->session->data['recent_order_id'], $this->url->link('information/contact'));
            }
          }
        } else {
          if ($this->customer->isLogged()) {
            $data['text_message'] = sprintf($this->language->get('text_customer'), $this->url->link('account/account', '', 'SSL'), $this->url->link('account/order', '', 'SSL'), $this->url->link('account/download', '', 'SSL'), $this->url->link('information/contact'));
          } else {
            $data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'));
          }
        }

        if (isset($order_history_comment) && $order_history_comment) {
          $data['text_message'] .= '<hr/>'.$order_history_comment;
        }
      
		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/success', $data));
	}
}