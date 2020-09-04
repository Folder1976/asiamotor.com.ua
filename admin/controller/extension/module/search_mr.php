<?php

class ControllerExtensionModuleSearchMr extends Controller {

	private $error = array();

	public function index() {

		$data = $this->load->language('extension/module/search_mr');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('catalog/search_mr');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting('search_mr', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['new_fields'])) {
			$data['error_new_fields'] = $this->error['new_fields'];
		} else {
			$data['error_new_fields'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'),
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/search_mr', 'token=' . $this->session->data['token'], 'SSL'),
		);

		$data['action'] = $this->url->link('extension/module/search_mr', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['search_mr_status'])) {
			$data['search_mr_status'] = $this->request->post['search_mr_status'];
		} else {
			$data['search_mr_status'] = $this->config->get('search_mr_status');
		}

		if (isset($this->request->post['search_mr_options'])) {
			$data['options'] = $this->request->post['search_mr_options'];
		} elseif ($this->config->get('search_mr_options')) {
			$data['options'] = $this->config->get('search_mr_options');
		}

		$fields = $this->model_catalog_search_mr->getFields();
		if (!empty($data['options']['new_fields'])) {
			foreach ($data['options']['new_fields'] as $field) {
				$fields[] = $field['field'];
			}
		}
		$data['fields'] = $fields;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/search_mr.tpl', $data));
	}

	public function install() {

		$this->load->model('setting/setting');
		$this->load->model('catalog/search_mr');

		$this->model_catalog_search_mr->install();

		$this->model_setting_setting->deleteSetting('search_mr');
		$setting['search_mr_options'] = $this->model_catalog_search_mr->getDefaultOptions();
		$this->model_setting_setting->editSetting('search_mr', $setting);
	}

	public function uninstall() {

		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting('search_mr');
	}

	private function validate() {

		if (!$this->user->hasPermission('modify', 'extension/module/search_mr')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!empty($this->request->post['search_mr_options']['new_fields'])) {
			foreach ($this->request->post['search_mr_options']['new_fields'] as $field) {
				if ((utf8_strlen(trim($field['field'])) < 1)) {
					$this->error['new_fields'][$field['field']] = $this->language->get('error_field');
					$this->error['warning'] = $this->language->get('error_warning');
				}
			}
		}

		return!$this->error ? true : false;
	}

}
//author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)
