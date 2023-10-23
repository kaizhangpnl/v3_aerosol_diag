## Scripts to call e3sm_diag and make aerosol diagnostics 

## Experiments 

- v3atm_v21 (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3695214789/20230224.v3atm+v21.piControl.chrysalis) 
  - NGD_v3atm_v2.1ocnice_alt 
- v3alpha01 (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3826712577/20230616.v3alpha01.piControl.chrysalis)
  - aqueous chemistry bug fix 
  - decoupled SOA (gas reactions) from Chem UCI to improve the low ozone bias
  - ZM changes to improve energy conservation
  - lowered optimization on ZM to make results consistent across machines (compy vs pm-cpu)
  - Increased dust emission tuning parameter based on Fourth Smoke Test (v3_dev) biases
  - linoz_psc_t = 198.0 (preferred setting, instead of 197.5)
  - Corrected MAM5 radiative properties input file
- v3alpha02 (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3832086529/20230622.v3alpha02.piControl.chrysalis) 
  - p3_nc_autocon_expon = -1.20D0 (instead of -1.40D0 in v3alpha01) 
- v3alpha03_bigrid (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3922034928/20230914.v3alpha03+bigrid.piControl.chrysalis) 
  - Linoz bug fixes, simulation period specific oxidant files
  - Change to aerosol mono-layers from 8 to 3
  - Increase in DMS emissions by 100%
  - CLUBB sensible heat flux and thetal/T conversion bug fixes
  - ELM subgrid-topography for radiation (TOP)
  - New ELM initial condition files
- v3alpha04_bigrid (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3924393985/20230918.v3alpha04+bigrid.piControl.chrysalis) 
  - NOx lightning source with 5x scaling factor
    - lght_no_prd_factor = 5.D0
  - Slight retuning of autoconversion exponent to minimize drift
    - p3_nc_autocon_expon = -1.10D0
  - TOP parameterization: use_top_solar_rad = .true.
- v3alpha04_trigrid (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3929440257/20230924.v3alpha04+trigrid.piControl.chrysalis) 
  
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



