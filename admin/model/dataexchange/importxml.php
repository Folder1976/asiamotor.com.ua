<?php

ini_set( "memory_limit", "756M" );
ini_set( 'max_execution_time', 3600 );

class ModelDataexchangeImportXml extends Model {

  protected $DB_PREFIX;
  protected $_languages;
  protected $_seo;

  protected function _collectLanguages() {
    $languages = array();

    $lang = $this->db->query( "SELECT * FROM ".DB_PREFIX."language" );
    if ( $lang && count( $lang->rows ) ) {
      foreach ( $lang->rows as $result ) {
        $languages[$result['code']] = $result['language_id'];
      }
    }

    return $languages;
  }

  protected function _createTables() {
    /*
    $chekColumn = $this->db->query( "SHOW COLUMNS FROM " . DB_PREFIX . "manufacturer LIKE 'manufacturercode';" );
    if ( !count( $chekColumn->row ) ) {
      try {
        @$this->db->query( "ALTER TABLE " . DB_PREFIX . "manufacturer ADD COLUMN manufacturercode VARCHAR(150) NULL;" );
      } catch ( Exception $e ) {

      }
    }
    $chekColumn = $this->db->query( "SHOW COLUMNS FROM " . DB_PREFIX . "`order` LIKE 'inn';" );
    if ( !count( $chekColumn->row ) ) {
      try {
        @$this->db->query( "ALTER TABLE " . DB_PREFIX . "`order` ADD COLUMN inn VARCHAR(150) NOT NULL;" );
      } catch ( Exception $e ) {

      }
    }
    $chekColumn = $this->db->query( "SHOW COLUMNS FROM " . DB_PREFIX . "`order` LIKE 'edrpou';" );
    if ( !count( $chekColumn->row ) ) {
      try {
        @$this->db->query( "ALTER TABLE " . DB_PREFIX . "`order` ADD COLUMN edrpou VARCHAR(150) NOT NULL;" );
      } catch ( Exception $e ) {

      }
    }
    $chekColumn = $this->db->query( "SHOW COLUMNS FROM " . DB_PREFIX . "`order` LIKE 'calkpdf';" );
    if ( !count( $chekColumn->row ) ) {
      try {
        @$this->db->query( "ALTER TABLE " . DB_PREFIX . "`order` ADD COLUMN calkpdf VARCHAR(150) NOT NULL;" );
      } catch ( Exception $e ) {

      }
    }
    $chekColumn = $this->db->query( "SHOW COLUMNS FROM " . DB_PREFIX . "`order` LIKE 'pricepdf';" );
    if ( !count( $chekColumn->row ) ) {
      try {
        @$this->db->query( "ALTER TABLE " . DB_PREFIX . "`order` ADD COLUMN pricepdf VARCHAR(150) NOT NULL;" );
      } catch ( Exception $e ) {

      }
    }
    $chekColumn = $this->db->query( "SHOW COLUMNS FROM " . DB_PREFIX . "`order` LIKE 'aktpdf';" );
    if ( !count( $chekColumn->row ) ) {
      try {
        @$this->db->query( "ALTER TABLE " . DB_PREFIX . "`order` ADD COLUMN aktpdf VARCHAR(150) NOT NULL;" );
      } catch ( Exception $e ) {

      }
    }
    */
  }


  protected function _xml2array( $contents, $get_attributes = 1, $priority = 'tag' ) {
    if ( !$contents ) {
      return array();
    }
    if ( !function_exists( 'xml_parser_create' ) ) {
      return array();
    }

    $parser = xml_parser_create( '' );
    xml_parser_set_option( $parser, XML_OPTION_TARGET_ENCODING, "UTF-8" );
    xml_parser_set_option( $parser, XML_OPTION_CASE_FOLDING, 0 );
    xml_parser_set_option( $parser, XML_OPTION_SKIP_WHITE, 1 );
    xml_parse_into_struct( $parser, trim( $contents ), $xml_values );
    xml_parser_free( $parser );

    if ( !$xml_values ) {
      return;
    }

    $xml_array   = array();
    $parents     = array();
    $opened_tags = array();
    $arr         = array();

    $current = &$xml_array;

    $repeated_tag_index = array();

    foreach ( $xml_values as $data ) {
      unset( $attributes, $value );
      extract( $data );

      $result          = array();
      $attributes_data = array();

      if ( isset( $value ) ) {
        if ( $priority == 'tag' ) {
          $result = $value;
        } else {
          $result['value'] = $value;
        }
      }

      if ( isset( $attributes ) and $get_attributes ) {
        foreach ( $attributes as $attr => $val ) {
          if ( $priority == 'tag' ) {
            $attributes_data[$attr] = $val;
          } else {
            $result['attr'][$attr] = $val;
          }
        }
      }

      $tag = strtolower( $tag );
      if ( $type == "open" ) {

        $parent[$level - 1] = &$current;
        if ( !is_array( $current ) or ( !in_array( $tag, array_keys( $current ) )) ) {
          $current[$tag] = $result;
          if ( $attributes_data ) {
            $current[$tag . '_attr'] = $attributes_data;
          }
          $repeated_tag_index[$tag . '_' . $level] = 1;

          $current = &$current[$tag];
        } else {

          if ( isset( $current[$tag][0] ) ) {
            $current[$tag][$repeated_tag_index[$tag . '_' . $level]] = $result;
            $repeated_tag_index[$tag . '_' . $level] ++;
          } else {
            $current[$tag]                           = array( $current[$tag], $result );
            $repeated_tag_index[$tag . '_' . $level] = 2;

            if ( isset( $current[$tag . '_attr'] ) ) {
              $current[$tag]['0_attr'] = $current[$tag . '_attr'];
              unset( $current[$tag . '_attr'] );
            }
          }
          $last_item_index = $repeated_tag_index[$tag . '_' . $level] - 1;
          $current         = &$current[$tag][$last_item_index];
        }
      } elseif ( $type == "complete" ) {

        if ( !isset( $current[$tag] ) ) {
          $current[$tag]                           = $result;
          $repeated_tag_index[$tag . '_' . $level] = 1;
          if ( $priority == 'tag' and $attributes_data ) {
            $current[$tag . '_attr'] = $attributes_data;
          }
        } else {
          if ( isset( $current[$tag][0] ) and is_array( $current[$tag] ) ) {
            $current[$tag][$repeated_tag_index[$tag . '_' . $level]] = $result;

            if ( $priority == 'tag' and $get_attributes and $attributes_data ) {
              $current[$tag][$repeated_tag_index[$tag . '_' . $level] . '_attr'] = $attributes_data;
            }
            $repeated_tag_index[$tag . '_' . $level] ++;
          } else {
            $current[$tag]                           = array( $current[$tag], $result );
            $repeated_tag_index[$tag . '_' . $level] = 1;

            if ( $priority == 'tag' and $get_attributes ) {
              if ( isset( $current[$tag . '_attr'] ) ) {
                $current[$tag]['0_attr'] = $current[$tag . '_attr'];
                unset( $current[$tag . '_attr'] );
              }
              if ( $attributes_data ) {
                $current[$tag][$repeated_tag_index[$tag . '_' . $level] . '_attr'] = $attributes_data;
              }
            }
            $repeated_tag_index[$tag . '_' . $level] ++;
          }
        }
      } elseif ( $type == 'close' ) {
        $current = &$parent[$level - 1];
      }
    }
    return ($xml_array);
  }

 
  public function importXml( $files ) {
  
    $this->load->model( 'catalog/product' );
    //$this->load->model( 'catalog/autoseourls' );
    //$this->_seo = new ModelCatalogAutoseourls;

    $this->_createTables();
    $this->_languages = $this->_collectLanguages();

    $this->DB_PREFIX = DB_PREFIX;

    foreach ( $files as $file ) {
      $_file = str_replace( array( 'import/', '.xml' ), '', strtolower( $file ) );

        $filetime = filemtime( DIR_APPLICATION . '../' . $file );
       
        $data  = $this->_xml2array( file_get_contents( $file ) );
        
        $this->setOnProducts( $data,  $filetime );
        $this->importProductsModels( $data,  $filetime );
        $this->importProductsLinks( $data,  $date = '' );
        //$this->importPrices( $data, $count['value'], $filetime );
  
    }
    return TRUE;
  }
 public function importPHP( $DATA ) {
  
      $this->load->model( 'catalog/product' );
      $this->_languages = $this->_collectLanguages();

      $this->DB_PREFIX = DB_PREFIX;

      $data = $this->_xml2array( $DATA );
        
      $this->importProductsModels( $data,  '' );
      $this->importProductsLinks( $data,  $date = '' );
      //$this->importPrices( $data, $count['value'], $filetime );
      
      return TRUE;
  }

  
  //import prices and products
  public function importProductsLinks( $data,  $date = '' ) {
    //primenimost_spisok
    if ( isset( $data['file']['primenimost_spisok']['primenimost'] ) && is_array( $data['file']['primenimost_spisok']['primenimost']  ) ) {
      
      foreach($data['file']['primenimost_spisok']['primenimost']  as $row){
        
        if(!empty($row['tovarkey']) AND !empty($row['modelkey'])){
          
            $sql =  "INSERT INTO `" . DB_PREFIX . "car_primenimost` SET
                              tovarkey = '".$this->db->escape($row['tovarkey'])."',
                              modelkey = '".$this->db->escape($row['modelkey'])."'
                            ON DUPLICATE KEY UPDATE
                              tovarkey = '".$this->db->escape($row['tovarkey'])."',
                              modelkey = '".$this->db->escape($row['modelkey'])."'
                            ";
            $this->db->query($sql);
            
          }
        
          
      }
    }
  }

 public function setOnProducts( $data,  $date = '' ) {
    //tovary_vkl
    if ( isset( $data['file']['tovary_vkl']['tovarkey']) && is_array( $data['file']['tovary_vkl']['tovarkey'] ) ) {
      
      $sql = "UPDATE `" . DB_PREFIX . "product` SET status=0";
      $this->db->query($sql);
      
      foreach($data['file']['tovary_vkl']['tovarkey'] as $row){
            $sql =  "UPDATE  `" . DB_PREFIX . "product` p SET status=1 WHERE p.product_id IN
              (SELECT p1c.product_id FROM  `" . DB_PREFIX . "product_to_1c` p1c WHERE 1c_id = '".$row."')
                            ";
            $this->db->query($sql);
          
          
      }
    }
  }

  //import prices and products
  public function importProductsModels( $data,  $date = '' ) {
    //primenimost_spisok
    
    if ( isset( $data['file']['modeli_spisok']['item']  ) && is_array( $data['file']['modeli_spisok']['item']  ) ) {
      
      foreach($data['file']['modeli_spisok']['item']  as $model){
        
        if(!empty($model['marka']) AND !empty($model['model'])){
          
          $mark_id = $this->getMarkId($model['marka']);
          
          $model_id = 0;
          if($mark_id > 0){
            $model_id = $this->getModelId($model['model'], $mark_id);
          }
         
          if($mark_id > 0 AND $model_id > 0){
            
            if(empty($model['god1'])) $model['god1'] = date('Y');
            if(empty($model['god2'])) $model['god2'] = date('Y');
            //if(empty($model['goda'])){
              $model['goda'] = '';
              for($i = (int)$model['god1'];$i <= (int)$model['god2']; $i++){
                $model['goda'] .= $i.';';
              }
            //}
            
            $model['goda'] = trim($model['goda'], ';') . ';';
            
            $sql =  "INSERT INTO `" . DB_PREFIX . "car` SET
                              name = '".$this->db->escape($model['name'])."',
                              `key` = '".$this->db->escape($model['key'])."',
                              mark_id = '".(int)$mark_id."',
                              model_id = '".(int)$model_id."',
                              god1 = '".$this->db->escape($model['god1'])."',
                              god2 = '".$this->db->escape($model['god2'])."',
                              goda = '".$this->db->escape($model['goda'])."',
                              dvigunkey = '".$this->db->escape($model['dvigunkey'])."'
                            ON DUPLICATE KEY UPDATE
                              name = '".$this->db->escape($model['name'])."',
                              mark_id = '".(int)$mark_id."',
                              model_id = '".(int)$model_id."',
                              god1 = '".$this->db->escape($model['god1'])."',
                              god2 = '".$this->db->escape($model['god2'])."',
                              goda = '".$this->db->escape($model['goda'])."',
                              dvigunkey = '".$this->db->escape($model['dvigunkey'])."'
                            ";
            $this->db->query($sql);
            
          }
        
          if(!empty($model['dvigun'])){
            $this->db->query( "INSERT INTO `" . DB_PREFIX . "car_dvigun` SET
                              dvigun = '".$this->db->escape($model['dvigun'])."',
                              dvigunkey = '".$this->db->escape($model['dvigunkey'])."'
                            ON DUPLICATE KEY UPDATE
                              dvigun = '".$this->db->escape($model['dvigun'])."',
                              dvigunkey = '".$this->db->escape($model['dvigunkey'])."'
                            " );
          }
          
          //echo "<pre>";print_r(var_dump($model));echo "</pre>";
          //die();
          
        }
      }
    }
  }
  public function getMarkId($name){

    $res = $this->db->query( "SELECT * FROM `" . DB_PREFIX . "car_mark` WHERE
                            mark_name = '".$this->db->escape(trim($name))."'
                            LIMIT 1");
    
    if($res->num_rows){
    
      return (int)$res->row['mark_id'];
    
    }else{
      
      $this->db->query( "INSERT INTO `" . DB_PREFIX . "car_mark` SET
                            mark_name = '".$this->db->escape(trim($name))."'");
      return $this->db->getLastId();
    }
    
  }
  public function getModelId($name, $mark_id){
    $res = $this->db->query( "SELECT * FROM `" . DB_PREFIX . "car_model` WHERE
                            model_name = '".$this->db->escape(trim($name))."' AND
                            mark_id = '" .(int)$mark_id."' 
                            LIMIT 1");
    
    if($res->num_rows){
    
      return (int)$res->row['model_id'];
    
    }else{
      
      $this->db->query( "INSERT INTO `" . DB_PREFIX . "car_model` SET
                            model_name = '".$this->db->escape(trim($name))."',
                            mark_id = '". (int)$mark_id."'");
      return $this->db->getLastId();
    }
  }
  

}
