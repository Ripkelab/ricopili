# RICOPILI
**Authors**: Stephan Ripke [sripke@broadinstitute.org](mailto:sripke@broadinstitute.org) | Alice Braun [braun@broadinstitute.org](mailto:braun@broadinstitute.org)<br> 

`Last update: 2025-03-03` <br>

> [!NOTE]  
>This short README is designed to help you quickly set up and use the RICOPILI pipeline with centrally deployed dependencies and imputation references on the national Dutch supercomputer [SURFsnellius](https://www.surf.nl/en/services/snellius-the-national-supercomputer). <br>
>For a more comprehensive documentation on how to install RICOPILI and its dependencies, run the modules and interpret their output please visit: [sites.google.com/a/broadinstitute.org/ricopili/](https://sites.google.com/a/broadinstitute.org/ricopili/)

## Table of Contents  
1. [Download and dependencies](#Download-and-dependencies) <br> 
2. [Installation on SURFsnellius](#installation-on-surfsnellius) <br>
3. [Quick tutorial](#quick-tutorial)

# Download and dependencies 
Download RICOPILI from GitHub via ssh from https://github.com/Ripkelab/ricopili <br>

```bash
git clone git@github.com:Ripkelab/ricopili.git
mv ricopili/rp_bin/ ~
```
<details >
<summary><strong>Trouble running Git?</strong></summary>
  
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
<br>
Or via wget:

```bash
wget https://personal.broadinstitute.org/braun/sharing/rp_bin.2025_Feb_20.001.tar.gz 
wget https://personal.broadinstitute.org/braun/sharing/rp_bin.2025_Feb_20.001.md5.cksum 

# verify checksum
md5sum rp_bin.2025_Feb_20.001.md5.cksum 
tar -xvzf rp_bin.2025_Feb_20.001.tar.gz 
```

> [!NOTE]  
> We recommend to install an additional set of software (mostly R packages) via conda/mamba:
```bash
# download conda yaml file to build environment with all necessary R packages
wget https://personal.broadinstitute.org/braun/sharing/rp_env_0225b.yaml 
mamba env create -n rp_env -f rp_env.yaml
```

> [!NOTE]  
> If you'd like to install RICOPILI on a different cluster than the Broad UGER or the SURFsnellius supercomputer we recommend downloading the depency tarball:
```bash
wget https://personal.broadinstitute.org/braun/sharing/ricopili_dependencies_0225b.tar.gz 
wget https://personal.broadinstitute.org/braun/sharing/ricopili_dependencies_0225b.md5.cksum

# verify checksum
md5sum ricopili_dependencies_0225b.tar.gz
tar -xvzf ricopili_dependencies_0225b.tar.gz
```


# Installation on SURFsnellius

On SURFsnellius you may use the centrally installed dependencies on PGC DAC: <br>
`/gpfs/work5/0/pgcdac/ricopili_download/dependencies/` <br>
To swiftly install RICOPILI you need to create a file called ricopili.conf in your **home directory**. <br>
Edit `ricopili.conf` via your preferred text editor and paste the following contents, replacing: `init` and `email` with your personal information. <br>

## ricopili.conf file 
```bash
eloc /home/$USER/.conda/envs/rp_env/bin/
i2loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/impute_v2
i4loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/impute_v4
hmloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/hapmap_ref/
minimac3loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/Minimac3/
minimac4loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/Minimac4/minimac4-4.1.2-Linux-x86_64/bin/
gmloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/genetic_map_files 
sh5loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/shapeit5 
plink2loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/plink2/plink2 
rloc /home/$USER/.conda/envs/rp_env/bin/R  
ldsc_start /home/$USER/.conda/envs/ldsc/bin/ # env which runs python 2.7 - installed seperately 
sh3loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/shapeit3
tabixloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/tabix/
bcloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bcftools/bcftools-1.18
bcloc_plugins /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bcftools/bcftools-1.18/plugins/
ealoc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/eagle
bgziploc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bgzip/
ldsc_ref /gpfs/work5/0/pgcdac/ricopili_download/dependencies/ldsc/
liloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/liftover
rpac /home/$USER/.conda/envs/rp_env/lib/R/library
p2loc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/plink
shloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/shapeit
meloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/metal/
bcrloc /gpfs/work5/0/pgcdac/ricopili_download/dependencies/bcftools/resources/
home /home/$USER/
sloc /scratch-local
init <YOUR_INITIALS>
email <YOUR_EMAIL>
loloc /home/$USER/
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
batch_other_job_flags --partition=genoa_SPACE_--cpus-per-task=32
batch_job_output_jid Submitted_SPACE_batch_SPACE_job_SPACE_XXX
batch_ncores_per_node 32
batch_mem_per_node 56
queue custom
```

Start the script `./rp_config` from within the **`rp_bin` directory**. <br>
This is an interactive script that will take care of the installation in your computer cluster environment. <br>
If RICOPILI is already installed in the system under your account, it will ask you if you wish to unset the Ricopili PATH settings first. For first time custom installation it is highly recommended to do so. <br>
The configuration script will give you the two commands you have to issue. You just need to copy/paste them into the command line. <br>

## SURFsnellius rp_config.custom.txt file 
If the configuration script cannot find a configuration file (by default the script is looking for a file named `rp_config.custom.txt`) an empty file is created, that needs to be filled by you and/or a system-administrator. <br>
This file follows a two column structure, where variable-names are found in the first column and variable-values in the second. “###” are comments. <br>
Whitespace can be as long as necessary, spaces are not allowed. Please use term `_SPACE_` if needed. <br>
To run the next step of the configuration on **SURFsnellius** you can copy paste the following into the `rp_config.custom.txt` at the **`rp_bin` directory**, replacing `rp_user_initials, rp_user_email, rp_logfiles`:<br>

```bash
### for details please refer to https://docs.google.com/document/d/14aa-oeT5hF541I8hHsDAL_42oyvlHRC5FWR7gir4xco/edit?usp=sharing
###          and https://docs.google.com/spreadsheets/d/1LhNYIXhFi7yXBC17UkjI1KMzHhKYz0j2hwnJECBGZk4/edit?usp=sharing
variable_name                  variable_value
----------------------------------------------
rp_dependencies_dir /gpfs/work5/0/pgcdac/ricopili_download/dependencies
R_packages_dir      /home/$USER/R/x86_64-pc-linux-gnu-library/4.3/
starting_R          starting_R module_SPACE_load_SPACE_2023;module_SPACE_load_SPACE_R/4.3.2-gfbf-2023a;_SPACE_R
path_to_Perlmodules /gpfs/work5/0/pgcdac/ricopili_download/dependencies/perl_modules
path_to_scratchdir  /scratch-local
starting_ldsc       /home/$USER/.conda/envs/rp_env/bin/
ldsc_reference      /gpfs/work5/0/pgcdac/ricopili_download/dependencies/ldsc
rp_user_initials    <YOUR_INITIALS>
rp_user_email       <YOUR_MAIL>
rp_logfiles         /home/$USER/
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
Follow the instructions but **do not replace the config file** you have just copy-pasted.

## Known issues and bug fixes on SURFsnellius
***
> [!WARNING]  
  >  1. Currently, the libgsl.so.23 dependency for EIGENSOFT is not available on SURFsnellius. <br>
  >  you can install EIGENSOFT through conda/ mamba: <br>
  >  `mamba install bioconda::eigensoft`
  >  and add the following to your ricopili.conf  (assuming your environment is called "rp_env"): <br>
  >  `eloc /home/$USER/.conda/envs/rp_env/bin/`<br><br>
  > 2. LDSC is not available as a module on SURFsnellius. <br>
  >  As it uses Python 2.7 you can install LDSC into a new environemnt through conda/ mamba: <br>
  >  `mamba create -n ldsc python=2.7.15 -c conda-forge -c bioconda ldsc`
  >  try to start ldsc manually to see if it runs and then add the following to your rp_config file:
  >  `ldsc_start /home/$USER/.conda/envs/ldsc/bin/` <br><br>
  > 3. Currently, you need to manually load texlive and GCC in order for several modules to run (**e.g. pcaer**).
  > You can also add this to your bashrc directly: <br>
  > `module load 2022 \module load texlive/20230313-GCC-11.3.0`



# Quick tutorial
## Quality control module (pre-imputation)
This module performs SNP and Sample quality control (QC) of multiple datasets in parallel. It's highly recommend to go through [RICOPILI tutorial](https://docs.google.com/document/d/1ux_FbwnvSzaiBVEwgS7eWJoYlnc_o0YHFb07SPQsYjI/edit?tab=t.0#heading=h.tkgxq8x9kt6n) before using this module. <br>
All modules have a `--help` flag to show all available functions and options.

### Input Requirements
1. Binary PLINK files (bed/bim/fam), multiple datasets in working directory are allowed
2. Phenotypes coded as 1 (control) or 2 (case)
3. Allele names A,C,G,T
Genome build hg16, hg17, hg18, hg19 or hg38 are supported <br>
To start genomic quality control run the following command:

```bash
#start qc module
preimp_dir --dis scz --pop eur --out outname 

# to edit file QC cycle and naming
vim *.names 

# resubmit
preimp_dir --dis scz --pop eur --out outname
```
## Principal component module
This module takes PLINK binary output file from the Preimputation/QC step and calculates the principal components, determines overlapping samples, determines which covariates are associated with the genotype data, and generates PCA plots a to check the ancestry of the cohorts and to exclude ancestry outliers. 
To conduct a princpal component analysis run the following command:

```bash 
# Run pca of QUed sample
pcaer --out output_name bfile-qc.bim  
```

## Imputation module
This module performs imputation on binary PLINK datasets generated by the Preimputation-QC step. The output is a set of dosage probabilities for all markers in a user-specified reference panel (there are a number of reference panels to choose from including MHC classical alleles and amino acids, HapMap, HRC, and 1000 Genomes).

To conduct genotype imputation based on your reference run following command:

```bash
impute_dirsub --refdir imputation_reference --out outname
```

## GWAS and meta-analysis module (post-imputation)
This module performs association analyses for common variants from imputed dosage data for each dataset QC'd in the Preimputation step and then does a final meta-analysis using METAL. Population stratification is accounted for using principal components generated from the PCA step.

```bash
postimp_navi --out OUTNAME --mds prune.bfile.cobg.outname_pca.menv.mds_cov --coco 1,2,3,4,5,6 --addout run1
```

