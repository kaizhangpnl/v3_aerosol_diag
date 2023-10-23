## Scripts to call e3sm_diag and make aerosol diagnostics 

## Experiments 

- v3atm_v21
  - v3atm fourth smoke 
- v3alpha01
  - linoz_psc_t = 198.0 (preferred setting, instead of 197.5)
  - Corrected MAM5 radiative properties input file
- v3alpha02
  - p3_nc_autocon_expon = -1.20D0 (instead of -1.40D0 in v3alpha01) 
- v3alpha03_bigrid
  - Linoz bug fixes, simulation period specific oxidant files
  - Change to aerosol mono-layers from 8 to 3
  - Increase in DMS emissions by 100%
  - CLUBB sensible heat flux and thetal/T conversion bug fixes
  - ELM subgrid-topography for radiation (TOP)
  - New ELM initial condition files
- v3alpha04_bigrid 
  - NOx lightning source with 5x scaling factor
    - lght_no_prd_factor = 5.D0
  - Slight retuning of autoconversion exponent to minimize drift
    - p3_nc_autocon_expon = -1.10D0
  - TOP parameterization: use_top_solar_rad = .true.
- v3alpha04_trigrid
  
## Results (newest first) 

### piControl  

#### v3alpha04_trigrid vs. v3alpha04_bigrid 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_04tri04bi_0001_0100/model_vs_model_0001-0100/viewer/ 

#### v3alpha04_bigrid vs. v3alpha03_bigrid

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_04bi03bi_0001_0100/model_vs_model_0001-0100/viewer/

#### v3alpha03_bigrid vs. v3alpha02

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_03bi02bi_0001_0100/model_vs_model_0001-0100/viewer/

#### v3alpha02 vs. v3alpha01

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_02bi01bi_v21_0001_0100/model_vs_model_0001-0100/viewer/

#### v3alpha01 vs. v3atm_v21

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_01biv3atm_v21_0001_0100/model_vs_model_0001-0100/viewer/



