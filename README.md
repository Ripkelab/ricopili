# Installing RICOPILI
**Source documents**: [Ricopili @ Snellius](https://docs.google.com/document/d/1VL7j-gA7wW8VCvj3YmfRvR8Ny9651WE9EcbUYE1Xg7A/edit?tab=t.0#heading=h.i7fbl6xjsyub) | [RICOPILI custom installation](https://docs.google.com/document/d/14aa-oeT5hF541I8hHsDAL_42oyvlHRC5FWR7gir4xco/edit?tab=t.0#heading=h.clyzm24wfoeu) <br>
**Author**: Alice Braun [braun@broadinstitute.org](mailto:braun@broadinstitute.org)<br> 

`Last update: 2024-12-27` <br>
This short README is intended to quickly get you started on the SURFsnellius supercomputer. <br>
A documentation for the Broad Institute HPC and a custom installation guide are underway. <br>
For a more comprehensive documentation on how to run the individual modules and interpret their output please visit: [https://sites.google.com/a/broadinstitute.org/ricopili/](https://sites.google.com/a/broadinstitute.org/ricopili/)

## Installation on SURFsnellius
### Download
Download RICOPILI from GitHub via ssh from https://github.com/Ripkelab/ricopili

<details >
<summary><strong>Trouble running Git on SURFsnellius?</strong></summary>
  
> If you are unable to download from GitHub, you need to copy your SSH key to GitHub first:  
> 
> ```bash
> ssh-keygen -t rsa -b 4096 
> ```
> When prompted, save the key in `~/.ssh/id_rsa`.  
> 
> Then, add your SSH key to the agent:  
> 
> ```bash
> ssh-add ~/.ssh/id_rsa
> eval "$(ssh-agent -s)"
> ```
> 
> Now log into GitHub in your browser and navigate to **Settings > SSH and GPG keys**.  
> Click **New SSH key** and paste the contents of your public key file:  
> 
> ```bash
> cat  ~/.ssh/id_rsa.pub
> ```
> 
> **Finally, verify the SSH config file:**  
> 
> ```bash
> vim ~/.ssh/config
> ```
> Add the following lines:  
> 
> ```
> Host github.com
>     HostName github.com
>     User git
>     IdentityFile ~/.ssh/id_rsa
> ```
> 
> Test the connection:  
> 
> ```bash
> ssh -T git@github.com
> ```

</details>


```
git clone git@github.com:Ripkelab/ricopili.git
mv ricopili/rp_bin/ ~
```
Or via wget:
```
wget https://www.dropbox.com/scl/fi/kc9m59w0btj6u4uz63clt/rp_bin.2024_Nov_21.001.tar.gz
tar -xvzf rp_bin.2024_Nov_21.001.tar.gz
```

### RICOPILI configuration on SURFsnellius
***
On SURFsnellius you may use the centrally installed dependencies on PGC DAC: <br>
`/gpfs/work5/0/pgcdac/ricopili_download/dependencies/` <br>
To swiftly install RICOPILI you need to create a file called ricopili.conf in your **home directory**. <br>
`vim ricopili.conf` and paste the following contents, replacing: `home, init, email, loloc` with your personal information. <br>

## SURFsnellius config file 
The current file runs under environment 2023 (module load 2023)
```bash
eloc /home/pgca1scz/.conda/envs/ricopili/bin/ # conda environment installation
i2loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/impute_v2
i4loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/impute_v4
hmloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/hapmap_ref/
minimac3loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/Minimac3/
minimac4loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/Minimac4/minimac4-4.1.2-Linux-x86_64/bin/ 
gmloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/genetic_map_files 
sh5loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/shapeit5 
plink2loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/plink2 
rloc module_SPACE_load_SPACE_2023;module_SPACE_load_SPACE_R/4.3.2-gfbf-2023a;_SPACE_R
ldsc_start /home/pgca1scz/.conda/envs/ricopili/bin/  # conda environment installation
sh3loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/shapeit3
tabixloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/tabix/
bcloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bcftools/bcftools-1.18
bcloc_plugins /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bcftools/bcftools-1.18/plugins/
ealoc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/eagle
bgziploc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bgzip/
ldsc_ref /gpfs/work5/0/pgcdac/ricopili_download/dependencies/ldsc
liloc /home/pgca1scz/rp_dependencies/liftover # local installation
rpac /home/pgca1scz/R/x86_64-pc-linux-gnu-library/4.3/  # local installation
p2loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/plink
shloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/shapeit
meloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/metal/
bcrloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bcftools/resources/
home /home/pgca1scz/
sloc /scratch-local
init  <YOUR_INITIALS>
email <YOUR_MAIL>
loloc <YOUR_HOME>
batch_jobcommand sbatch
batch_name -J_SPACE_XXX
batch_jobfile XXX
batch_memory_request NONE
batch_walltime --time=0-HH:MM:SS
batch_array --array=1-XXX%YYY
batch_stdout -o_SPACE_XXX/%x-%j.out
batch_stderr -e_SPACE_XXX/%x-%j.out
batch_job_dependency --dependency=afterany:XXX
batch_array_task_id $SLURM_ARRAY_TASK_ID
batch_max_parallel_jobs_per_one_array added_to_array
batch_other_job_flags --partition=genoa_SPACE_--cpus-per-task=32 # changed to genoa from rome (thin) partition as default
batch_job_output_jid Submitted_SPACE_batch_SPACE_job_SPACE_XXX
batch_ncores_per_node 32
batch_mem_per_node 56
queue custom
```
Start the script `./rp_config` from within the **`rp_bin` directory**. <br>
This is an interactive script that will take care of the installation in your computer cluster environment. <br>
If Ricopili is already installed in the system under your account, it will ask you if you wish to unset the Ricopili PATH settings first. For first time custom installation it is highly recommended to do so. The configuration script will give you the two commands you have to issue. You just need to copy/paste them into the command line. <br>
If the configuration script cannot find a configuration file (by default the script is looking for a file named rp_config.custom.txt) an empty file is created, that needs to be filled by you and/or a system-administrator. <br>
This file follows a two column structure, where variable-names are found in the first column and variable-values in the second. “###” means comments, everything after that is discarded. <br>
Whitespace can be as long as necessary, spaces are not allowed. Please use term `_SPACE_` if needed. <br>
To run the next step of the configuration on **SURFsnellius** you can copy paste the following into the `rp_config.custom.txt` at the **`rp_bin` directory**, replacing `rp_user_initials, rp_user_email, rp_logfiles`:<br>
```bash

### for details please refer to https://docs.google.com/document/d/14aa-oeT5hF541I8hHsDAL_42oyvlHRC5FWR7gir4xco/edit?usp=sharing
###          and https://docs.google.com/spreadsheets/d/1LhNYIXhFi7yXBC17UkjI1KMzHhKYz0j2hwnJECBGZk4/edit?usp=sharing
variable_name                  variable_value
----------------------------------------------
rp_dependencies_dir /gpfs/work5/0/pgcdac/ricopili_download/dependencies
R_packages_dir      /home/pgca1scz/R/x86_64-pc-linux-gnu-library/4.3/
starting_R          starting_R module_SPACE_load_SPACE_2023;module_SPACE_load_SPACE_R/4.3.2-gfbf-2023a;_SPACE_R
path_to_Perlmodules /gpfs/work5/0/pgcdac/ricopili_download/dependencies/perl_modules
path_to_scratchdir  /scratch-local
starting_ldsc       /home/pgca1scz/.conda/envs/ricopili/bin/
ldsc_reference      /gpfs/work5/0/pgcdac/ricopili_download/dependencies/ldsc
rp_user_initials    <YOUR_INITIALS>
rp_user_email       <YOUR_MAIL>
rp_logfiles         <YOUR_HOME>
----------------------------------------
----------------------------------------
---- jobarray and queueing parameters:
----------------------------------------
----------------------------------------
batch_jobcommand sbatch
batch_memory_request NONE
batch_walltime --time=0-HH:MM:SS
batch_array --array=1-XXX%YYY
batch_max_parallel_jobs_per_one_array added_to_array
batch_jobfile XXX
batch_name -J_SPACE_XXX
batch_stdout -o_SPACE_XXX/%x-%j.out
batch_stderr -e_SPACE_XXX/%x-%j.out
batch_job_dependency --dependency=afterany:XXX
batch_array_task_id $SLURM_ARRAY_TASK_ID
batch_other_job_flags  --partition=thin_SPACE_--cpus-per-task=32
batch_job_output_jid Submitted_SPACE_batch_SPACE_job_SPACE_XXX
batch_ncores_per_node 32
batch_mem_per_node 56
```
After creating these files run `./rp_config` again
Follow the instructions but do not replace the config file you have just copy-pasted.

## Bug fixes on SURFsnellius
***
> [!WARNING]  
  >  Currently, the libgsl.so.23 dependency for EIGENSOFT is not available on SURFsnellius. <br>
  >  you can install EIGENSOFT through conda/ mamba: <br>
  >  `conda install bioconda::eigensoft`
  >  and add the following to your ricopili.conf  (assuming your environment is called "ricopili")
  >  `eloc /home/$USER/.conda/envs/ricopili/bin/`

> [!WARNING]  
  >  Currently, LDSC is not available as a module on SURFsnellius. <br>
  >  you can install LDSC through conda/ mamba: <br>
  >  `conda install bioconda::ldsc`
  >  and add the following to your ricopili.conf  
  >  `ldsc_start /home/$USER/.conda/envs/ricopili/bin/`


> [!WARNING]  
> Currently, you need to manually load texlive and GCC in order for several modules to run (**e.g. pcaer**):
> ```
>   module load 2024
>   module load texlive/20230313-GCC-11.3.0
>   ``` 

## Installation in the Broad Institute cluster
***

In order to install RICOPILI on the Broad Institute HPC you'll need to run the following commands first: <br> 
```bash
#login to UGER
use UGER 

# activate Perl module 
use Perl-5.8

# add LaTeX PATH to your my.bashrc file
export PATH=/psych/ripke/share/latex_2019/bin/x86_64-linux:$PATH 

# run an interactive job to increase memory
ish
```

## Download dependencies 
If you'd like to install RICOPILI on a different cluster than the Broad Institute UGER HPC or the SURFsnellius supercomputer you're can download the depencies via the following tarball:
```bash
wget https://personal.broadinstitute.org/sripke/share_links/JeklRDhPD6FKm8Gnda7JsUOsMan2P2_Ricopili_Dependencies.1118b.tar.gz/Ricopili_Dependencies.1118b.tar.gz
wget https://personal.broadinstitute.org/sripke/share_links/JeklRDhPD6FKm8Gnda7JsUOsMan2P2_Ricopili_Dependencies.1118b.tar.gz/Ricopili_Dependencies.1118b.tar.gz.cksum.txt
# verify checksum
md5sum Ricopili_Dependencies.1118b.tar.gz
tar -xvzf Ricopili_Dependencies.1118b.tar.gz
```

On the Broad UGER cluster you may use the centrally installed dependencies on: <br>
`/psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b` <br>
To swiftly install RICOPILI you need to create a file called ricopili.conf in your **home directory**. <br>
`vim ricopili.conf` and paste the following contents, replacing: `home, init, email, loloc, sloc` with your personal information. <br>
```bash
rpac /broad/software/free/Linux/redhat_6_x86_64/pkgs/r_2.14.0/lib64/R/library
ealoc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/eagle
minimac3loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/Minimac3/
minimac4loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/Minimac4/minimac4-4.1.6-Linux-x86_64/bin/ # oct24
gmloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/genetic_map_files/  # sep23
tabixloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/tabix/
#bcloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/bcftools/bcftools-1.9_bin/
bcloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/bcftools/bcftools-1.18/  # sep23
bcloc_plugins /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/bcftools/bcftools-1.18/plugins/  # sep23
liloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/liftover/
hmloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/hapmap_ref/
shloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/shapeit
sh5loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/shapeit5/ # sep23
ldsc_start source_SPACE_/broad/software/scripts/useuse;_SPACE_use_SPACE_Anaconda;_SPACE_python_SPACE_/psych/ripke/share/gio/Ricopili_Dependencies_sr_1018d/ldsc
sh3loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/shapeit3
bgziploc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/bgzip/
p2loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/plink
plink2loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/plink2/plink2/ # sep23
i4loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/impute_v4
meloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/metal/
eloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/eigensoft/EIG-6.1.4/bin/
bcrloc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/bcftools/resources/
rloc source_SPACE_/broad/software/scripts/useuse;_SPACE_use_SPACE_R-2.15;_SPACE_R
i2loc /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/impute_v2
ldsc_ref /psych/ripke/share/gio/Ricopili_Dependencies_sr_1018d/ldsc/
home /home/unix/braun
sloc  <YOUR_SCRATCH>
init  <YOUR_INITIALS>
email <YOUR_ERMAIL>
loloc <YOUR_HOME>
batch_jobcommand qsub
batch_name -N_SPACE_XXX
batch_jobfile XXX
batch_memory_request -l_SPACE_h_vmem=XXXg
batch_walltime -l_SPACE_h_rt=HH:MM:SS
batch_array -t_SPACE_1-XXX
batch_stdout -o_SPACE_XXX
batch_stderr -e_SPACE_XXX
batch_job_dependency -hold_jid_SPACE_XXX
batch_array_task_id $SGE_TASK_ID
batch_max_parallel_jobs_per_one_array -tc_SPACE_YYY
batch_other_job_flags -v_SPACE_PATH,rp_perlpackages,RPHOME_SPACE_-l_SPACE_h=!hw-uger-*
batch_job_output_jid Your_SPACE_job-array_SPACE_XXX.1-YYY:1_SPACE("ZZZ")_SPACE_has_SPACE_been_SPACE_submitted,
batch_ncores_per_node NA
batch_mem_per_node NA
queue custom
```

Start the script `./rp_config` from within the **`rp_bin` directory**. <br>
This is an interactive script that will take care of the installation in your computer cluster environment. <br>
If Ricopili is already installed in the system under your account, it will ask you if you wish to unset the Ricopili PATH settings first. For first time custom installation it is highly recommended to do so. The configuration script will give you the two commands you have to issue. You just need to copy/paste them into the command line. <br>
If the configuration script cannot find a configuration file (by default the script is looking for a file named rp_config.custom.txt) an empty file is created, that needs to be filled by you and/or a system-administrator. <br>
This file follows a two column structure, where variable-names are found in the first column and variable-values in the second. “###” means comments, everything after that is discarded. <br>
Whitespace can be as long as necessary, spaces are not allowed. Please use term `_SPACE_` if needed. <br>
To run the next step of the configuration on **Broad UGER** you can copy paste the following into the `rp_config.custom.txt` at the **`rp_bin` directory**, replacing `rp_user_initials, rp_user_email, rp_logfiles`:<br>

```bash
### for details please refer to https://docs.google.com/document/d/14aa-oeT5hF541I8hHsDAL_42oyvlHRC5FWR7gir4xco/edit?usp=sharing
###          and https://docs.google.com/spreadsheets/d/1LhNYIXhFi7yXBC17UkjI1KMzHhKYz0j2hwnJECBGZk4/edit?usp=sharing
variable_name                  variable_value
----------------------------------------------
rp_dependencies_dir  /psych/ripke/share/gio/Ricopili_Dependencies_sr_1118b/                             
R_packages_dir       /broad/software/free/Linux/redhat_6_x86_64/pkgs/r_2.14.0/lib64/R/library
starting_R           source_SPACE_/broad/software/scripts/useuse;_SPACE_use_SPACE_R-2.15;_SPACE_R
path_to_Perlmodules  /psych/ripke/share/gio/Ricopili_Dependencies_sr_1018d/perl_modules
path_to_scratchdir   /psych/genetics_data/ripke/sloc/
starting_ldsc        source_SPACE_/broad/software/scripts/useuse;_SPACE_use_SPACE_.anaconda-2.1.0-no-mkl;_SPACE_python_SPACE_/psych/ripke/share/gio/Ricopili_Dependencies_sr_1018d/ldsc
ldsc_reference       /psych/ripke/share/gio/Ricopili_Dependencies_sr_1018d/ldsc
rp_user_initials      ab                             
rp_user_email         braun@broadinstitute.org                           
rp_logfiles           /home/unix/braun/                      
----------------------------------------
----------------------------------------
---- jobarray and queueing parameters: 
----------------------------------------
----------------------------------------
batch_jobcommand                    qsub             
batch_memory_request                -l_SPACE_h_vmem=XXXg             
batch_walltime                      -l_SPACE_h_rt=HH:MM:SS            
batch_array                         -t_SPACE_1-XXX             
batch_max_parallel_jobs_per_one_array            -tc_SPACE_YYY
batch_jobfile                                    XXX
batch_name                                       -N_SPACE_XXX
batch_stdout                                     -o_SPACE_XXX
batch_stderr                                     -e_SPACE_XXX
batch_job_dependency                             -hold_jid_SPACE_XXX
batch_array_task_id                              $SGE_TASK_ID
batch_other_job_flags                           -v_SPACE_PATH,rp_perlpackages,RPHOME_SPACE_-l_SPACE_hostname=uger-c*
batch_job_output_jid                             Your_SPACE_job-array_SPACE_XXX.1-YYY:1_SPACE("ZZZ")_SPACE_has_SPACE_been_SPACE_submitted,
batch_ncores_per_node        NA
batch_mem_per_node           NA
```

> [!WARNING]  
  >  Currently, LDSC is not available as a module on Broad UGER. <br>
  > You may need to run the pipeline (post_imp_navi, test_navi) with the flag --noldsc