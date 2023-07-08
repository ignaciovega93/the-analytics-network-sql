DROP TABLE IF EXISTS dim.product_master ;
    
CREATE TABLE dim.product_master
                 (
                              product_id	  VARCHAR(255) PRIMARY KEY
                            , name		      VARCHAR(255)
                            , category        VARCHAR(255)
                            , subcategory     VARCHAR(255)
                            , subsubcategory  VARCHAR(255)
                            , material        VARCHAR(255)
                            , colour          VARCHAR(255)
                            , made_in         VARCHAR(255)
                            , ean             BIGINT
                            , is_active       BOOLEAN
                            , has_bluetooth   BOOLEAN
                            , size            VARCHAR(255)
                 );
