<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModuleOctProductSizesTable extends Controller {
    private $error = array();
    
    public function index() {
        $this->load->language('extension/module/oct_product_sizes_table');
        
        //CKEditor
        if ($this->config->get('config_editor_default')) {
            $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
            $this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
        } else {
            $this->document->addScript('view/javascript/summernote/summernote.js');
            $this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
            $this->document->addScript('view/javascript/summernote/opencart.js');
            $this->document->addStyle('view/javascript/summernote/summernote.css');
        }
        
        $data['ckeditor'] = $this->config->get('config_editor_default');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        
        $data['token'] = $this->session->data['token'];
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('oct_product_sizes_table', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }
        
        $data['heading_title'] = $this->language->get('heading_title');
        
        $data['text_edit']         = $this->language->get('text_edit');
        $data['text_enabled']      = $this->language->get('text_enabled');
        $data['text_disabled']     = $this->language->get('text_disabled');
        $data['text_confirm']      = $this->language->get('text_confirm');
        $data['text_yes']          = $this->language->get('text_yes');
        $data['text_no']           = $this->language->get('text_no');
        $data['text_select_all']   = $this->language->get('text_select_all');
        $data['text_unselect_all'] = $this->language->get('text_unselect_all');
        
        $data['tab_setting'] = $this->language->get('tab_setting');
        
        $data['entry_status']         = $this->language->get('entry_status');
        $data['entry_size_link']      = $this->language->get('entry_size_link');
        $data['entry_size_text']      = $this->language->get('entry_size_text');
        $data['entry_size_add']       = $this->language->get('entry_size_add');
        $data['entry_size_title']     = $this->language->get('entry_size_title');
        $data['entry_size_block']     = $this->language->get('entry_size_block');
        $data['entry_category_block'] = $this->language->get('entry_category_block');
        $data['entry_size_sect']      = $this->language->get('entry_size_sect');
        
        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
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
        
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/oct_product_sizes_table', 'token=' . $this->session->data['token'], true)
        );
        
        $data['action'] = $this->url->link('extension/module/oct_product_sizes_table', 'token=' . $this->session->data['token'], true);
        
        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        
        if (isset($this->request->post['oct_product_sizes_table_data'])) {
            $data['oct_product_sizes_table_data'] = $this->request->post['oct_product_sizes_table_data'];
        } else {
            $data['oct_product_sizes_table_data'] = $this->config->get('oct_product_sizes_table_data');
        }
        
        $this->load->model('catalog/category');
        
        $data['categories'] = $this->model_catalog_category->getCategories();
        
        $this->load->model('localisation/language');
        $data['languages'] = $this->model_localisation_language->getLanguages();
        
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        
        $this->response->setOutput($this->load->view('extension/module/oct_product_sizes_table.tpl', $data));
    }
    
    public function install() {
        $this->load->language('extension/module/oct_product_sizes_table');
        
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('user/user_group');
        
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/oct_product_sizes_table');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/oct_product_sizes_table');
        
        $this->model_setting_setting->editSetting('oct_product_sizes_table', array(
            'oct_product_sizes_table_data' => array(
                'status' => '1',
                'sections' => array()
            )
        ));
        
        if (!in_array('oct_product_sizes_table', $this->model_extension_extension->getInstalled('module'))) {
            $this->model_extension_extension->install('module', 'oct_product_sizes_table');
        }
        
        $this->session->data['success'] = $this->language->get('text_success_install');
    }
    
    public function uninstall() {
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        
        $this->model_extension_extension->uninstall('module', 'oct_product_sizes_table');
        $this->model_setting_setting->deleteSetting('oct_product_sizes_table_data');
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/oct_product_sizes_table')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        return !$this->error;
    }
}