import os
import numpy
from e3sm_diags.parameter.core_parameter import CoreParameter


from e3sm_diags.run import runner

short_name = '20230924.v3alpha04_trigrid.piControl.chrysalis'
test_ts = ''
start_yr = int('0201')
end_yr = int('0300')
num_years = end_yr - start_yr + 1

param = CoreParameter()

# Model
param.test_data_path = 'climo_test'
param.test_name = '20230924.v3alpha04_trigrid.piControl.chrysalis'
param.short_test_name = '20230924.v3alpha04_trigrid.piControl.chrysalis'

# Reference
param.reference_data_path = 'climo_ref'
param.ref_name = '20230918.v3alpha04_bigrid.piControl.chrysalis'
param.short_ref_name = '20230918.v3alpha04_bigrid.piControl.chrysalis'
# Optionally, swap test and reference model
if False:
   param.test_data_path, param.reference_data_path = param.reference_data_path, param.test_data_path
   param.test_name, param.ref_name = param.ref_name, param.test_name
   param.short_test_name, param.short_ref_name = param.short_ref_name, param.short_test_name

# Output dir
param.results_dir = 'model_vs_model_0201-0300'

# Additional settings
param.run_type = 'model_vs_model'
param.diff_title = 'Difference'
param.output_format = ['png']
param.output_format_subplot = []
param.multiprocessing = True
param.num_workers = 24
#param.fail_on_incomplete = True
params = [param]

# Run
runner.sets_to_run = ['aerosol_aeronet', 'aerosol_budget' ]
runner.run_diags(params)

