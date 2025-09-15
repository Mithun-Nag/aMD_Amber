#!/bin/bash
#SBATCH --job-name=aMD_6ONI
#SBATCH --mail-user=mithun.nag.karadi.giridhar@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1                    # Only 1 task needed (no MPI here)
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=5-00:00:00
#SBATCH --gres=gpu:nvidia_rtx_a6000:1 # Request 1 GPU
#SBATCH --partition=batch_gpu
#SBATCH --account=csb_gpu_acc
#SBATCH --output=aMD_out_%j.log
#SBATCH --error=aMD_err_%j.log

module purge
module load StdEnvACCRE/2023
module load gcc/12.3 openmpi/4.1.5 cuda/12.2
module load ambertools/25.0
module load scipy-stack/2025a
module load amber/24

perl production.pl > PRODUCTION.OUT