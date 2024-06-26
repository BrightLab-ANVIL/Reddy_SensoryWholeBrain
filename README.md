## Simultaneous cortical, subcortical, and brainstem mapping of sensory activation
This analysis code is shared alongside the manuscript found here: https://doi.org/10.1101/2024.04.11.589099

Relevant data files can be found on OpenNeuro: https://doi.org/10.18112/openneuro.ds005009.v1.0.0

## Code
### MRI pre-processing and registration
All anatomical and functional MRI pre-processing and registration scripts can be found at https://github.com/BrightLab-ANVIL/PreProc_BRAIN

Detailed information on tedana and multi-echo fMRI analysis can be found at https://tedana.readthedocs.io

### Subject-level fMRI analysis
x.GLM_REML_ICA.sh: Subject-level modeling

### Group-level fMRI analysis
x.GLM_Group_WholeBrain.sh: Group-level modeling for whole-brain analyses

x.GLM_Group_Brainstem.sh: Group-level modeling for brainstem-specific analyses
