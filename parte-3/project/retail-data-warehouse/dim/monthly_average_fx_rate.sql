DROP TABLE IF EXISTS dim.monthly_average_fx_rate;
    
CREATE TABLE dim.monthly_average_fx_rate
                 (
                              month         DATE
                            , usd_peso_rate DECIMAL
                            , usd_eur_rate  DECIMAL
                            , usd_uru_rate  DECIMAL
                 );
