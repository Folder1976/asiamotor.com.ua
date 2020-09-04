<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModuleOctProductsFromCategory extends Controller {
    private $error = array();
    
    public function index() {
	    $data = array();
        $data = array_merge($data, $this->load->language('extension/module/oct_products_from_category'));
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $this->load->model('extension/module');             
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule('oct_products_from_category', $this->request->post);
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
            }
            
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }
        
        if (isset($this->error['dimension'])) {
            $data['error_dimension'] = $this->error['dimension'];
        } else {
            $data['error_dimension'] = array();
        }
        
        $data['breadcrumbs'] = array();
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );
        
        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/oct_products_from_category', 'token=' . $this->session->data['token'], true)
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/oct_products_from_category', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
            );
        }
        
        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }
        
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $data['status'] = $module_info['status'];
        } else {
            $data['status'] = '';
        }
        
        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('extension/module/oct_products_from_category', 'token=' . $this->session->data['token'], true);
        } else {
            $data['action'] = $this->url->link('extension/module/oct_products_from_category', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
        }
        
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        
        $data['token']   = $this->session->data['token'];
        
        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = isset($module_info['name']) ? $module_info['name'] : '';
        } else {
            $data['name'] = '';
        }
        
        if (isset($this->request->post['autoplay'])) {
            $data['autoplay'] = $this->request->post['autoplay'];
        } elseif (!empty($module_info)) {
            $data['autoplay'] = isset($module_info['autoplay']) ? $module_info['autoplay'] : 1;
        } else {
            $data['autoplay'] = '1';
        }
        
        if (isset($this->request->post['width'])) {
            $data['width'] = $this->request->post['width'];
        } elseif (!empty($module_info)) {
            $data['width'] = isset($module_info['height']) ? $module_info['width'] : 200;
        } else {
            $data['width'] = '200';
        }
        
        if (isset($this->request->post['height'])) {
            $data['height'] = $this->request->post['height'];
        } elseif (!empty($module_info)) {
            $data['height'] = isset($module_info['height']) ? $module_info['height'] : 200;
        } else {
            $data['height'] = '200';
        }
        
        if (isset($this->request->post['limit'])) {
            $data['limit'] = $this->request->post['limit'];
        } elseif (!empty($module_info)) {
            $data['limit'] = isset($module_info['limit']) ? $module_info['limit'] : 20;
        } else {
            $data['limit'] = '20';
        }
        
        if (isset($this->request->post['view'])) {
            $data['view'] = $this->request->post['view'];
        } elseif (!empty($module_info)) {
            $data['view'] = isset($module_info['view']) ? $module_info['view'] : 'carousel';
        } else {
            $data['view'] = 'carousel';
        }
        
        if (isset($this->request->post['show_no_quantity_products'])) {
            $data['show_no_quantity_products'] = $this->request->post['show_no_quantity_products'];
        } elseif (!empty($module_info)) {
            $data['show_no_quantity_products'] = isset($module_info['show_no_quantity_products']) ? $module_info['show_no_quantity_products'] : 1;
        } else {
            $data['show_no_quantity_products'] = 0;
        }        
        
        if (isset($this->request->post['oct_pfc_module'])) {
            $data['oct_pfc_module'] = $this->request->post['oct_pfc_module'];
        } elseif (!empty($module_info)) {
            $data['oct_pfc_module'] = isset($module_info['oct_pfc_module']) ? $module_info['oct_pfc_module'] : array();
        } else {
            $data['oct_pfc_module'] = array();
        }
        
        if (!isset($data['oct_pfc_module'][0]['orderby'])) {
	        $data['oct_pfc_module'][0]['orderby'] = 'pd.name';
        }
        
        $data['products_list_sel'] = array();
            
        if (isset($module_info['oct_pfc_module']['0']['products_list']) && !empty($module_info['oct_pfc_module']['0']['products_list'])) {
            foreach ($module_info['oct_pfc_module']['0']['products_list'] as $product_id) {
                $product = $this->model_catalog_product->getProduct((int) $product_id);
                
                if (isset($product['product_id'])) {
                    $data['products_list_sel'][] = array(
                        'product_id' => $product['product_id'],
                        'name' => $product['name']
                    );
                }
            }
        }
        
        $this->load->model('catalog/category');
        $data['categories'] = $this->model_catalog_category->getCategories(0);
        
        $this->load->model('localisation/language');
        $data['languages'] = $this->model_localisation_language->getLanguages();
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/oct_products_from_category.tpl', $data));
    }
    
    private function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/oct_products_from_category')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}