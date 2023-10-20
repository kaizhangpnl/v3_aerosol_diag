#!/bin/bash
# chrysalis
#............................................................................ 
#SBATCH  --job-name=diagaer
#SBATCH  --account=diagaer
#SBATCH  --nodes=1
#SBATCH  --output=diagaer.o%j
#SBATCH  --exclusive
#SBATCH  --time=02:00:00
#SBATCH  --partition=debug
#............................................................................ 
source /lcrc/soft/climate/e3sm-unified/load_latest_e3sm_unified_chrysalis.sh

#.........................................................
# Basic definitions
#.........................................................
#case_ctrl="20230918.v3alpha04_bigrid.piControl.chrysalis"
#case_test="20230924.v3alpha04_trigrid.piControl.chrysalis"
case_ctrl="20230914.v3alpha03_bigrid.piControl.chrysalis"
case_test="20230918.v3alpha04_bigrid.piControl.chrysalis"

short_ctrl=${case_ctrl}
short_test=${case_test}

logname="e3sm_diag_100yr" 

#pctrl=/lcrc/group/e3sm2/ac.golaz/E3SMv3_dev
#ptest=/lcrc/group/e3sm2/ac.xzheng/E3SMv3_dev
pctrl=/lcrc/group/e3sm2/ac.golaz/E3SMv3_dev
ptest=/lcrc/group/e3sm2/ac.golaz/E3SMv3_dev

climo_dir_ctrl=${pctrl}/${case_ctrl}/post/atm/180x360_aave/clim/100yr
climo_dir_test=${ptest}/${case_test}/post/atm/180x360_aave/clim/100yr

run_type="model_vs_model"
tag="model_vs_model"

#.........................................................
# www
#.........................................................
www="/lcrc/group/e3sm/public_html/diagnostic_output/ac.kzhang/T1"

#www_name="diag_04tri04bi_0101_0200"
#www_name="diag_04tri04bi_0201_0300"
www_name="diag_04bi03bi_0001_0100"

#.........................................................
# period
#.........................................................
#test_Y1="0201"
#test_Y2="0300"
test_Y1="0001"
test_Y2="0100"
ctrl_Y1="${test_Y1}"
ctrl_Y2="${test_Y2}"

results_dir=${tag}_${test_Y1}-${test_Y2}

#.........................................................
# Turn on debug output if needed
#.........................................................
debug=False
if [[ "${debug,,}" == "true" ]]; then
  set -x
fi

#.........................................................
# Make sure UVCDAT doesn't prompt us about anonymous logging
#.........................................................
#export UVCDAT_ANONYMOUS_LOG=False

# Script dir
cd ./

# Get jobid
id=${SLURM_JOBID}

#.........................................................
# Update status file
#.........................................................
STARTTIME=$(date +%s)
echo "RUNNING ${id}" > ${logname}.status

#.........................................................
# Create temporary workdir
#.........................................................
workdir=`mktemp -d tmp.${id}.XXXX`
cd ${workdir}

create_links_climo()
{
  climo_dir_source=$1
  climo_dir_destination=$2
  nc_prefix=$3
  begin_year=$4
  end_year=$5
  error_num=$6
  mkdir -p ${climo_dir_destination}
  cd ${climo_dir_destination}
  cp -s ${climo_dir_source}/${nc_prefix}_*_${begin_year}??_${end_year}??_climo.nc .
  if [ $? != 0 ]; then
    cd ./
    echo "ERROR (${error_num})" > ${logname}.status
    exit ${error_num}
  fi
  cd ..
}

#.........................................................
# Create local links to input climo files
#.........................................................
climo_dir_primary=climo_test
create_links_climo ${climo_dir_test} ${climo_dir_primary} ${case_test} ${test_Y1} ${test_Y2} 1

#.........................................................
# Create local links to input climo files (ref model)
#.........................................................
climo_dir_ref=climo_ref
create_links_climo ${climo_dir_ctrl} ${climo_dir_ref} ${case_ctrl} ${ctrl_Y1} ${ctrl_Y2} 2

#.........................................................
# Prepare configuration file
#.........................................................
cat > e3sm.py << EOF
import os
import numpy
from e3sm_diags.parameter.core_parameter import CoreParameter


from e3sm_diags.run import runner

short_name = '${short_test}'
test_ts = '${ts_dir_primary}'
start_yr = int('${test_Y1}')
end_yr = int('${test_Y2}')
num_years = end_yr - start_yr + 1

param = CoreParameter()

# Model
param.test_data_path = '${climo_dir_primary}'
param.test_name = '${case_test}'
param.short_test_name = '${short_test}'

# Reference
param.reference_data_path = '${climo_dir_ref}'
param.ref_name = '${case_ctrl}'
param.short_ref_name = '${short_ctrl}'
# Optionally, swap test and reference model
if False:
   param.test_data_path, param.reference_data_path = param.reference_data_path, param.test_data_path
   param.test_name, param.ref_name = param.ref_name, param.test_name
   param.short_test_name, param.short_ref_name = param.short_ref_name, param.short_test_name

# Output dir
param.results_dir = '${results_dir}'

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

EOF

#.........................................................
# calling e3sm_diag
#.........................................................
echo
echo ===== RUN E3SM DIAGS =====
echo

python -u e3sm.py

#.........................................................
# Copy output to web server
#.........................................................
echo
echo ===== COPY FILES TO WEB SERVER =====
echo

web_dir=${www}/${www_name}
rm -rf   ${web_dir}
mkdir -p ${web_dir}
if [ $? != 0 ]; then
  cd ./
  echo 'ERROR (10)' > ${logname}.status
  exit 10
fi

#.........................................................
# Copy files
#.........................................................
rsync -a --delete ${results_dir} ${web_dir}/
if [ $? != 0 ]; then
  cd ./
  echo 'ERROR (11)' > ${logname}.status
  exit 11
fi

#.........................................................
# For LCRC, change permissions of new files
#.........................................................
pushd ${web_dir}/
echo  ${web_dir}
chmod -R go+rX,go-w ${results_dir}
popd

#.........................................................
# Delete temporary workdir
#.........................................................
cd ..
if [[ "${debug,,}" != "true" ]]; then
  rm -rf ${workdir}
fi

#.........................................................
# Update status file and exit
#.........................................................

ENDTIME=$(date +%s)
ELAPSEDTIME=$(($ENDTIME - $STARTTIME))

echo ==============================================
echo "Elapsed time: $ELAPSEDTIME seconds"
echo ==============================================
rm -f ${logname}.status
echo 'OK' > ${logname}.status
exit 0
