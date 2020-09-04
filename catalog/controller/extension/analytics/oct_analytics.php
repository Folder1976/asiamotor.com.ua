<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionAnalyticsOCTAnalytics extends Controller {
    public function index() {
		$data = array();

        $data['oct_analytics_google_status'] = $this->config->get('oct_analytics_google_status');
        $data['oct_analytics_google_code'] = $this->config->get('oct_analytics_google_status') ? $this->config->get('oct_analytics_google_code') : '';

        $data['oct_analytics_yandex_status'] = $this->config->get('oct_analytics_yandex_status');
        $data['oct_analytics_yandex_code'] = $this->config->get('oct_analytics_yandex_status') ? $this->config->get('oct_analytics_yandex_code') : '';
        $data['oct_analytics_yandex_ecommerce'] = $this->config->get('oct_analytics_yandex_ecommerce');
        $data['oct_analytics_yandex_container'] = $this->config->get('oct_analytics_yandex_container');

        if ((isset($data['oct_analytics_google_status']) && $data['oct_analytics_google_status']) ||(isset($data['oct_analytics_yandex_status']) && $data['oct_analytics_yandex_status'])) {
            $data['oct_analytics_targets'] = $this->config->get('oct_analytics_targets');
        } else {
            $data['oct_analytics_targets'] = '';
        }

		return $this->load->view('extension/analytics/oct_analytics', $data);
	}
}
