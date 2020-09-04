<?php

class ControllerDataexchangeImportxml extends Controller {

  public function index() {
    
    $DATA = file_get_contents('php://input');
    $uploadFiles = 'php://input';
    $this->load->model('dataexchange/importxml');
    
    if(!empty($DATA)){
        $this->model_dataexchange_importxml->importPHP($DATA);
        $log = date('Y-m-d H:i:s');
        echo $log ." - ok";
        return true;
    }else{
      if (isset($this->request->get['filename'])) {
        $uploadFiles = array('import/' . $this->request->get['filename'] . '.xml');
      } else {
        $uploadFiles = array(
          'export/import.xml',
        );
      }
  
      foreach ($uploadFiles as $_uplodFile) {
        if ( !file_exists( $_uplodFile ) ) {
          echo "failure\n";
          echo "File not exists: {$_uplodFile} \n";
          return;
        }
  
        if ( !is_readable( $_uplodFile ) ) {
          echo "failure\n";
          echo "Can not open file: {$_uplodFile} \n";
          return;
        }
  
        $DATA = file_get_contents($_uplodFile);
        if (empty($DATA)) {
          echo "failure\n";
          echo "No data file for {$_uplodFile} \n";
          return;
        }
      }
    }
    
    $log = date('Y-m-d H:i:s').' - '.implode(',', $uploadFiles) .' == ' .implode(',', $_GET);
    
    //$this->load->model('dataexchange/importxml');
    if ($this->model_dataexchange_importxml->importXml($uploadFiles)) {
       echo $log ."- ok";
       file_put_contents('import_log.txt', $log . " - ok\n", FILE_APPEND);
    } else {
       echo $log ."- error";
       file_put_contents('import_log.txt', $log . " - error\n", FILE_APPEND);
    }

    $this->cache->delete('product');
    return;
  }

}
