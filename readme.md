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
- v3alpha04_trigrid (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3929440257/20230924.v3alpha04+trigrid.piControl.chrysalis) Based on 20230918.v3alpha04_bigrid.piControl.chrysalis but 
  - tri-grid
  - nonlinear maps for tri-grid
  - custom PE-Layout (100 nodes)
  - land trigrid spinup IC 
- v3alpha04_trigrid_bgc (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3929440257/20230924.v3alpha04+trigrid.piControl.chrysalis) Based on 20230924.v3alpha04_trigrid.piControl.chrysalis except for
  - Land BGC feature
  - Land setting and IC preparation
  - a new custom PE-Layout (100 nodes)
  - H2OLNZ is added to eam.h0 per E3SM Diags request
- v3b01 (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/3984261154/20231105.v3b01.piControl.chrysalis) Based on 20231027.v3alpha04_trigrid_ECwISC30to60E3r2.piControl.chrysalis except for
  - Land BGC feature
  - Land setting and IC preparation
  - a new custom PE-Layout (100 nodes)
  - atm PR changes
  - new atm tuning parameter setting: dust_emis_fact =  13.8D0
  - new variables are added for dust emission
  - L80 atm model setting
- v3b02 (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/4005068802/20231117.v3b02.piControl.chrysalis) Based on 20231106.v3b01-AB2.piControl.chrysalis except for
  - smoothed bathymetry (included through patching MPAS ocean and seaice stream files)
  - a new custom PE-Layout (96 nodes)
  - atm gustiness fix
  - atm rough topography 
- v3-spinup (https://acme-climate.atlassian.net/wiki/spaces/CM/pages/4032626741/20231209.v3.LR.piControl-spinup.chrysalis) 
  - casename = 20231209.v3.LR.piControl-spinup.chrysalis
  - compset = WCYCL1850
  - resolution = ne30pg2_r05_IcoswISC30E3r5
  - ne30pg2: atmosphere (ne30 dynamics grid, pg2 physics grid)
  - r05: land and river on 1/2 lat/lon grid (commonly referred to as “tri-grid”)
  - IcoswISC30E3r5: ocean and sea-ice on Icosahedral 30 km mesh with ice shelves cavities (wISC), E3SMv3 (E3) revision r5.

## Results (newest first) 

### piControl  

#### v3-spinup vs. v3b02 (not all variables are available) 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_v3spinupv3b02_0001_0100/model_vs_model_0001-0100/viewer/  

#### v3b02 vs. v3b01 (gustness fix affects dust emission and aod) 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_v3b02v3b01_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3b02.piControl_v3b01.piControl/

#### v3b01 vs. v3alpha04_trigrid_bgc 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_v3b01v04tribgc_0001_0100/model_vs_model_0001-0050/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3b01.piControl_v3alpha04_trigrid_bgc.piControl/

#### v3alpha04_trigrid_bgc vs. v3alpha04_trigrid

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_04tribgc04tri_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3alpha04_trigrid_bgc.piControl_v3alpha04_trigrid.piControl/

#### v3alpha04_trigrid vs. v3alpha04_bigrid 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_04tri04bi_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3alpha04_trigrid.piControl_v3alpha04_bigrid.piControl/

#### v3alpha04_bigrid vs. v3alpha03_bigrid

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_04bi03bi_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3alpha04_bigrid.piControl_v3alpha03_bigrid.piControl/

#### v3alpha03_bigrid vs. v3alpha02

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_03bi02bi_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3alpha03_bigrid.piControl_v3alpha02.piControl/
  
#### v3alpha02 vs. v3alpha01

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_02bi01bi_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3alpha02.piControl_v3alpha01.piControl/

#### v3alpha01 vs. v2 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_v3alpha01v2_0001_0100/model_vs_model_0001-0100/viewer/
- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/diag/diag_v3alpha01.piControl_v2.LR.piControl/

#### v2 vs. v1 

- https://web.lcrc.anl.gov/public/e3sm/diagnostic_output/ac.kzhang/prod/diag_v2v1_0001_0100/model_vs_model_0001-0100/viewer/



