# running_first_sim

In this directory all the necessary files are present to run a small COLA simulation with FML. The user needs only to set the correct paths in the files. There are 3 paths the user will need to have ready. One is the path to the parent directory of the running_first_sim repository, for which there is the placeholder <root_path> appearing in the files. The second is the path to the parent directory of the FML repository, for which there is a placeholder <FML_path>. The third is the path to the parent directory of the miniconda folder (assuming this is how the user installed the cola environment), for which there is the placeholder <miniconda_path>.

Here are all the places that require editing:

1. The transferinfo.txt file in the first line will need <root_path> replaced by the path to the parent directory of the running_first_sim repository. This will tell FML where to find the transfer function files.

2. The parameter_file.lua will require 2 lines edited: <root_path> must be similarly replaced in the settings "ic_input_filename" and "output_folder" (lines 16 and 18 respectively, 1-indexed). This will tell FMl where to find the transfer info file, and where to output the power spectra respectively.

3. The 1x32_96.sh file is configured for running on the SeaWulf cluster on the nodes with 96 Intel Sapphire Rapids cores (the queue is hbm-short-96core). Others may adapt to their respective clusters. Aside from that there are 5 paths that must be edited: the "output" and "error" paths (lines 5 and 6) must have <root_path> replaced as in the previous steps, and the same for the "param_file" variable (line 11). This will tell slurm where to store the output and error files regarding the job itself, and what file FML will run. Next, in the "colasolver" variable (line 10) the user must replace the <FML_path> with the path to the parent directory of where FML is installed. This will tell slurm where the COLA solver inside FML is installed. Note that parameter_file.lua is configured to run with the version of FML here: https://github.com/SBU-COLA-2024/FML . Should one use a different version of FML they will need to modify the lua file to account for the different settings necessary in different versions of FML. Finally, in line 14 one must substitute <miniconda_path> with the path to the parent directory of their miniconda folder. This directory is where miniconda is installed, assuming the user installed the cola environment using miniconda.

Once these paths are all set one should be able to submit the simulation. Make sure the "cola" environment is activated before submitting (and that slurm is loaded if using SeaWulf). Then simply use the "sbatch" command followed by the path to the the 1x32_96.sh file:

sbatch <root_path>/1x32.sh

The simulation should take roughly 2 minutes on a single core, and the test_run.out file should show the simulation going through all 51 timesteps and end in memory and time logging information, adding up to very roughly ~5000 lines. The output folder should have files pertaining to redshift 0.000 as well indicating the simulation completed the final timestep.
