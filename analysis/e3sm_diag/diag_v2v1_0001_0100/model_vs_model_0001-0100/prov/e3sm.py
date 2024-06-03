import os
import numpy
from e3sm_diags.parameter.core_parameter import CoreParameter


from e3sm_diags.run import runner

short_name = 'v2.LR.piControl'
test_ts = ''
start_yr = int('0001')
end_yr = int('0100')
num_years = end_yr - start_yr + 1

param = CoreParameter()

# Model
param.test_data_path = 'climo_test'
param.test_name = 'v2.LR.piControl'
param.short_test_name = 'v2.LR.piControl'

# Reference
param.reference_data_path = 'climo_ref'
param.ref_name = '20180129.DECKv1b_piControl.ne30_oEC.edison'
param.short_ref_name = '20180129.DECKv1b_piControl.ne30_oEC.edison'
# Optionally, swap test and reference model
if False:
   param.test_data_path, param.reference_data_path = param.reference_data_path, param.test_data_path
   param.test_name, param.ref_name = param.ref_name, param.test_name
   param.short_test_name, param.short_ref_name = param.short_ref_name, param.short_test_name

# Output dir
param.results_dir = 'model_vs_model_0001-0100'

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

